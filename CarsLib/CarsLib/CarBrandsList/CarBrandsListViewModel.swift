//
//  CarBrandsList.swift
//  CarsLib
//
//  Created by Elena Georgieva on 7.05.24.
//

import Foundation
import SwiftUI
import SwiftData

class CarBrandsListViewModel: ObservableObject {
    
    @Published var carsData: [Car] = []
    @Published var selectedCar: Car?
    
    @Published var showAddCar: Bool = false
    @Published var showEditCar: Bool = false
    
    @Published var showAlert: Bool = false
    
    private var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func onAppear() {
        fetchData()
    }
    
    func addCar(_ car: Car) {
        carsData.append(car)
        carsData.sort { $0.brand < $1.brand }
        
        modelContext.insert(car)
        
        showAddCar = false
    }
    
    func updateCar(_ car: Car) {
        selectedCar?.brand = car.brand
        selectedCar?.model = car.model
        selectedCar?.brandImage = car.brandImage
        selectedCar?.power = car.power
        selectedCar?.productionYear = car.productionYear
        
        showEditCar = false
    }
    
    func deleteCar(_ car: Car?) {
        guard let car else { return }
        carsData.removeAll { $0 == car }
        modelContext.delete(car)
    }
    
    func carClicked(_ car: Car) {
        car.clickedCount += 1
    }
    
    private func fetchData() {
        do {
            let descriptor = FetchDescriptor<Car>(sortBy: [SortDescriptor(\.brand)])
            carsData = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
}
