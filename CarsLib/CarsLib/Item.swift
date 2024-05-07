//
//  Item.swift
//  CarsLib
//
//  Created by Elena Georgieva on 7.05.24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
