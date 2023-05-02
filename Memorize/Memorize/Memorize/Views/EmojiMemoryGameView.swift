//
//  ContentView.swift
//  Memorize
//
//  Created by Elena Georgieva on 21.04.23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGameModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Theme: " + game.themeName)
                    .font(.title)
                    .foregroundColor(game.color)
                
                Spacer()
                
                Text("Score: " + game.score)
                    .font(.title)
                    .foregroundColor(game.color)
            }
            .padding(.horizontal)
            .padding(.top)
            
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
                .padding(.horizontal)
                .foregroundColor(game.color)
            
            Button {
                game.newGameTapped()
            } label: {
                Text("New game")
                    .font(.title)
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGameModel()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}
