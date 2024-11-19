//
//  FavouriteProductsListPresenter.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 18.11.24.
//

import Foundation
import UIKit

class FavouriteProductsListPresenter: ProductsListPresenting {

    weak var view: ProductsListViewControlling?
    private let interactor: FavouriteProductsListInteracting
    private let router: FavouriteProductsListRouting
    
    init(interactor: FavouriteProductsListInteracting, router: FavouriteProductsListRouting) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        loadData()
    }
    
    private func loadData() {
        interactor.fetchFavouriteProducts { self.buildViewData($0) }
    }
    
    private func buildViewData(_ products: [Product]) {
        let products: [ProductsListViewController.Data] = products.map { product in
            let data: ProductCollectionViewCell.Data = .init(titleSubtileData: .init(title: product.title, description: product.description), pictureData: .init(imageUrl: product.thumbnail, isFavourite: true) { updater in
                self.interactor.updateFavourite(product, completion: updater)
                self.loadData()
            })
            
            return .init(cellData: data) {
                self.openProductDetails(data: data)
            }
        }
        
        view?.data = products
    }
    
    private func openProductDetails(data: ProductCollectionViewCell.Data) {
        router.openProductDetails(data: data)
    }
}

extension FavouriteProductsListPresenter {
    static func build() -> UIViewController {
        let interactor = FavouriteProductsListInteractor()
        let router = FavouriteProductsListRouter()
        let presenter = FavouriteProductsListPresenter(interactor: interactor, router: router)
        
        let view = ProductsListViewController(presenter: presenter)
        view.title = "Favourites"
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
