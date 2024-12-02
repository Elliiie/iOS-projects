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
            let transferType = transfer.getTransferType(accountId: accountId)
            
            var subtitle: String {
                switch transferType {
                case .credit:
                    let receiverName = dbManager?.fetchAccount(accountId: transfer.beneficiaryAccountId)?.name ?? ""
                    return "To \(receiverName)"
                case .debit:
                    let senderName = dbManager?.fetchAccount(accountId: transfer.accountId)?.name ?? ""
                    return "From \(senderName)"
                }
            }
            
            self.transfers.append(.init(id: transfer.id, type: transferType.rawValue, amount: "\(transfer.amount) \(account.currency)", subtitle: subtitle))
        }
    }
    
    private func fetchTransfers() {
        guard let fetched = dbManager?.fetchTransfers(accountId: accountId) else { return }
        getNeededTransferData(from: fetched)
    }
    
    private func fetchAccountDetails() {
        account = dbManager?.fetchAccount(accountId: accountId)
        fetchTransfers()
    }
}
