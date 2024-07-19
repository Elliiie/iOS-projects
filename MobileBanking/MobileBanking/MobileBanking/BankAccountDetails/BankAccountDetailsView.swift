//
//  BankAccountDetailsView.swift
//  MobileBanking
//
//  Created by Elena Georgieva on 17.07.24.
//

import SwiftUI
import SwiftData

struct BankAccountDetailsView: View {
    
    @State var viewModel: BankAccountDetailsViewModel
        
    init(accountId: String) {
        _viewModel = .init(wrappedValue: .init(accountId: accountId))
    }
    
    var body: some View {
        VStack {
            Text(viewModel.balance)
                .font(.system(size: Layout.BalanceFontSize))
                .foregroundStyle(viewModel.isAccountFrozen ? Color.gray : Color.accentColor)
            
            HStack(spacing: Layout.BigOffset) {
                freezeUnfreezeButton
                
                Button(action: viewModel.didTapNewTransfer, label: {
                    VStack {
                        Image(systemName: "creditcard")
                            .foregroundStyle(viewModel.isAccountFrozen ? Color.gray : Color.accentColor)
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: Layout.ShadowRadius)
                            .frame(width: Layout.ImageSize, height: Layout.ImageSize)
                        
                        Text("New transfer")
                            .foregroundStyle(viewModel.isAccountFrozen ? Color.gray : Color.accentColor)
                            .font(.system(size: Layout.TextFontSize))
                    }
                })
                .disabled(viewModel.isAccountFrozen)
            }
            
            ScrollView {
                buildSection(title: "Bank account details") {
                    VStack {
                        KeyValueView(key: "Name", value: viewModel.name)
                        
                        Divider()
                        
                        HStack {
                            KeyValueView(key: "IBAN", value: viewModel.iban)
                                .contextMenu(ContextMenu(menuItems: {
                                    Text("Copy")
                                }))
                            
                            Button(action: viewModel.didTapCopyIBAN, label: {
                                Image(systemName: "doc.on.doc")
                            })
                        }
                        
                        Divider()
                        
                        KeyValueView(key: "Currency", value: viewModel.currency)
                        
                        Divider()
                        
                        KeyValueView(key: "Created on", value: viewModel.createdOn)
                        
                        Divider()
                        
                        KeyValueView(key: "Modified on", value: viewModel.modifiedOn)
                    }
                }
                
                if !viewModel.transfers.isEmpty {
                    buildSection(title: "Transfers") {
                        VStack {
                            ForEach(viewModel.transfers, id: \.id) { transfer in
                                BankTransferView(viewData: transfer)
                            }
                            
                            HStack {
                                Spacer()
                                
                                Button("See all", action: viewModel.didTapSeeAllTransfers)
                                    .foregroundStyle(Color.accentColor)
                            }
                            .padding()
                        }
                    }
                }
                
                Spacer()
            }
        }
        .popover(isPresented: $viewModel.createTransferPresented, content: {
            CreateTransferView(accountCurrency: viewModel.currency, completion: viewModel.newTransferInitiated(_:))
                .alert("Error", isPresented: $viewModel.errorPresented) {
                    Button("OK", role: .cancel) { 
                        viewModel.createTransferPresented.toggle()
                    }
                } message: {
                    Text(viewModel.error)
                }
        })
        .popover(isPresented: $viewModel.allTransfersPresented) {
            ListBankTransfersView(accountId: viewModel.accountId)
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    private var freezeUnfreezeButton: some View {
        var title: String {
            return viewModel.isAccountFrozen ? "Unfreeze" : "Freeze"
        }
        
        var image: String {
            return viewModel.isAccountFrozen ? "snowflake.slash" : "snowflake"
        }
        
        
        return Button(action: {
            if viewModel.isAccountFrozen {
                viewModel.unfreezeAccount()
            } else {
                viewModel.freezeAccount()
            }
        }, label: {
            VStack {
                Image(systemName: image)
                    .foregroundStyle(Color.accentColor)
                    .padding()
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(radius: Layout.ShadowRadius)
                    .frame(width: Layout.ImageSize, height: Layout.ImageSize)
                
                Text(title)
                    .foregroundStyle(Color.accentColor)
                    .font(.system(size: Layout.TextFontSize))
            }
        })
        
    }
    
    private func buildSection(title: String, content: @escaping () -> some View) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundStyle(Color.gray)
            
            VStack {
                content()
            }
            .padding()
            .cornerRadiusAndShadow()
        }
        .padding()
    }
}
