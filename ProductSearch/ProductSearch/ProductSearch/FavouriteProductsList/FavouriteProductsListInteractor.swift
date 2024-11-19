//
//  FavouriteProductsListInteractor.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 19.11.24.
//

import Foundation

protocol FavouriteProductsListInteracting {
    func updateFavourite(_ product: Product, completion: (Bool) -> Void)
    func fetchFavouriteProducts(completion: ([Product]) -> Void)
}

class FavouriteProductsListInteractor: FavouriteProductsListInteracting {
    
    func updateFavourite(_ product: Product, completion: (Bool) -> Void) {
        DatabaseManager.shared.update(product, completion: completion)
    }
    
    func fetchFavouriteProducts(completion: ([Product]) -> Void) {
        DatabaseManager.shared.fetchAll(completion: completion)
    }
}
