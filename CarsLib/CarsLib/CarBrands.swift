//
//  CarBrands.swift
//  CarsLib
//
//  Created by Elena Georgieva on 7.05.24.
//

import Foundation
import SwiftUI

enum CarBrand: String {
    case audi = "Audi"
    case bmw = "BMW"
    case dodge = "Dodge"
    case ferrari = "Ferrari"
    case ford = "Ford"
    case honda = "Honda"
    case lexus = "Lexus"
    case mazda = "Mazda"
    case mercedes = "Mercedes"
    case nissan = "Nissan"
    case porsche = "Porsche"
    case toyota = "Toyota"
    
    var image: Image {
        return switch self {
        case .audi: Image(.audi)
        case .bmw: Image(.bmw)
        case .dodge: Image(.dodge)
        case .ferrari: Image(.ferrari)
        case .ford: Image(.ford)
        case .honda: Image(.honda)
        case .lexus: Image(.lexus)
        case .mazda: Image(.mazda)
        case .mercedes: Image(.mercedes)
        case .nissan: Image(.nissan)
        case .porsche: Image(.porsche)
        case .toyota: Image(.toyota)
        }
    }
    
    static var All: [CarBrand] {
        return [.audi, .bmw, .dodge, .ferrari, .ford, .honda, .lexus, .mazda, .mercedes, .nissan, .porsche, .toyota]
    }
    
    static var AllNames: [String] {
        return All.map { $0.rawValue }
    }
}
