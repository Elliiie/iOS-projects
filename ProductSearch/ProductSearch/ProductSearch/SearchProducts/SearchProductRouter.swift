//
//  SearchProductRouter.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 17.11.24.
//

import Foundation
import UIKit

protocol SearchProductRouting {
    func openFavourites()
    func openProductDetails(data: ProductCollectionViewCell.Data)
}

class SearchProductRouter: SearchProductRouting {
    
    var view: UIViewController?
    
    func openFavourites() {
        let favouriteProductsView = FavouriteProductsListPresenter.build()
        view?.navigationController?.pushViewController(favouriteProductsView, animated: true)
    }
    
    func openProductDetails(data: ProductCollectionViewCell.Data) {
        let productDetailsView = ProductDetailsViewController()
        productDetailsView.data = data
        
        view?.navigationController?.pushViewController(productDetailsView, animated: true)
    }
}
