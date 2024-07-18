//
//  BankAccountDetailsViewModel.swift
//  MobileBanking
//
//  Created by Elena Georgieva on 18.07.24.
//

import Foundation
import SwiftData
import UIKit

@Observable class BankAccountDetailsViewModel {
      
    var accountId: String
    var balance: String = ""
    var name: String = ""
    var iban: String = ""
    var currency: String = ""
    var createdOn: String = ""
    var modifiedOn: String = ""
    
    var transfers: [BankTransferView.Data] = []
    
    var isAccountFrozen: Bool {
        return account?.isFrozen ?? false
    }
    
    var createTransferPresented: Bool = false
    
    var allTransfersPresented: Bool = false
    
    var errorPresented: Bool = false
    
    var error: String = ""
    
    private var account: BankAccount?
        
    private let dbManager = DatabaseManager.shared
    
    init(accountId: String) {
        self.accountId = accountId
    }
    
    func onAppear() {
        setupAccountData()
        
        fetchTransfers()
    }
    
    func freezeAccount() {
        account?.status = BankAccount.Status.frozen.rawValue
    }
    
    func unfreezeAccount() {
        account?.status = BankAccount.Status.active.rawValue
    }
    
    func didTapNewTransfer() {
        createTransferPresented.toggle()
    }
    
    func newTransferInitiated(_ transfer: TransferData) {
        defer {
            if !error.isEmpty { errorPresented.toggle() }
        }
        
        guard let beneficiaryAccount = fetchAccount(form: transfer.recipientIBAN) else { return }
        
        if BankAccount.Status(rawValue: beneficiaryAccount.status) == .frozen {
            error = "This account is not active"
            return
        }
        
        if beneficiaryAccount.id == account?.id {
            error = "You cannot transfer money to the same account"
            return
        }
        
        if let account, account.availableAmount < transfer.amount {
            error = "Not enough funds"
            return
        }
        
        if beneficiaryAccount.currency != account?.currency {
            error = "You cannot transfer money to accounts in different currencies"
            return
        }
        
        let transfer: BankTransfer = .init(id: UUID().uuidString, accountId: accountId, beneficiaryAccountId: beneficiaryAccount.id, type: .debit, amount: transfer.amount, message: transfer.description, createdOn: Date(), modifiedOn: Date())
        
        dbManager?.saveTransfer(transfer)
        
        onAppear()
        
        createTransferPresented.toggle()
    }
    
    func didTapSeeAllTransfers() {
        allTransfersPresented.toggle()
    }
    
    func didTapCopyIBAN() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = account?.iban ?? ""
    }
    
    private func setupAccountData() {
        fetchAccountDetails()

        guard let account else { return }
        
        accountId = account.id
        balance = account.formattedAmount
        name = account.name
        iban = account.iban
        currency = account.currency
        createdOn = account.createdOn.formatted()
        modifiedOn = account.modifiedOn.formatted()
    }
    
    private func getNeededTransferData(from transfers: [BankTransfer]) {
        guard let account else { return }
        _ = transfers.map { transfer in
            self.transfers.append(.init(id: transfer.id, type: getTransferType(transfer), amount: "\(transfer.amount) \(account.currency)", message: transfer.message))
        }
    }
    
    private func getTransferType(_ transfer: BankTransfer) -> String {
        return transfer.accountId == accountId ? BankTransfer.TransferType.credit.rawValue : BankTransfer.TransferType.debit.rawValue
    }
    
    private func fetchAccountDetails() {
        account = dbManager?.fetchAccount(accountId: accountId)
    }
    
    private func fetchTransfers() {
        guard let fetched = dbManager?.fetchTransfers(accountId: accountId, fetchLimit: 3) else { return }
        getNeededTransferData(from: fetched.sorted(by: { $0.createdOn > $1.createdOn }))
    }
    
    private func fetchAccount(form iban: String) -> BankAccount? {
        return dbManager?.fetchAccount(iban: iban)
    }
}
