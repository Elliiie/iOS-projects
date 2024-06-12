//
//  BrandListViewModel.swift
//  CarsLib
//
//  Created by Elena Georgieva on 11.06.24.
//

import Foundation
import SwiftUI
import SwiftData

class BrandsListViewModel: ObservableObject {
    
    @Published var carBrands: [CarBrand] = CarBrand.All
    
    @Published var showSavedModels: [Bool] = .init(repeating: false, count: CarBrand.All.count)
    
    @Published var savedCarModels: [CarBrand: [Car]]
            
    @Published var selectedCar: Car?

    @Published var showAlert: Bool = false
    
    @Published var showAddCar: Bool = false
    
    @Published var showEditCar: Bool = false
    
    @Published var showCarDetails: Bool = false
    
    @Published var showFilters: Bool = false
    
    @Published var filterApplied: FiltersView.Filter?
    
    private var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        
        self.savedCarModels = CarBrand.All.reduce([:], { partialResult, brand in
            return [brand: []]
        })
    }
    
    func onAppear() {
        fetchData()
    }
    
    func addCar(_ car: Car) {
        addCarModel(for: CarBrand(rawValue: car.brand), car: car)
        filter()
        
        modelContext.insert(car)
        
        showAddCar = false
    }
    
    func updateCar(_ car: Car) {
        selectedCar?.brand = car.brand
        selectedCar?.model = car.model
        selectedCar?.power = car.power
        selectedCar?.productionYear = car.productionYear
        
        filter()
        
        showEditCar = false
    }
    
    func deleteCar(_ car: Car?) {
        guard let car, let brand = CarBrand(rawValue: car.brand) else { return }
        savedCarModels[brand]?.removeAll { $0 == car }
        modelContext.delete(car)
    }
    
    func carClicked(_ car: Car) {
        car.clickedCount += 1
    }
    
    func filter() {
        guard let filterApplied else { return }
        switch filterApplied {
        case .power(let power):
            guard let power = Int(power) else { return }
            _ = savedCarModels.map { car in
                savedCarModels.updateValue(car.value.filter({ $0.power == power || $0.power == power - 10 || $0.power == power + 10 }), forKey: car.key)
            }
            
        case .productionYear(let year):
            guard let year = Int(year) else { return }
            _ = savedCarModels.map { car in
                savedCarModels.updateValue(car.value.filter({ $0.productionYear.year == year}), forKey: car.key)
            }
        }
        
        showFilters = false
    }
    
    func removeFilter() {
        filterApplied = nil
        
        savedCarModels.removeAll()
        
        fetchData()
    }
    
    private func fetchData() {
        do {
            let descriptor = FetchDescriptor<Car>(sortBy: [SortDescriptor(\.brand)])
            let carData = try modelContext.fetch(descriptor)
                    
            _ = carData.map { car in
                addCarModel(for: CarBrand(rawValue: car.brand), car: car)
            }
            
        } catch {
            print("Fetch failed")
        }
    }
    
    private func addCarModel(for brand: CarBrand?, car: Car) {
        guard let brand else { return }
        if savedCarModels[brand] != nil {
            savedCarModels[brand]?.append(car)
        } else {
            // If there is no records for this brand in the DB
            savedCarModels.updateValue([car], forKey: brand)
        }
    }
}
