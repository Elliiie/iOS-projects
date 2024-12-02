//
//  String+Extension.swift
//  MobileBanking
//
//  Created by Elena Georgieva on 18.07.24.
//

import Foundation

extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var containsSpecialCharacters: Bool {
        // All characters that are not in this set
        let characterSet = CharacterSet(charactersIn: "-abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZßАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЬЮЯабвгдежзийклмнопрстуфхцчшщъьюя-").inverted
        
        return self.replacingOccurrences(of: " ", with: "").rangeOfCharacter(from: characterSet) != nil
    }
}
