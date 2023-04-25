//
//  EmojiMemoryGameModel.swift
//  Memorize
//
//  Created by Elena Georgieva on 24.04.23.
//

import Foundation
import SwiftUI

class EmojiMemoryGameModel {
    
    private static let emojis = ["🚂", "🚀", "🚁", "🚘", "🚌", "🚎", "🏎️", "🏍️", "🛺", "🚤", "🚊", "🛴", "🚚", "🦼", "🚋", "🚢", "🛶", "🚜", "🚕", "🚒", "🚍", "🚠", "🚟", "🛸"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        return .init(numberOfPairsOfCards: 4) { index in
            emojis[index]
        }
    }
    
    private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    
    
}
