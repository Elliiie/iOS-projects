//
//  MemoryGameModel.swift
//  Memorize
//
//  Created by Elena Georgieva on 24.04.23.
//

import Foundation
import UIKit

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: [Card]
    private(set) var score: Int
    
    private var indexOfTheFacedUpCard: Int?
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        self.cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1,content: content))
        }
        
        self.cards.shuffle()
        self.score = 0
    }
    
    mutating func choose(_ card: Card) {
        guard let index = cards.firstIndex(where: { $0.id == card.id }), !cards[index].isFaceUp, !cards[index].isMatched else { return }
        
        if let potentialMatchIndex = indexOfTheFacedUpCard {
            if cards[index].content == cards[potentialMatchIndex].content {
                cards[index].isMatched = true
                cards[potentialMatchIndex].isMatched = true
                score += 2
            } else {
                if !cards[index].isSeen {
                    cards[index].isSeen.toggle()
                } else if cards[index].isSeen && !cards[index].isMatched {
                    score -= 1
                }
            }
            
            indexOfTheFacedUpCard = nil
        } else {
            for index in cards.indices {
                cards[index].isFaceUp = false
            }
            
            indexOfTheFacedUpCard = index
            
            if !cards[index].isSeen {
                cards[index].isSeen.toggle()
            }
        }
        
        cards[index].isFaceUp.toggle()
    }
}

extension MemoryGame {
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isSeen: Bool = false
        var content: CardContent
    }
}
