//
//  ListBanlAccountsViewModel.swift
//  MobileBanking
//
//  Created by Elena Georgieva on 17.07.24.
//

import Foundation
import SwiftData

@Observable class ListBankAccountsViewModel {
    
    var bankAccounts: [BankAccount] = []
    
    var createBankAccountPresented: Bool = false
        
    func onAppear() {
        fetchBankAccounts()
    }
    
    func didTapAddNew() {
        createBankAccountPresented.toggle()
    }
    
    func createBankAccount(_ bankAccount: BankAccount) {
        bankAccounts.append(bankAccount)
        
        bankAccounts.sort(by: { $0.name < $1.name })
        
        DatabaseManager.shared.saveBankAccount(bankAccount)
        
        fetchBankAccounts()
        
        createBankAccountPresented.toggle()
    }
    
    private func fetchBankAccounts() {
        bankAccounts = DatabaseManager.shared.fetchBankAccounts()
        
        // For test purposes
//        guard !bankAccounts.isEmpty else { return }
//        bankAccounts[0].availableAmount = 100
    }
}
