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
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(lineWidth: 3)
                
                Text(card.content)
                    .font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .init(id: 0, content: "asd"))
    }
}
