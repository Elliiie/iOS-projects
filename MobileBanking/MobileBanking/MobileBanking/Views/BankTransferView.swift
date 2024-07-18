//
//  BankTransferView.swift
//  MobileBanking
//
//  Created by Elena Georgieva on 18.07.24.
//

import SwiftUI

struct BankTransferView: View {
    
    struct Data {
        let id: String
        let type: String
        let amount: String
        let message: String
    }
    
    let viewData: Data
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "creditcard")
                
                VStack(alignment: .leading) {
                    Text("\(viewData.type) transfer")
                    
                    if !viewData.message.isEmpty {
                        Text(viewData.message)
                            .foregroundStyle(Color.gray)
                    }
                }
                
                Spacer()
                
                Text(viewData.amount)
                    .foregroundStyle(Color.accentColor)
            }
            .padding()
            
            Divider()
                .padding([.leading, .trailing], 16)
            
        }
    }
}

