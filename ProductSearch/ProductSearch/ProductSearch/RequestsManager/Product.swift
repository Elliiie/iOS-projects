//
//  Product.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 17.11.24.
//

import Foundation


struct ProductsResponse: Decodable {
    private(set) var products: [Product]
}

struct Product: Decodable {
    private(set) var id: Int
    private(set) var title: String
    private(set) var description: String
    private(set) var thumbnail: String
}
