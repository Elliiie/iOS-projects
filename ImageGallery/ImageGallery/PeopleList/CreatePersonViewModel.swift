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
    
    private let mode: CreatePersonView.Mode
    private let completion: (Person) -> Void
    
    init(mode: CreatePersonView.Mode, completion: @escaping (Person) -> Void) {
        self.mode = mode
        self.completion = completion
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
        enableButton = !name.isEmpty && !number.isEmpty && imageData != nil
    }
}
