//
//  CarBrandsListView.swift
//  CarsLib
//
//  Created by Elena Georgieva on 7.05.24.
//

import SwiftUI
import SwiftData

struct CarBrandsListView: View {
    
    @StateObject var viewModel: CarBrandsListViewModel
    
    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: CarBrandsListViewModel(modelContext: modelContext))
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.carsData) { car in
                        NavigationLink {
                            CarInfoView(car: car) {
                                viewModel.carClicked(car)
                            }
                        } label: {
                            VStack {
                                Image(uiImage: UIImage(data: car.brandImage) ?? UIImage())
                                    .resizable()
                                    .foregroundColor(.orange)
                                    .aspectRatio(1.05, contentMode: .fill)
                                    .onLongPressGesture {
                                        viewModel.selectedCar = car
                                        
                                        viewModel.showAlert.toggle()
                                    }
                                
                                Text(car.brand)
                                    .font(.headline)
                                
                                Text(car.model)
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Cars")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    viewModel.showAddCar = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .popover(isPresented: $viewModel.showAddCar) {
                CreateCarView(viewModel: .init(mode: .create, completion: viewModel.addCar(_:)))
            }
            .popover(isPresented: $viewModel.showEditCar) {
                if let selectedCar = viewModel.selectedCar {
                    CreateCarView(viewModel: .init(mode: .edit(selectedCar), completion: viewModel.updateCar(_:)))
                }
            }
            .actionSheet(isPresented: $viewModel.showAlert, content: {
                let title = "Update or delete \(viewModel.selectedCar!.brand) \(viewModel.selectedCar!.model)"
                return ActionSheet(title: Text(title), buttons: [
                    .default(Text("Update"), action: {
                        viewModel.showEditCar.toggle()
                    }),
                    .destructive(Text("Delete"), action: {
                        viewModel.deleteCar(viewModel.selectedCar)
                    }),
                    .cancel()
                ])
            })
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}
