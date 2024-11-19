//
//  SearchProductPresenter.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 17.11.24.
//

import Foundation

protocol SearchProductPresenting {
    func viewWillAppear()
    func didStartToSearch(text: String?)
    func didTapFavourites()
}

class SearchProductPresenter: SearchProductPresenting {
    
    weak var view: SearchProductViewControlling?
    private let interactor: SearchProductInteracting
    private let router: SearchProductRouting
    
    private var searchWord: String? = nil
    
    init(interactor: SearchProductInteracting, router: SearchProductRouting) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewWillAppear() {
        loadData()
    }
    
    func didStartToSearch(text: String?) {
        searchWord = text
        loadData()
    }
    
    func didTapFavourites() {
        router.openFavourites()
    }
    
    private func loadData() {
        guard let searchWord, !searchWord.trimmed.isEmpty else {
            view?.data = []
            return
        }
        
        view?.isLoading = true
        interactor.searchProducts(searchWord: searchWord) { [weak self] result in
            self?.view?.isLoading = false
            guard case .success(let data) = result else { return }
            self?.interactor.fetchFavouriteProducts(completion: { saved in
                // This check is needed if the user deletes the search text but the request result for the previous search is received afterwards
                guard let searchWord = self?.searchWord, !searchWord.trimmed.isEmpty else { return }
                
                self?.buildViewData(using: data.products, saved: saved)
            })
        }
    }
    
    private func buildViewData(using products: [Product], saved: [Product]) {
        let products: [ProductsListViewController.Data] = products.map { product in
            let data: ProductCollectionViewCell.Data = .init(titleSubtileData: .init(title: product.title, description: product.description), pictureData: .init(imageUrl: product.thumbnail, isFavourite: saved.contains(where: { $0.id == product.id })) { updater in
                self.interactor.updateFavourite(product, completion: updater)
            })
            
            return .init(cellData: data, tapHandler: {
                self.openProductDetails(data: data)
            })
        }
        
        view?.data = products
    }
    
    private func openFavourites() {
        router.openFavourites()
    }
    
    private func openProductDetails(data: ProductCollectionViewCell.Data) {
        router.openProductDetails(data: data)
    }
}
