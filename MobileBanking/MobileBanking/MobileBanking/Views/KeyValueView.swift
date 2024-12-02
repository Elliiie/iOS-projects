//
//  KeyValueView.swift
//  MobileBanking
//
//  Created by Elena Georgieva on 18.07.24.
//

import SwiftUI

struct KeyValueView: View {
    
    let key: String
    let value: String
        
    var body: some View {
        HStack {
            Text(key + ":")
            
            Text(value)
            
            Spacer()
        }
        .padding(Layout.SmallOffset)
    }
}
