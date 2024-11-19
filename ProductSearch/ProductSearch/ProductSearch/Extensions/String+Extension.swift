//
//  String+Extension.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 19.11.24.
//

import Foundation

extension String {
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
