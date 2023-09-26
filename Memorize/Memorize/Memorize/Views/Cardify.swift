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

struct Cardify: AnimatableModifier {
        
    var rotation: Double
    
    var animatableData: Double {
        get {
            return rotation
        } set {
            rotation = newValue
        }
    }
    
    init(isFaceUp: Bool) {
        self.rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: LayoutConstants.CornerRadius)
            
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: LayoutConstants.LineWidth)
            } else {
                shape.fill()
            }
            
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }
}


extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
