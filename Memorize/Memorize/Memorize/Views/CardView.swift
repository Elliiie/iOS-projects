//
//  CardView.swift
//  Memorize
//
//  Created by Elena Georgieva on 26.04.23.
//

import SwiftUI

private struct LayoutConstants {
    static let FontScale: CGFloat = 0.7
    static let PieOffset: CGFloat = 5
    static let PieOpacity: CGFloat = 0.5
    static let FontSize: CGFloat = 32
}

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: .degrees(0 - 90), endAngle: .degrees(110 - 90))
                    .padding(LayoutConstants.PieOffset)
                    .opacity(LayoutConstants.PieOpacity)
                
                Text(card.content)
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(.system(size: LayoutConstants.FontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (LayoutConstants.FontSize / LayoutConstants.FontScale)
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
