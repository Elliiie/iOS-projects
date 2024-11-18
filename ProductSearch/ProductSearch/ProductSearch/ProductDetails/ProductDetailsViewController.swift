//
//  ProductDetailsViewController.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 17.11.24.
//

import Foundation
import UIKit
import EasyPeasy

private enum Layout {
    static let ImageSizeRatio: CGFloat = 0.4
}

class ProductDetailsViewController: UIViewController {

    var data: ProductCollectionViewCell.Data? {
        didSet {
            guard let data else { return }
            setup(data: data)
        }
    }
    
    private let titleSubtitleView = TitleSubtitleView()
    private let pictureView = ImageButtonView()
    
    private var isInPortrait: Bool {
        return UIDevice.current.orientation.isPortrait
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(titleSubtitleView)
        view.addSubview(pictureView)
        
        addConstraints()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        reloadConstraints()
    }
    
    private func setup(data: ProductCollectionViewCell.Data) {
        pictureView.data = data.pictureData
        titleSubtitleView.data = data.titleSubtileData
        
        reloadConstraints()
    }
    
    private func addConstraints() {
        pictureView.easy.layout([
            Top(Offset.Medium).to(view.safeAreaLayoutGuide, .top),
            Leading(Offset.Medium),
            Trailing(Offset.Medium).when { self.isInPortrait },
            Height(*Layout.ImageSizeRatio).like(view, .height).when { self.isInPortrait },
            Width(*Layout.ImageSizeRatio).like(view, .width).when { !self.isInPortrait },
            Bottom(Offset.Medium).to(view.safeAreaLayoutGuide, .bottom).when { !self.isInPortrait }
        ])
        
        titleSubtitleView.easy.layout([
            Top(Offset.Medium).to(pictureView).when { self.isInPortrait },
            Top(Offset.Medium).to(view.safeAreaLayoutGuide, .top).when { !self.isInPortrait },
            Leading(Offset.Medium).when { self.isInPortrait },
            Leading(Offset.Normal).to(pictureView).when { !self.isInPortrait },
            Trailing(Offset.Normal).to(view.safeAreaLayoutGuide, .trailing)
        ])
    }
    
    private func reloadConstraints() {
        pictureView.easy.reload()
        titleSubtitleView.easy.reload()
    }
}
