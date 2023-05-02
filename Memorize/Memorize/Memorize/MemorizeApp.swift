//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Elena Georgieva on 21.04.23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGameModel()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
