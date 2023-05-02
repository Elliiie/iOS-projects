//
//  Theme.swift
//  Memorize
//
//  Created by Elena Georgieva on 26.04.23.
//

import Foundation
import SwiftUI

enum Theme: String {
    case transport
    case animals
    case plants
    case christmas
    case halloween
    case faces
    case food
    
    var color: Color {
        switch self {
        case .transport: return .blue
        case .animals: return .purple
        case .plants: return .green
        case .christmas: return .red
        case .halloween: return .orange
        case .faces: return .yellow
        case .food: return .pink
        }
    }
    
    var emojis: Array<String> {
        switch self {
        case .transport:
            return ["🚂", "🚀", "🚁", "🚘", "🚌", "🚎", "🏎️", "🏍️", "🛺", "🚤", "🚊", "🛴", "🚚", "🦼", "🚋", "🚢", "🛶", "🚜", "🚕", "🚒", "🚍", "🚠", "🚟", "🛸"]
        case .animals:
            return ["🐕", "🦢", "🐁", "🦩", "🐅", "🦑", "🐢", "🐞", "🦋", "🐛", "🦆", "🦉", "🐺", "🐝", "🦎"]
        case .plants:
            return ["🌵", "💐", "🌹", "🪷", "🌳", "🌴", "🌻", "🌷", "🍄", "🍃", "🪴"]
        case .christmas:
            return ["🎄", "☃️", "🎅🏽", "🤶🏼", "❄️", "🎁", "⛄️", "🌨️"]
        case .halloween:
            return ["👻", "💀", "☠️", "👽", "🎃", "😈", "🧞‍♂️", "🧚🏼", "⚰️", "🕷", "🙀", "🍭", "🦇"]
        case .faces:
            return ["😄", "😆", "😌", "😇", "😎", "🤩", "🤔", "🫡", "🫠", "🤠"]
        case .food:
            return ["🫐", "🍎", "🍇", "🍓", "🍔", "🍕", "🌯", "🥨", "🍪", "🧁", "🍚", "🍤", "🍫"]
        }
    }
    
    var numberOfPairsToShow: Int {
        switch self {
        case .transport: return 6 // Set to fewer pairs than the actual number
        case .animals, .plants, .christmas, .halloween, .food: return self.emojis.count
        case .faces: return 100 // Set to more pairs than the actual number
        }
    }
    
    static var themesList: [Theme] = [.transport, .animals, .plants, .christmas, .halloween, .faces, .food]
}
