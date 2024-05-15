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
    var brandImage: Data
    
    init(model: String, brand: String, productionYear: Date, power: Int, clickedCount: Int, brandImage: Data) {
        self.model = model
        self.brand = brand
        self.productionYear = productionYear
        self.power = power
        self.clickedCount = clickedCount
        self.brandImage = brandImage
    }
}
