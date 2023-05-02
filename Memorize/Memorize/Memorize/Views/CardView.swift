//
//  CardView.swift
//  Memorize
//
//  Created by Elena Georgieva on 26.04.23.
//

import SwiftUI

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.CornerRadius)
                
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    
                    RoundedRectangle(cornerRadius: DrawingConstants.CornerRadius)
                        .strokeBorder(lineWidth: DrawingConstants.LineWidth)
                    
                    Pie(startAngle: .degrees(0 - 90), endAngle: .degrees(110 - 90))
                        .padding(DrawingConstants.PieOffset)
                        .opacity(DrawingConstants.PieOpacity)
                    
                    Text(card.content)
                        .font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        .system(size: min(size.width, size.height) * DrawingConstants.FontScale)
    }
    
    private struct DrawingConstants {
        static let CornerRadius: CGFloat = 10
        static let LineWidth: CGFloat = 2
        static let FontScale: CGFloat = 0.7
        static let PieOffset: CGFloat = 5
        static let PieOpacity: CGFloat = 0.5
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        var card = MemoryGame.Card(id: 0, content: "😀")
        card.isFaceUp = true
        return CardView(card: card)
            .foregroundColor(.red)
            .border(.red, width: 3)
            .padding()
    }
}
