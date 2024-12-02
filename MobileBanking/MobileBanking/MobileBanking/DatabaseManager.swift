//
//  DatabaseManager.swift
//  MobileBanking
//
//  Created by Elena Georgieva on 18.07.24.
//

import Foundation
import SwiftData

class DatabaseManager {
    
    static var shared: DatabaseManager!
    
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchBankAccounts() -> [BankAccount] {
        do {
            let descriptor = FetchDescriptor<BankAccount>(sortBy: [SortDescriptor(\.name)])
            return try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching accounts: \(error)")
            return []
        }
    }
    
    func fetchAccount(iban: String) -> BankAccount? {
        do {
            let descriptor = FetchDescriptor<BankAccount>(predicate: #Predicate { $0.iban == iban })
            return try modelContext.fetch(descriptor).first
        } catch {
            print("Error fetching account: \(error)")
            return nil
        }
    }
    
    func fetchAccount(accountId: String) -> BankAccount? {
        do {
            let descriptor = FetchDescriptor<BankAccount>(predicate: #Predicate { $0.id == accountId })
            
            return try modelContext.fetch(descriptor).first
        } catch {
            print("Error fetching account details: \(error)")
            return nil
        }
    }
    
    func fetchAccount(name: String) -> BankAccount? {
        do {
            let descriptor = FetchDescriptor<BankAccount>(predicate: #Predicate { $0.name == name })
            
            return try modelContext.fetch(descriptor).first
        } catch {
            print("Error fetching account details: \(error)")
            return nil
        }
    }
    
    func fetchTransfers(accountId: String, fetchLimit: Int? = nil) -> [BankTransfer] {
        do {
            var descriptor = FetchDescriptor<BankTransfer>(predicate: #Predicate {
                $0.accountId == accountId || $0.beneficiaryAccountId == accountId
            }, sortBy: [SortDescriptor(\.createdOn, order: .reverse)])
            descriptor.fetchLimit = fetchLimit
            
            return try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching transfers: \(error)")
            return []
        }
    }
    
    func saveBankAccount(_ bankAccount: BankAccount) {
        modelContext.insert(bankAccount)
    }
    
    func saveTransfer(_ transfer: BankTransfer) {
        modelContext.insert(transfer)
        
        updateBalances(transfer: transfer)
    }
    
    private func updateBalances(transfer: BankTransfer) {
        guard let sender = fetchAccount(accountId: transfer.accountId), let receiver = fetchAccount(accountId: transfer.beneficiaryAccountId) else { return }
        
        sender.availableAmount -= transfer.amount
        receiver.availableAmount += transfer.amount
    }
}

extension DatabaseManager {
    static func setup(modelContext: ModelContext) {
        shared = .init(modelContext: modelContext)
    }
}
