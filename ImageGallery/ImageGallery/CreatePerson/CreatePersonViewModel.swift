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
    
    @Published var birthdate: Date = Date() {
        didSet {
            handleInput()
        }
    }
    
    @Published var pickerItem: PhotosPickerItem? = nil
    
    @Published var enableButton: Bool = false
                
    @Published var pickerPresented: Bool = false
    
    @Published var birthdatePickerVisible: Bool = true
    
    @Published var canEditImage: Bool = false
    
    private let mode: CreatePersonView.Mode
    private let completion: (Person) -> Void
    
    init(mode: CreatePersonView.Mode, completion: @escaping (Person) -> Void) {
        self.mode = mode
        self.completion = completion
        
        guard case .edit = mode else { return }
        birthdatePickerVisible = false
        canEditImage = true
    }
    
    func onAppear() {
        guard case .edit(let person) = mode else { return }
        name = person.name
        number = person.number
        imageData = person.imageData
        birthdate = person.birthdate
    }
    
    func observeSelectedImage() {
        Task { @MainActor in
            imageData = try? await pickerItem?.loadTransferable(type: Data.self)
        }
    }
    
    func complete() {
        completion(Person(name: name, number: number, imageData: imageData!, birthdate: birthdate, creationDate: Date()))
    }
    
    private func handleInput() {
        switch mode {
        case .create:
            enableButton = !name.isEmpty && !number.isEmpty && imageData != nil
        case .edit(let person):
            enableButton = (!name.isEmpty && person.name != name) || (!number.isEmpty && person.number != number) || (imageData != nil && person.imageData != imageData)
        }
        
    }
}
