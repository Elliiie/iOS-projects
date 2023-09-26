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
    static let UndealtCardHeight: CGFloat = 90
    static let UndealtCardWidth = UndealtCardHeight * CardViewAspectRatio
    static let TotalDealDuration: Double = 2
}

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGameModel
    
    @State private var dealt = Set<Int>()
    
    @Namespace private var dealingNamespace
    
    var body: some View {
        VStack {
            GameInfoView(data: .init(themeName: game.themeName, score: game.score))
                .padding(.top)
                .frame(height: LayoutConstants.GameInfoViewHeight)
            
            ZStack(alignment: .bottom) {
                gameView
                    .padding(.horizontal)
                    .foregroundColor(game.color)
                
                deckView
            }
            
            HStack(spacing: 8) {
                MainButton(data: .init(title: "New Game", tapHandler: {
                    dealt.removeAll()
                    game.newGameTapped()
                }))
                    .frame(height: LayoutConstants.MainButtonHeight)
                
                MainButton(data: .init(title: "Shuffle", tapHandler: {
                    withAnimation {
                        game.shuffle()
                    }
                }))
                    .frame(height: LayoutConstants.MainButtonHeight)
            }
            .padding()
        }
    }
    
    var gameView: some View {
        AspectVGrid(items: game.cards, aspectRatio: LayoutConstants.CardViewAspectRatio) { card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            } else {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(LayoutConstants.CardViewOffset)
                    .transition(.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
        }
    }
    
    var deckView: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt(_:))) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: LayoutConstants.UndealtCardWidth, height: LayoutConstants.UndealtCardHeight)
        .foregroundColor(game.color)
        .onTapGesture {
            game.cards.forEach { card in
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    private func deal(_ card: EmojiMemoryGameModel.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGameModel.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGameModel.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (LayoutConstants.TotalDealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: delay)
    }
    
    private func zIndex(of card: EmojiMemoryGameModel.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
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
