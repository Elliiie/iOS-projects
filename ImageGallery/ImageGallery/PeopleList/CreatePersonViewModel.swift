//
//  CreatePersonViewModel.swift
//  ImageGallery
//
//  Created by Elena Georgieva on 14.04.24.
//

import Foundation
import SwiftUI
import PhotosUI

class CreatePersonViewModel: ObservableObject {
    
    @Published var name: String = "" {
        didSet {
            handleInput()
        }
    }
    
    @Published var number: String = "" {
        didSet {
            handleInput()
        }
    }
    
    @Published var imageData: Data? = nil {
        didSet {
            handleInput()
        }
    }
    
    @Published var pickerItem: PhotosPickerItem? = nil
    
    @Published var enableButton: Bool = false
    
    private let completion: (Person) -> Void
    
    init(completion: @escaping (Person) -> Void) {
        self.completion = completion
    }
    
    func observeSelectedImage() {
        Task { @MainActor in
            imageData = try? await pickerItem?.loadTransferable(type: Data.self)
        }
    }
    
    func complete() {
        completion(Person(name: name, number: number, imageData: imageData!))
    }
    
    private func handleInput() {
        enableButton = !name.isEmpty && !number.isEmpty && imageData != nil
    }
}
