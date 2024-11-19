//
//  SearchProductViewController.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 17.11.24.
//

import Foundation
import UIKit
import EasyPeasy

protocol SearchProductViewControlling: UIViewController {
    var data: SearchProductViewController.Data? { get set }
    var isLoading: Bool { get set }
}

private enum Layout {
    static let SearchBarHeight: CGFloat = 40
}

class SearchProductViewController: UIViewController, SearchProductViewControlling {
 
    struct Data {
        let productsCellsData: [ProductsListViewController.Data]
        let favouritesButtonTapHandler: () -> Void
    }
    
    var data: SearchProductViewController.Data? {
        didSet {
            productsList.data = data?.productsCellsData ?? []
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            productsList.view.isHidden = isLoading
            loadingView.isHidden = !isLoading
            isLoading ? loadingView.startAnimating() : loadingView.stopAnimating()
        }
    }
    
    private let searchBar = UISearchBar()
    private var productsList = ProductsListViewController()
    private let loadingView = UIActivityIndicatorView(style: .large)
    private var favouriteButton: UIBarButtonItem!
    
    private let presenter: SearchProductPresenting
    
    init(presenter: SearchProductPresenting) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Search"
        
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search products"
        searchBar.delegate = self
        view.addSubview(searchBar)

        view.addSubview(loadingView)

        addChild(productsList)
        view.addSubview(productsList.view)
        productsList.willMove(toParent: self)
        
        favouriteButton = UIBarButtonItem(image: .init(systemName: "heart.fill"), style: .plain, target: self, action: #selector(didTapFavourites(sender:)))
        favouriteButton.tintColor = .red
        navigationItem.rightBarButtonItem = favouriteButton
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)

        addConstraints()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
    
    @objc private func didTapFavourites(sender: UIBarButtonItem) {
        data?.favouritesButtonTapHandler()
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    private func addConstraints() {
        searchBar.easy.layout([
            Top(Offset.Small).to(view.safeAreaLayoutGuide, .top),
            Leading(Offset.Small),
            Trailing(Offset.Small),
            Height(Layout.SearchBarHeight)
        ])
        
        productsList.view.easy.layout([
            Top(Offset.Medium).to(searchBar),
            Leading(0),
            Trailing(0),
            Bottom(Offset.Medium).to(view.safeAreaLayoutGuide, .bottom)
        ])
        
        loadingView.easy.layout([
            CenterX(),
            CenterY()
        ])
    }
}

extension SearchProductViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.didStartToSearch(text: searchBar.text)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.didStartToSearch(text: searchBar.text)
        searchBar.resignFirstResponder()
    }
}

extension SearchProductViewController {
    static func build() -> UIViewController {
        let interactor = SearchProductInteractor()
        let router = SearchProductRouter()
        let presenter = SearchProductPresenter(interactor: interactor, router: router)
        let viewController = SearchProductViewController(presenter: presenter)
        
        presenter.view = viewController
        router.view = viewController
        
        return viewController
    }
}
