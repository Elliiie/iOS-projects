//
//  EmojiMemoryGameModel.swift
//  Memorize
//
//  Created by Elena Georgieva on 24.04.23.
//

import Foundation
import SwiftUI

class EmojiMemoryGameModel: ObservableObject {
    
    private static let emojis = ["🚂", "🚀", "🚁", "🚘", "🚌", "🚎", "🏎️", "🏍️", "🛺", "🚤", "🚊", "🛴", "🚚", "🦼", "🚋", "🚢", "🛶", "🚜", "🚕", "🚒", "🚍", "🚠", "🚟", "🛸"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        return .init(numberOfPairsOfCards: 4) { index in
            emojis[index]
        }
    }
        
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
