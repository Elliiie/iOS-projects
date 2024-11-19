//
//  FavouriteProductsListRouter.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 19.11.24.
//

import Foundation
import UIKit

protocol FavouriteProductsListRouting {
    func openProductDetails(data: ProductCollectionViewCell.Data)
}

class FavouriteProductsListRouter: FavouriteProductsListRouting {
    
    var view: UIViewController?
    
    func openProductDetails(data: ProductCollectionViewCell.Data) {
        let productDetailsView = ProductDetailsViewController()
        productDetailsView.data = data
        
        view?.navigationController?.pushViewController(productDetailsView, animated: true)
    }
}
