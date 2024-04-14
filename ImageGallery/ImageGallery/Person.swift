//
//  Person.swift
//  ImageGallery
//
//  Created by Elena Georgieva on 14.04.24.
//

import Foundation
import SwiftData

@Model
final class Person {
    
    private(set) var name: String
    private(set) var number: String
    private(set) var imageData: Data
    
    init(name: String, number: String, imageData: Data) {
        self.name = name
        self.number = number
        self.imageData = imageData
    }
}
