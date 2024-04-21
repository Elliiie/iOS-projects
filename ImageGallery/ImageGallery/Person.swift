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
    
    @Attribute(.unique) private(set) var name: String
    private(set) var number: String
    private(set) var imageData: Data
    private(set) var birthdate: Date
    private(set) var creationDate: Date
    
    init(name: String, number: String, imageData: Data, birthdate: Date, creationDate: Date) {
        self.name = name
        self.number = number
        self.imageData = imageData
        self.birthdate = birthdate
        self.creationDate = creationDate
    }
}
