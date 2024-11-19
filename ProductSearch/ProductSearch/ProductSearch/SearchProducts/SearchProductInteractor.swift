//
//  SearchProductInteractor.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 17.11.24.
//

import Foundation

protocol SearchProductInteracting {
    func searchProducts(searchWord: String, completion: @escaping (Result<ProductsResponse, Error>) -> Void)
    func updateFavourite(_ product: Product, completion: (Bool) -> Void)
    func fetchFavouriteProducts(completion: ([Product]) -> Void)
}

class SearchProductInteractor: SearchProductInteracting {

    func searchProducts(searchWord: String, completion: @escaping (Result<ProductsResponse, any Error>) -> Void) {
        RequestsManager.shared.searchProducts(searchWord: searchWord, completion: completion)
    }
    
    func updateFavourite(_ product: Product, completion: (Bool) -> Void) {
        DatabaseManager.shared.update(product, completion: completion)
    }
    
    func fetchFavouriteProducts(completion: ([Product]) -> Void) {
        DatabaseManager.shared.fetchAll(completion: completion)
    }
}
