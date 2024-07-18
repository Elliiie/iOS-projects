//
//  ListBankAccountsView.swift
//  MobileBanking
//
//  Created by Elena Georgieva on 16.07.24.
//

import SwiftUI
import SwiftData

struct ListBankAccountsView: View {
    
    @State var viewModel: ListBankAccountsViewModel = .init()
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.bankAccounts.isEmpty {
                    Text("You don't have any bank accounts :c")
                        .font(.system(size: 20))
                        
                } else {
                    List(viewModel.bankAccounts) { account in
                        NavigationLink {
                            BankAccountDetailsView(accountId: account.id)
                        } label: {
                            HStack {
                                Image(systemName: "creditcard")
                                
                                Text(account.name)
                                
                                Spacer()
                                
                                Text("\(account.availableAmount.formatted()) \(account.currency)")
                                    .foregroundStyle(account.isFrozen ? Color.gray : Color.accentColor)
                            }
                            .padding()
                            .cornerRadiusAndShadow()
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                }

                Button(action: viewModel.didTapAddNew) {
                    Text("Add new")
                        .bold()
                        .foregroundStyle(Color.white)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadiusAndShadow()
                }
                    .padding(.top, 32)
            }
            .popover(isPresented: $viewModel.createBankAccountPresented, content: {
                CreateBankAccountView(completion: viewModel.createBankAccount(_:))
            })
            .onAppear {
                viewModel.onAppear()
            }
        }
    }
}
