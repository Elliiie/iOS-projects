//
//  ProductCollectionViewCell.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 17.11.24.
//

import Foundation
import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    struct Data {
        let title: String
        let description: String
        let image: UIImage
        let isFavourite: Bool
        let isFavouriteTapHandler: (Bool) -> Void
    }
    
    var data: Data? {
        didSet {
            guard let data else { return }
            setup(data: data)
        }
    }
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let pictureView = UIImageView()
    private let favouriteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        descriptionLabel.text = nil
        pictureView.image = nil
    }
    
    private func commonInit() {
        contentView.backgroundColor = .white
        
        pictureView.contentMode = .scaleAspectFit
        contentView.addSubview(pictureView)
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        titleLabel.textAlignment = .natural
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 1
        contentView.addSubview(titleLabel)
        
        descriptionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        descriptionLabel.textAlignment = .natural
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(descriptionLabel)
        
        favouriteButton.contentMode = .scaleAspectFit
        favouriteButton.addTarget(self, action: #selector(didTapFavourite(_:)), for: .touchUpInside)
        contentView.addSubview(favouriteButton)
        
        addConstraints()
    }
    
    @objc private func didTapFavourite(_ sender: UIButton)  {
        guard let data else { return }
        
        data.isFavouriteTapHandler(!data.isFavourite)
        updateFavouriteButton(isFavourite: !data.isFavourite)
    }
    
    private func updateFavouriteButton(isFavourite: Bool) {
        favouriteButton.setImage(.init(systemName: isFavourite ? "heart.fill" : "heart"), for: .normal)
        favouriteButton.tintColor = isFavourite ? .red : .black
    }
    
    private func setup(data: Data) {
        pictureView.image = data.image
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        
        updateFavouriteButton(isFavourite: data.isFavourite)
    }
    
    private func addConstraints() {
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        let pictureViewConstraints: [NSLayoutConstraint] = [
            NSLayoutConstraint(item: pictureView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: pictureView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: pictureView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -8),
            NSLayoutConstraint(item: pictureView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.5, constant: 0)
        ]
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLabelConstraints: [NSLayoutConstraint] = [
            NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: pictureView, attribute: .bottom, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -8)
        ]
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        var descriptionLabelConstraints: [NSLayoutConstraint] = [
            NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: descriptionLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: descriptionLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -8)
        ]
        let descriptionLabelBottomConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -16)
        descriptionLabelBottomConstraint.priority = .defaultLow
        
        descriptionLabelConstraints.append(descriptionLabelBottomConstraint)
        
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        let favouriteButtonConstraints: [NSLayoutConstraint] = [
            NSLayoutConstraint(item: favouriteButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30),
            NSLayoutConstraint(item: favouriteButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30),
            NSLayoutConstraint(item: favouriteButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: favouriteButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -4)
        ]
        
        addConstraints(pictureViewConstraints)
        addConstraints(titleLabelConstraints)
        addConstraints(descriptionLabelConstraints)
        addConstraints(favouriteButtonConstraints)
    }
}
