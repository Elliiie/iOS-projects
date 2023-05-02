//
//  Cardify.swift
//  Memorize
//
//  Created by Elena Georgieva on 2.05.23.
//

import Foundation
import SwiftUI

private struct LayoutConstants {
    static let CornerRadius: CGFloat = 10
    static let LineWidth: CGFloat = 2
}

struct Cardify: ViewModifier {
    
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: LayoutConstants.CornerRadius)
            
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: LayoutConstants.LineWidth)
            } else {
                shape.fill()
            }
            
            content
                .opacity(isFaceUp ? 1 : 0)
        }
    }
}


extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
