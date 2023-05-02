//
//  ListLabelItem.swift
//  Memorize
//
//  Created by Elena Georgieva on 2.05.23.
//

import SwiftUI

struct KeyValueLabel: View {
    struct Data {
        var key: String
        var value: String
        var font: Font
    }
    
    var data: Data
    
    var body: some View {
        HStack {
            Text(data.key + ": ")
                .bold()
                        
            Text(data.value)
        }
        .font(data.font)
    }
}

struct ListLabelItem_Previews: PreviewProvider {
    static var previews: some View {
        KeyValueLabel(data: .init(key: "asdf", value: "asdf", font: .title))
    }
}
