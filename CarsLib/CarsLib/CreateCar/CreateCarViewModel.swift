//
//  CreateCarViewModel.swift
//  CarsLib
//
//  Created by Elena Georgieva on 9.05.24.
//

import Foundation
import SwiftUI
import PhotosUI

class CreateCarViewModel: ObservableObject {
    
    @Published var selectedCardBrand: String = CarHelper.shared.brands[0] 
    
    @Published var model: String = "" {
        didSet {
            handleInput()
        }
    }
    @Published var productionDate: Date = Date() {
        didSet {
            handleInput()
        }
    }
    @Published var power: String = "" {
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
    
    let mode: CreateCarView.Mode
    let completion: (Car) -> Void
    
    init(mode: CreateCarView.Mode, completion: @escaping (Car) -> Void) {
        self.mode = mode
        self.completion = completion
    }
    
    func onAppear() {
        guard case .edit(let car) = mode else { return }
        
        selectedCardBrand = car.brand
        model = car.model
        productionDate = car.productionYear
        power = String(car.power)
        imageData = car.brandImage

    }
    func observeSelectedImage() {
        Task { @MainActor in
            imageData = try? await pickerItem?.loadTransferable(type: Data.self)
        }
    }
    
    func complete() {
        guard let power = Int(power), let imageData else { return }
        completion(Car(model: model, brand: selectedCardBrand, productionYear: productionDate, power: power, clickedCount: 0, brandImage: imageData))
    }
    
    private func handleInput() {
        enableButton = !model.isEmpty && !power.isEmpty && imageData != nil
    }
}
