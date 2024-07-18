//
//  BankTransfer.swift
//  MobileBanking
//
//  Created by Elena Georgieva on 16.07.24.
//

import Foundation
import SwiftData

@Model class BankTransfer {
    
    enum TransferType: String {
        case credit
        case debit
    }
    
    @Attribute(.unique) let id: String
    let accountId: String
    let beneficiaryAccountId: String
    let type: String
    let amount: Double
    let message: String
    let createdOn: Date
    var modifiedOn: Date
    
    init(id: String, accountId: String, beneficiaryAccountId: String, type: TransferType, amount: Double, message: String, createdOn: Date, modifiedOn: Date) {
        self.id = id
        self.accountId = accountId
        self.beneficiaryAccountId = beneficiaryAccountId
        self.type = type.rawValue
        self.amount = amount
        self.message = message
        self.createdOn = createdOn
        self.modifiedOn = modifiedOn
    }
}
