//
//  BrandsListView.swift
//  CarsLib
//
//  Created by Elena Georgieva on 11.06.24.
//

import SwiftUI
import SwiftData

struct BrandsListView: View {
    
    @StateObject var viewModel: BrandsListViewModel
    
    init(modelContext: ModelContext) {
        self._viewModel = .init(wrappedValue: .init(modelContext: modelContext))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List(viewModel.carBrands.indices) { brandIndex in
                    VStack {
                        HStack {
                            viewModel.carBrands[brandIndex].image
                                .resizable()
                                .frame(width: 60, height: 50)
                            
                            Text(viewModel.carBrands[brandIndex].rawValue)
                                .bold()
                            
                            Spacer()
                            
                            Image(systemName: viewModel.showSavedModels[brandIndex] ?  "chevron.down" : "chevron.up")
                            
                        }
                        .onTapGesture {
                            viewModel.showSavedModels[brandIndex].toggle()
                        }
                        
                        if viewModel.showSavedModels[brandIndex] {
                            VStack(alignment: .leading) {
                                if let models = viewModel.savedCarModels[
                                    viewModel.carBrands[brandIndex]
                                ] {
                                    ForEach(models) { model in
                                        HStack {
                                            Text(model.model)
                                                .foregroundStyle(Color.orange)
                                                .underline()
                                            
                                            Spacer()
                                        }
                                        .padding([.top, .bottom], 4)
                                        .onTapGesture {
                                            viewModel.selectedCar = model
                                            
                                            viewModel.showCarDetails.toggle()
                                        }
                                        .onLongPressGesture {
                                            viewModel.selectedCar = model
                                            
                                            viewModel.showAlert.toggle()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .toolbar {
                HStack {
                    Spacer()
                    
                    if viewModel.filterApplied != nil {
                        Button {
                            viewModel.removeFilter()
                        } label: {
                            Text("Remove filter")
                        }
                    }
                    
                    Button {
                        viewModel.showFilters = true
                    } label: {
                        Text("Filters")
                    }
                    
                    Button {
                        viewModel.showAddCar = true
                    } label: {
                        Image(systemName: "plus")
                    }
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
            .popover(isPresented: $viewModel.showCarDetails, content: {
                if let selectedCar = viewModel.selectedCar {
                    CarInfoView(car: selectedCar) {
                        viewModel.carClicked(selectedCar)
                    }
                }
            })
            .popover(isPresented: $viewModel.showFilters, content: {
                FiltersView(completion: { filter in
                    viewModel.filterApplied = filter
                    viewModel.filter()
                })
            })
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
