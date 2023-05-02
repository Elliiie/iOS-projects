//
//  GameInfoView.swift
//  Memorize
//
//  Created by Elena Georgieva on 2.05.23.
//

import SwiftUI

private struct LayoutConstants {
    static let LabelsOffset: CGFloat = 8
    static let BackgroundCornerRadius: CGFloat = 12
    static let BackgroundOpacity: CGFloat = 0.3
}

struct GameInfoView: View {
    
    struct Data {
        var themeName: String
        var score: String
    }
    
    
    var data: Data
    
    var body: some View {
        HStack {
            KeyValueLabel(data: .init(key: "📜 Theme", value: data.themeName, font: .title3))
            
            Divider()
            
            KeyValueLabel(data: .init(key: "🎯Score", value: data.score, font: .title3))
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: LayoutConstants.BackgroundCornerRadius)
                .foregroundColor(.gray)
                .opacity(LayoutConstants.BackgroundOpacity)
        )
    }
}

struct GameInfoView_Previews: PreviewProvider {
    static var previews: some View {
        GameInfoView(data: .init(themeName: "adsd", score: "adad"))
    }
}
