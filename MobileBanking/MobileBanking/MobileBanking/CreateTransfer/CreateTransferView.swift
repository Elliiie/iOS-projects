//
//  CreateTransferView.swift
//  MobileBanking
//
//  Created by Elena Georgieva on 18.07.24.
//

import SwiftUI

struct CreateTransferView: View {
    
    @State private var viewModel: CreateTransferViewModel
    
    init(accountCurrency: String, completion: @escaping (TransferData) -> Void) {
        self._viewModel = .init(wrappedValue: .init(accountCurrency: accountCurrency, completion: completion))
    }
    
    var body: some View {
        VStack {
            Text("Create transfer")
                .font(.system(size: Layout.TitleFontSize))
                .padding()
            
            VStack {
                TextFieldView(placeholder: "IBAN", isEnabled: true, keyboardType: .default, text: $viewModel.iban, error: .constant(nil))
                
                HStack {
                    Text(viewModel.accountCurrency)
                        .padding(.trailing, Layout.SmallOffset)
                    
                    TextFieldView(placeholder: "Amount", isEnabled: true, keyboardType: .decimalPad, text: $viewModel.amount, error: .constant(nil))
                }
                
                TextFieldView(placeholder: "Description (Optional)", isEnabled: true, keyboardType: .default, text: $viewModel.description, error: .constant(nil))
                
            }
            .padding()
            .cornerRadiusAndShadow()
            .padding()
            
            Button(action: viewModel.didTapCreate) {
                Text("Create")
                    .bold()
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(viewModel.buttonEnabled ? Color.accentColor : .gray.opacity(0.5))
                    .cornerRadiusAndShadow()
            }
                .disabled(!viewModel.buttonEnabled)
                .padding(.top, Layout.BigOffset)
            
            Spacer()
        }
    }
}

