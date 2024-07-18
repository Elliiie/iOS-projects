//
//  ListBankTransfersViewModel.swift
//  MobileBanking
//
//  Created by Elena Georgieva on 18.07.24.
//

import Foundation
import SwiftData

@Observable class ListBankTransferViewModel {
    
    var transfers: [BankTransferView.Data] = []
    
    private var account: BankAccount?

    private let accountId: String
        
    private let dbManager = DatabaseManager.shared
    
    init(accountId: String) {
        self.accountId = accountId
    }
    
    func onAppear() {
        fetchAccountDetails()
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
    
    private func fetchTransfers() {
        guard let fetched = dbManager?.fetchTransfers(accountId: accountId) else { return }
        getNeededTransferData(from: fetched.sorted(by: { $0.createdOn > $1.createdOn }))
    }
    
    private func fetchAccountDetails() {
        account = dbManager?.fetchAccount(accountId: accountId)
        fetchTransfers()
    }
}
