//
//  CreateBankAccountView.swift
//  MobileBanking
//
//  Created by Elena Georgieva on 16.07.24.
//

import SwiftUI

let Currencies: [String] = ["BGN", "GBP"]

struct CreateBankAccountView: View {
        
    @State private var viewModel: CreateBankAccountViewModel
        
    init(completion: @escaping (BankAccount) -> Void) {
        self._viewModel = .init(wrappedValue: .init(completion: completion))
    }
    
    var body: some View {
        VStack {
            Text("Create bank account")
                .font(.system(size: 20))
                .padding()
            
            VStack {
                TextFieldView(placeholder: "Name", isEnabled: true, keyboardType: .default, text: $viewModel.name, error: $viewModel.nameError)
                
                TextFieldView(placeholder: "IBAN", isEnabled: false, keyboardType: .default, text: $viewModel.iban, error: .constant(nil))
                
                HStack {
                    Text("Currency")
                        .foregroundStyle(Color.gray)
                        .font(.system(size: 14))
                    
                    Picker("", selection: $viewModel.currency) {
                        ForEach(Currencies, id: \.self) { currency in
                            Text(currency)
                        }
                    }
                    
                    Spacer()
                }
            }
                .padding()
                .cornerRadiusAndShadow()
            
            Button(action: viewModel.didTapCreate) {
                Text("Create")
                    .bold()
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(viewModel.buttonDisabled ? .gray.opacity(0.5) : .accentColor)
                    .cornerRadiusAndShadow()
            }
                .disabled(viewModel.buttonDisabled)
                .padding(.top, 32)
            
            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    CreateBankAccountView(completion: { _ in })
}
