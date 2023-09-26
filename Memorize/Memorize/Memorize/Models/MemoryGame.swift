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
    
    private var indexOfTheFacedUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) }
        }
    }
    
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
            
            cards[index].isFaceUp = true
        } else {
            indexOfTheFacedUpCard = index
            
            if !cards[index].isSeen {
                cards[index].isSeen.toggle()
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
}

extension MemoryGame {
    
    struct Card: Identifiable {
        let id: Int
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startsUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var isSeen = false
        let content: CardContent
        
        // MARK: Bonus time logic
        
        var bonusTimeLimit: TimeInterval = 6
        
        // how long the card has ever been face up
        private var faceUpTime: TimeInterval {
            guard let lastFaceUpDate = self.lastFaceUpDate else {
                return pastFaceUpTime
            }
            return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
        }
        
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        // the accumulated time the card has been face up in the past
        var pastFaceUpTime: TimeInterval = 0

        // how much time left before the bonus runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startsUsingBonusTime() {
            guard isConsumingBonusTime, lastFaceUpDate == nil else { return }
            lastFaceUpDate = Date()
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    }
}

extension Array {
    var oneAndOnly: Element? {
        return self.count == 1 ? self.first : nil
    }
}
