//
//  TextFieldView.swift
//  MobileBanking
//
//  Created by Elena Georgieva on 16.07.24.
//

import SwiftUI

struct TextFieldView: View {
    
    private let TextFieldHeight: CGFloat = 60
    
    let placeholder: String
    let isEnabled: Bool
    let keyboardType: UIKeyboardType
    
    @Binding var text: String
    @Binding var error: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                Text(placeholder)
                    .font(.system(size: 14))
                    .foregroundStyle(error != nil ? Color.red : .gray)
                    .offset(x: 0, y: text.isEmpty ? 0 : -(TextFieldHeight / 2))
           
                TextField("", text: $text)
                    .keyboardType(keyboardType)
                    .disabled(!isEnabled)
            }
            
            Divider()
                .foregroundStyle(error != nil ? Color.red : .gray)
            
            if error != nil {
                Text(error ?? "")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.red)
            }
        }
        .frame(height: error != nil ? TextFieldHeight + 16 : TextFieldHeight)
    }
}
