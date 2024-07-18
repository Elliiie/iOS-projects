//
//  BankAccount.swift
//  MobileBanking
//
//  Created by Elena Georgieva on 16.07.24.
//

import Foundation
import SwiftData

@Model class BankAccount {
    
    enum Status: String {
        case active
        case frozen
    }
    
    @Attribute(.unique) let id: String
    @Attribute(.unique) let name: String
    @Attribute(.unique) let iban: String
    let currency: String
    var status: String
    var availableAmount: Double
    let createdOn: Date
    var modifiedOn: Date
    
    var isFrozen: Bool {
        return BankAccount.Status(rawValue: self.status) == .frozen
    }
    
    var formattedAmount: String {
        return "\(availableAmount.formatted()) \(currency)"
    }
    
    init(id: String, name: String, iban: String, currency: String, status: Status, availableAmount: Double, createdOn: Date, modifiedOn: Date) {
        self.id = id
        self.name = name
        self.iban = iban
        self.currency = currency
        self.status = status.rawValue
        self.availableAmount = availableAmount
        self.createdOn = createdOn
        self.modifiedOn = modifiedOn
    }
}
