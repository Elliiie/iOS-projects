//
//  ContentView.swift
//  Memorize
//
//  Created by Elena Georgieva on 21.04.23.
//

import SwiftUI

private struct LayoutConstants {
    static let GameInfoViewHeight: CGFloat = 70
    static let CardViewOffset: CGFloat = 4
    static let MainButtonHeight: CGFloat = 60
    static let CardViewAspectRatio: CGFloat = 2/3
}

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGameModel
    
    var body: some View {
        VStack {
            GameInfoView(data: .init(themeName: game.themeName, score: game.score))
                .padding(.top)
                .frame(height: LayoutConstants.GameInfoViewHeight)
            
            AspectVGrid(items: game.cards, aspectRatio: LayoutConstants.CardViewAspectRatio) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(LayoutConstants.CardViewOffset)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
                .padding(.horizontal)
                .foregroundColor(game.color)
            
            MainButton(data: .init(title: "New Game", tapHandler: game.newGameTapped))
                .frame(height: LayoutConstants.MainButtonHeight)
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
