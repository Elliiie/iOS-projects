//
//  ProductsListInteractor.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 17.11.24.
//

import Foundation

protocol ProductsListInteracting {
    func getProducts(completion: @escaping (Result<ProductsResponse, Error>) -> Void)
    func searchProducts(searchWord: String, completion: @escaping (Result<ProductsResponse, Error>) -> Void)
}

class ProductsListInteractor: ProductsListInteracting {
    
    func getProducts(completion: @escaping (Result<ProductsResponse, any Error>) -> Void) {
        RequestsManager.shared.getProducts(completion: completion)
    }
    
    func searchProducts(searchWord: String, completion: @escaping (Result<ProductsResponse, any Error>) -> Void) {
        RequestsManager.shared.searchProducts(searchWord: searchWord, completion: completion)
    }
}
