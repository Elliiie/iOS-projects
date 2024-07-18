//
//  ListBankTransfersView.swift
//  MobileBanking
//
//  Created by Elena Georgieva on 18.07.24.
//

import SwiftUI
import SwiftData

struct ListBankTransfersView: View {
    
    @State private var viewModel: ListBankTransferViewModel
    
    init(accountId: String) {
        _viewModel = .init(wrappedValue: .init(accountId: accountId))
    }
    
    var body: some View {
        VStack {
            Text("Transfers")
                .font(.system(size: Layout.TitleFontSize))
                .padding()
            
            VStack {
                ForEach(viewModel.transfers, id: \.id) { transfer in
                    BankTransferView(viewData: transfer)
                }
            }
            .cornerRadiusAndShadow()
            
            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.onAppear()
        }
    }
}
