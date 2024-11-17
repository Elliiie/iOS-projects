//
//  ProductsListViewController.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 17.11.24.
//

import Foundation
import UIKit

private let ProductCollectionViewCellIdentifier = "ProductCollectionViewCellIdentifier"

class ProductsListViewController: UIViewController {
 
    var data: [ProductCollectionViewCell.Data] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let searchBar = UISearchBar()
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var favouriteButton: UIBarButtonItem!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search products"
        searchBar.delegate = self
        view.addSubview(searchBar)

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

        addConstraints()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.collectionView.collectionViewLayout = self.createLayout(for: size)
        }, completion: nil)
    }
    
    private func createLayout(for size: CGSize) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let isPortrait = size.width < size.height
        
        if isPortrait {
            layout.itemSize = CGSize(width: size.width - 16, height: 250)
        } else {
            let itemWidth = (size.width / 3) - 16
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        }
        
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }
    
    private func addConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        let searchBarConstraints: [NSLayoutConstraint] = [
            NSLayoutConstraint(item: searchBar, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: searchBar, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: searchBar, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -4),
            NSLayoutConstraint(item: searchBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 40)
        ]
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let collectionViewConstraints: [NSLayoutConstraint] = [
            NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: searchBar, attribute: .bottom, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -8),
            NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -8)
        ]
        
        view.addConstraints(searchBarConstraints)
        view.addConstraints(collectionViewConstraints)
    }
}

extension ProductsListViewController: UISearchBarDelegate {
    
}

extension ProductsListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCellIdentifier, for: indexPath) as! ProductCollectionViewCell
        
        cell.data = data[indexPath.row]
        
        return cell
    }
    
}
