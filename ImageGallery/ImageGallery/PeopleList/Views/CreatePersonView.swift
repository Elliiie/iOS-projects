//
//  CreatePersonView.swift
//  ImageGallery
//
//  Created by Elena Georgieva on 14.04.24.
//

import SwiftUI
import PhotosUI

struct CreatePersonView: View {
    
    enum Mode {
        case create
        case edit(Person)
    }
    
    @StateObject var viewModel: CreatePersonViewModel
        
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button("Add") {
                    viewModel.complete()
                }
                .disabled(!viewModel.enableButton)
                .padding()
            }
            VStack {
                if let selectedImage = viewModel.imageData {
                    Image(uiImage: UIImage(data: selectedImage) ?? UIImage())
                        .resizable()
                    
                } else  {
                    PhotosPicker(selection: $viewModel.pickerItem, matching: .images) {
                        Text("Load image")
                            .padding()
                    }
                }
            }
                .frame(width: 100, height: 100)
                .background(.white)
                .clipShape(.circle)
                .shadow(radius: 6)
                .padding()
            
            Spacer()
                .frame(height: 50)
            
            VStack {
                TextField("Name", text: $viewModel.name)
                    .frame(height: 40)

                Divider()
                
                TextField("Number", text: $viewModel.number)
                    .keyboardType(.decimalPad)
                    .frame(height: 40)
                
                Divider()
                
                DatePicker("Birthdate", selection: $viewModel.birthdate, in: ...Date(), displayedComponents: .date)
                    .foregroundColor(.gray)
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
            viewModel.onAppear()
        }
        .onChange(of: viewModel.pickerItem) {
            viewModel.observeSelectedImage()
        }
    }
}

#Preview {
    CreatePersonView(viewModel: .init(mode: .create, completion: { _ in
        
    }))
}
