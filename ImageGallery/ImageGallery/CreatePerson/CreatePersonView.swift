//
//  CreatePersonView.swift
//  ImageGallery
//
//  Created by Elena Georgieva on 14.04.24.
//

import SwiftUI
import PhotosUI

struct CreatePersonView: View {
    
    enum Layout {
        static let PhotosPickerImageWidth: CGFloat = 35
        static let PhotosPickerImageHeight: CGFloat = 30
        static let ImageSize: CGFloat = 100
        static let ShadowRadius: CGFloat = 6
        static let ImageTextSpace: CGFloat = 50
        static let TextFieldHeight: CGFloat = 40
    }
    
    enum Mode {
        case create
        case edit(Person)
    }
    
    @StateObject var viewModel: CreatePersonViewModel
    
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
            VStack {
                if let selectedImage = viewModel.imageData {
                    Image(uiImage: UIImage(data: selectedImage) ?? UIImage())
                        .resizable()
                    
                } else  {
                    PhotosPicker(selection: $viewModel.pickerItem, matching: .images) {
                        Image(systemName: "camera")
                            .resizable()
                            .frame(width: Layout.PhotosPickerImageWidth, height: Layout.PhotosPickerImageHeight)
                    }
                }
            }
                .frame(width: Layout.ImageSize, height: Layout.ImageSize)
                .background(.white)
                .clipShape(.circle)
                .shadow(radius: Layout.ShadowRadius)
                .padding()
            
            if viewModel.canEditImage {
                Button("Edit image") {
                    viewModel.pickerPresented.toggle()
                }
                .photosPicker(isPresented: $viewModel.pickerPresented, selection: $viewModel.pickerItem, matching: .images)
            }
            
            Spacer()
                .frame(height: Layout.ImageTextSpace)
            
            VStack {
                TextField("Name", text: $viewModel.name)
                    .frame(height: Layout.TextFieldHeight)

                Divider()
                
                TextField("Number", text: $viewModel.number)
                    .keyboardType(.decimalPad)
                    .frame(height: Layout.TextFieldHeight)
                
                Divider()
                
                if viewModel.birthdatePickerVisible {
                    DatePicker("Birthdate", selection: $viewModel.birthdate, in: ...Date(), displayedComponents: .date)
                        .foregroundColor(.color(with: "BDBDBD"))
                    
                    Divider()
                }
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
