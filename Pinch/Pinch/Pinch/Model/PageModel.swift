//
//  PageModel.swift
//  Pinch
//
//  Created by Elena Georgieva on 20.04.23.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
