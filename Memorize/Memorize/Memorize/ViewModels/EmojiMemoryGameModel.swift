//
//  EmojiMemoryGameModel.swift
//  Memorize
//
//  Created by Elena Georgieva on 24.04.23.
//

import Foundation
import SwiftUI

class EmojiMemoryGameModel: ObservableObject {
        
    @Published private var model = createMemoryGame(using: .transport)
    @Published private var theme: Theme = .transport
    
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    var themeName: String { theme.rawValue.capitalized }
    var color: Color { theme.color }
    var score: String { String(model.score) }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGameTapped() {
        theme = Theme.themesList.randomElement() ?? .animals
        model = EmojiMemoryGameModel.createMemoryGame(using: theme)
    }
}

extension EmojiMemoryGameModel {
    static func createMemoryGame(using theme: Theme) -> MemoryGame<String> {
        let numberOfPairsToShow = theme.numberOfPairsToShow > theme.emojis.count ? theme.emojis.count : theme.numberOfPairsToShow
        return .init(numberOfPairsOfCards: numberOfPairsToShow) { index in
            theme.emojis[index]
        }
    }
}
