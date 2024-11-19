//
//  ImageButtonView.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 17.11.24.
//

import Foundation
import UIKit
import EasyPeasy

private enum Layout {
    static let FavouriteButtonSize: CGFloat = 30
}

class ImageButtonView: UIView {
    
    struct Data {
        let imageUrl: String
        let isFavourite: Bool
        let isFavouriteTapHandler: ((Bool) -> Void) -> Void
    }
    
    var data: Data? {
        didSet {
            guard let data else {
                clean()
                return
            }
            
            setup(data: data)
        }
    }
    
    private let pictureView = UIImageView()
    private let favouriteButton = UIButton()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        
        pictureView.contentMode = .scaleAspectFit
        addSubview(pictureView)
                
        favouriteButton.contentMode = .scaleAspectFill
        favouriteButton.addTarget(self, action: #selector(didTapFavourite(_:)), for: .touchUpInside)
        addSubview(favouriteButton)
        
        addConstraints()
    }
    
    @objc private func didTapFavourite(_ sender: UIButton)  {
        guard let data else { return }
        
        data.isFavouriteTapHandler({ saved in
            self.updateFavouriteButton(isFavourite: saved)
        })
    }
    
    private func updateFavouriteButton(isFavourite: Bool) {
        favouriteButton.setImage(.init(systemName: isFavourite ? "heart.fill" : "heart"), for: .normal)
        favouriteButton.tintColor = isFavourite ? .red : .black
    }
    
    private func setup(data: Data) {
        pictureView.load(url: data.imageUrl)
        updateFavouriteButton(isFavourite: data.isFavourite)
    }
    
    private func clean() {
        pictureView.image = nil
    }
    
    private func addConstraints() {
        pictureView.easy.layout(Edges())
        
        favouriteButton.easy.layout([
            Top(Offset.Small),
            Trailing(Offset.Small),
            Size(Layout.FavouriteButtonSize)
        ])
    }
}
