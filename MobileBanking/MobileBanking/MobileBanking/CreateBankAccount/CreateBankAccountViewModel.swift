//
//  CreateBankAccountViewModel.swift
//  MobileBanking
//
//  Created by Elena Georgieva on 16.07.24.
//

import Foundation

let IBANLength = 22

@Observable class CreateBankAccountViewModel {
    
    var name: String = "" {
        didSet {
            enableButtonIfNeeded()
        }
    }
    
    var nameError: String?
    
    var iban: String = "" {
        didSet {
            enableButtonIfNeeded()
        }
    }
        
    var currency: String = Currencies[0] {
        didSet {
            enableButtonIfNeeded()
        }
    }
    
    var buttonDisabled: Bool = true
        
    private let completion: (BankAccount) -> Void
    
    init(completion: @escaping (BankAccount) -> Void) {
        self.completion = completion
    }
    
    func onAppear() {
        iban = generateIBAN()
    }
    
    func didTapCreate() {
        completion(.init(id: UUID().uuidString, name: name, iban: iban, currency: currency, status: .active, availableAmount: 0.0, createdOn: Date(), modifiedOn: Date()))
    }
    
    private func enableButtonIfNeeded() {
        buttonDisabled = !validateInput()
    }
    
    private func validateInput() -> Bool {
        let nameEmpty = name.trimmed.isEmpty
        let nameContainsSpecialChars = name.containsSpecialCharacters
        
        let isValidName = !nameEmpty && !nameContainsSpecialChars && !doesAccountExist()
        
        nameError = doesAccountExist() ? "This name is already taken" : !nameEmpty && nameContainsSpecialChars ? "Enter a valid name" : nil
        
        let isValidCurrency = !currency.isEmpty
                        
        return isValidName && isValidCurrency
    }
    
    private func doesAccountExist() -> Bool {
        return DatabaseManager.shared.fetchAccount(name: name) != nil
    }
    
    private func generateIBAN() -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        return String((0..<IBANLength).map{ _ in letters.randomElement()! })
    }
}
