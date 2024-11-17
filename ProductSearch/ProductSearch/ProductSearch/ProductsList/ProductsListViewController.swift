//
//  ProductsListViewController.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 17.11.24.
//

import Foundation
import UIKit

protocol ProductsListViewControlling: UIViewController {
    var data: ProductsListViewController.Data? { get set }
    var isLoading: Bool { get set }
}

private let ProductCollectionViewCellIdentifier = "ProductCollectionViewCellIdentifier"

private enum Layout {
    static let MaxItemCountInLandscape: CGFloat = 3
    static let RowHeightInPortrait: CGFloat = 250
    static let SearchBarHeight: CGFloat = 40
}

class ProductsListViewController: UIViewController, ProductsListViewControlling {
 
    struct Data {
        let productsData: [ProductCollectionViewCell.Data]
        let favouritesButtonTapHandler: () -> Void
    }
    
    var data: ProductsListViewController.Data? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            collectionView.isHidden = isLoading
            loadingView.isHidden = !isLoading
            isLoading ? loadingView.startAnimating() : loadingView.stopAnimating()
        }
    }
    
    private let searchBar = UISearchBar()
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let loadingView = UIActivityIndicatorView(style: .large)
    private var favouriteButton: UIBarButtonItem!
    
    private let presenter: ProductsListPresenting
    
    init(presenter: ProductsListPresenting) {
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
        
        let layout = createLayout(for: view.frame.size)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCellIdentifier)
        view.addSubview(collectionView)

        favouriteButton = UIBarButtonItem(image: .init(systemName: "heart.fill"), style: .plain, target: self, action: #selector(didTapFavourites(sender:)))
        favouriteButton.tintColor = .red
        navigationItem.rightBarButtonItem = favouriteButton
        
        addConstraints()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.collectionView.collectionViewLayout = self.createLayout(for: size)
        }, completion: nil)
    }
    
    @objc private func didTapFavourites(sender: UIBarButtonItem) {
        data?.favouritesButtonTapHandler()
    }
    
    private func createLayout(for size: CGSize) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let isPortrait = size.width < size.height
        
        if isPortrait {
            layout.itemSize = CGSize(width: size.width - Offset.Normal, height: Layout.RowHeightInPortrait)
        } else {
            let itemWidth = (size.width / Layout.MaxItemCountInLandscape) - Offset.Normal
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
        }
        
        layout.minimumLineSpacing = Offset.Medium
        layout.minimumInteritemSpacing = Offset.Medium
        layout.sectionInset = UIEdgeInsets(top: Offset.Medium, left: Offset.Medium, bottom: Offset.Medium, right: Offset.Medium)
        return layout
    }
    
    private func addConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        let searchBarConstraints: [NSLayoutConstraint] = [
            NSLayoutConstraint(item: searchBar, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: Offset.Small),
            NSLayoutConstraint(item: searchBar, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: Offset.Small),
            NSLayoutConstraint(item: searchBar, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -Offset.Small),
            NSLayoutConstraint(item: searchBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: Layout.SearchBarHeight)
        ]
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let collectionViewConstraints: [NSLayoutConstraint] = [
            NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: searchBar, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        ]
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        let loadingViewConstraints: [NSLayoutConstraint] = [
            NSLayoutConstraint(item: loadingView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: loadingView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        ]
        
        view.addConstraints(searchBarConstraints)
        view.addConstraints(collectionViewConstraints)
        view.addConstraints(loadingViewConstraints)
    }
}

extension ProductsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.didStartToSearch(text: searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.didStartToSearch(text: searchBar.text)
        searchBar.resignFirstResponder()
    }
}

extension ProductsListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.productsData.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCellIdentifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.data = data.productsData[indexPath.row]
        
        return cell
    }
    
}

extension ProductsListViewController {
    static func build() -> UIViewController {
        let interactor = ProductsListInteractor()
        let router = ProductsListRouter()
        let presenter = ProductsListPresenter(interactor: interactor, router: router)
        let viewController = ProductsListViewController(presenter: presenter)
        
        presenter.view = viewController
        router.view = viewController
        
        return viewController
    }
}
