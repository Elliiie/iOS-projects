//
//  EmojiMemoryGameModel.swift
//  Memorize
//
//  Created by Elena Georgieva on 24.04.23.
//

import Foundation
import SwiftUI

class EmojiMemoryGameModel: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    @Published private var model = createMemoryGame(using: .transport)
    @Published private var theme: Theme = .transport
    
    var cards: Array<Card> { model.cards }
    var themeName: String { theme.rawValue.capitalized }
    var color: Color { theme.color }
    var score: String { String(model.score) }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func newGameTapped() {
        theme = Theme.themesList.randomElement() ?? .animals
        model = EmojiMemoryGameModel.createMemoryGame(using: theme)
    }
    
    func shuffle() {
        model.shuffle()
    }
}

extension EmojiMemoryGameModel {
    private static func createMemoryGame(using theme: Theme) -> MemoryGame<String> {
        let numberOfPairsToShow = theme.numberOfPairsToShow > theme.emojis.count ? theme.emojis.count : theme.numberOfPairsToShow
        return .init(numberOfPairsOfCards: numberOfPairsToShow) { index in
            theme.emojis[index]
        }
    }
}
