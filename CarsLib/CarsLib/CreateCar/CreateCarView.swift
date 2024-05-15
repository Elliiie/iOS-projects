//
//  CreateCarView.swift
//  CarsLib
//
//  Created by Elena Georgieva on 7.05.24.
//

import SwiftUI
import PhotosUI

struct CreateCarView: View {
    
    enum Mode {
        case create
        case edit(Car)
    }
    
    @StateObject var viewModel: CreateCarViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button("Done") {
                    viewModel.complete()
                }
                .disabled(!viewModel.enableButton)
                .padding()
            }
            
            PhotosPicker(selection: $viewModel.pickerItem, matching: .images) {
                if let imageData = viewModel.imageData, let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .foregroundColor(.primary)
                        .aspectRatio(1.15, contentMode: .fit)

                } else {
                    Text("Import brand image")
                        .underline()
                }
            }
            
            Spacer()
                .frame(height: 50)
            
            HStack {
                Picker("", selection: $viewModel.selectedCardBrand) {
                    ForEach(CarHelper.shared.brands, id: \.self) { brand in
                        Text(brand)
                    }
                }
                
                TextField("Model", text: $viewModel.model)
            }
            
            DatePicker("Production date", selection: $viewModel.productionDate, in: ...Date(), displayedComponents: .date)
            
            TextField("Power", text: $viewModel.power)
                .keyboardType(.decimalPad)
            
            Spacer()
        }
        .padding()
        .onChange(of: viewModel.pickerItem) {
            viewModel.observeSelectedImage()
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}
