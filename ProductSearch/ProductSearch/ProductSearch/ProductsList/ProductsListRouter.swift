//
//  ProductsListRouter.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 17.11.24.
//

import Foundation
import UIKit

protocol ProductsListRouting {
    func openFavourites()
    func openProductDetails(data: ProductCollectionViewCell.Data)
}

class ProductsListRouter: ProductsListRouting {
    
    var view: UIViewController?
    
    func openFavourites() {
        
    }
    
    func openProductDetails(data: ProductCollectionViewCell.Data) {
        let productDetailsView = ProductDetailsViewController()
        productDetailsView.data = data
        
        view?.navigationController?.pushViewController(productDetailsView, animated: true)
    }
}
