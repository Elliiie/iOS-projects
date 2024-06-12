//
//  Car.swift
//  CarsLib
//
//  Created by Elena Georgieva on 7.05.24.
//

import Foundation
import SwiftData

@Model
class Car {
    @Attribute(.unique) var model: String
    var brand: String
    var productionYear: Date
    var power: Int
    var clickedCount: Int
    
    init(model: String, brand: String, productionYear: Date, power: Int, clickedCount: Int) {
        self.model = model
        self.brand = brand
        self.productionYear = productionYear
        self.power = power
        self.clickedCount = clickedCount
    }
}

extension Date {
    var year: Int {
        return Calendar(identifier: .iso8601).component(.year, from: self)
    }
}
