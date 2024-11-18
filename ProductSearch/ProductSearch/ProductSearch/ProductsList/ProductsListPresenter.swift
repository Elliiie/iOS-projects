//
//  ProductsListPresenter.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 17.11.24.
//

import Foundation

protocol ProductsListPresenting {
    func viewDidLoad()
    func didStartToSearch(text: String?)
    func didCancelSearch()
}

class ProductsListPresenter: ProductsListPresenting {
    
    weak var view: ProductsListViewControlling?
    private let interactor: ProductsListInteracting
    private let router: ProductsListRouting
    
    init(interactor: ProductsListInteracting, router: ProductsListRouting) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        fetchProducts()
    }
    
    func didStartToSearch(text: String?) {
        guard let text else { return }
        
        view?.isLoading = true
        interactor.searchProducts(searchWord: text) { [weak self] result in
            self?.view?.isLoading = false
            guard case .success(let data) = result else { return }
            self?.buildViewData(using: data.products)
        }
    }
    
    func didCancelSearch() {
        fetchProducts()
    }
    
    private func fetchProducts() {
        view?.isLoading = true
        interactor.getProducts { [weak self] result in
            self?.view?.isLoading = false
            guard case .success(let data) = result else { return }
            self?.buildViewData(using: data.products)
        }
    }
    
    private func buildViewData(using products: [Product]) {
        let products: [ProductsListViewController.Data.ProductCellData] = products.map { product in
            let data: ProductCollectionViewCell.Data = .init(titleSubtileData: .init(title: product.title, description: product.description), pictureData: .init(imageUrl: product.thumbnail, isFavourite: false) { favourite in
                self.handleFavorite(product: product, isFavourite: favourite)
            })
            
            return .init(data: data, tapHandler: {
                self.openProductDetails(data: data)
            })
        }
        
        view?.data = .init(productsCellsData: products, favouritesButtonTapHandler: openFavourites)
    }
    
    private func handleFavorite(product: Product, isFavourite: Bool) {
        // TODO: Save in favourites
    }
    
    private func openFavourites() {
        router.openFavourites()
    }
    
    private func openProductDetails(data: ProductCollectionViewCell.Data) {
        router.openProductDetails(data: data)
    }
}
