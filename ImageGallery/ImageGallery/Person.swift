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
    
    @Attribute(.unique) var name: String
    var number: String
    var imageData: Data
    var birthdate: Date
    var creationDate: Date
    var clickedCount: Int
    
    init(name: String, number: String, imageData: Data, birthdate: Date, creationDate: Date, clickedCount: Int) {
        self.name = name
        self.number = number
        self.imageData = imageData
        self.birthdate = birthdate
        self.creationDate = creationDate
        self.clickedCount = clickedCount
    }
}
