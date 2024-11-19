//
//  ProductsListViewController.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 19.11.24.
//

import Foundation
import UIKit
import EasyPeasy

protocol ProductsListViewControlling: UIViewController {
    var data: [ProductsListViewController.Data] { get set }
}

protocol ProductsListPresenting {
    func viewDidLoad()
}

private enum Layout {
    static let MaxItemCountInLandscape: CGFloat = 3
    static let RowHeightInPortrait: CGFloat = 250
    static let LandscapeItemWidthPercentage: CGFloat = 0.8
}

private let ProductCollectionViewCellIdentifier = "ProductCollectionViewCellIdentifier"

class ProductsListViewController: UIViewController, ProductsListViewControlling {
    
    struct Data {
        let cellData: ProductCollectionViewCell.Data
        let tapHandler: () -> Void
    }
    
    var data: [Data] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let presenter: ProductsListPresenting?
    
    init(presenter: ProductsListPresenting? = nil) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
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
        
        presenter?.viewDidLoad()
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
            layout.itemSize = CGSize(width: size.width - Offset.Normal, height: Layout.RowHeightInPortrait)
        } else {
            let itemWidth = (size.width / Layout.MaxItemCountInLandscape) * Layout.LandscapeItemWidthPercentage
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        }
        
        layout.minimumLineSpacing = Offset.Medium
        layout.minimumInteritemSpacing = Offset.Medium
        layout.sectionInset = UIEdgeInsets(top: Offset.Medium, left: Offset.Medium, bottom: Offset.Medium, right: Offset.Medium)
        return layout
    }
    
    private func addConstraints() {
        collectionView.easy.layout(Edges().to(view.safeAreaLayoutGuide))
    }
}

extension ProductsListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCellIdentifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.data = data[indexPath.row].cellData
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        data[indexPath.row].tapHandler()
    }
}
