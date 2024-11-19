//
//  RequestsManager.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 17.11.24.
//

import Foundation

private let BaseUrl = "https://dummyjson.com/"

class RequestsManager {
    
    static let shared = RequestsManager()
    
    private let session: URLSession

    private init() {
        self.session = URLSession.shared
    }
    
    func searchProducts(searchWord: String, completion: @escaping (Result<ProductsResponse, Error>) -> Void) {
        performRequest(endpoint: "products/search?q=\(searchWord)", completion: completion)
    }
    
    private func performRequest<T: Decodable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        var urlRequest = URLRequest(url: URL(string: BaseUrl.appending(endpoint))!)
        urlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(error ?? NSError(domain: "Generic error", code: 1)))
                }
                return
            }
            
            let responseModel = try? JSONDecoder().decode(T.self, from: data)
            
            if let responseModel {
                DispatchQueue.main.async {
                    completion(.success(responseModel))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(error ?? NSError(domain: "Generic error", code: 1)))
                }
            }
        }
        
        task.resume()
    }
}
