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
            
            HStack {
                Picker("", selection: $viewModel.selectedCardBrand) {
                    ForEach(CarBrand.AllNames, id: \.self) { brand in
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
        .onAppear {
            viewModel.onAppear()
        }
    }
}
