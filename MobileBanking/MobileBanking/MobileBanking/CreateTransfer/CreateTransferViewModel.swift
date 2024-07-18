//
//  CreateTransferViewModel.swift
//  MobileBanking
//
//  Created by Elena Georgieva on 18.07.24.
//

import Foundation

struct TransferData {
    let recipientIBAN: String
    let amount: Double
    let description: String
}

@Observable class CreateTransferViewModel {
    
    var iban: String = "" {
        didSet {
            enableButtonIfNeeded()
        }
    }
    
    var amount: String = "" {
        didSet {
            enableButtonIfNeeded()
        }
    }
    
    var description: String = "" {
        didSet {
            enableButtonIfNeeded()
        }
    }
    
    var buttonEnabled: Bool = false
    
    let accountCurrency: String
    private let completion: (TransferData) -> Void
    
    init(accountCurrency: String, completion: @escaping (TransferData) -> Void) {
        self.accountCurrency = accountCurrency
        self.completion = completion
    }
    
    func didTapCreate() {
        completion(.init(recipientIBAN: iban, amount: Double(self.amount)!, description: description))
    }
    
    private func enableButtonIfNeeded() {
        buttonEnabled = validateInput()
    }
    
    private func validateInput() -> Bool {
        return iban.count == IBANLength && Double(amount) != nil
    }
}
