//
//  ProductCollectionViewCell.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 17.11.24.
//

import Foundation
import UIKit
import EasyPeasy

private enum Layout {
    static let ImageRation: CGFloat = 0.5
    static let LineHeight: CGFloat = 1
}

class ProductCollectionViewCell: UICollectionViewCell {
    
    struct Data {
        let titleSubtileData: TitleSubtitleView.Data
        let pictureData: ImageButtonView.Data
    }
    
    var data: Data? {
        didSet {
            guard let data else { return }
            setup(data: data)
        }
    }
    
    private let titleSubtitleView = TitleSubtitleView()
    private let pictureView = ImageButtonView()
    private let lineView = UIView()
    
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
        
        titleSubtitleView.data = nil
        pictureView.data = nil
    }
    
    private func commonInit() {
        contentView.backgroundColor = .clear
        
        contentView.addSubview(pictureView)
        
        contentView.addSubview(titleSubtitleView)
        
        lineView.backgroundColor = .lightGray
        contentView.addSubview(lineView)
        
        addConstraints()
    }
    
    private func setup(data: Data) {
        pictureView.data = data.pictureData
        titleSubtitleView.data = data.titleSubtileData
    }
    
    private func addConstraints() {
        pictureView.easy.layout([
            Top(Offset.Medium),
            Leading(Offset.Medium),
            Trailing(Offset.Medium),
            Height(Layout.ImageRation * contentView.frame.height)
        ])

        titleSubtitleView.easy.layout([
            Top(Offset.Medium).to(pictureView),
            Leading(Offset.Medium),
            Trailing(Offset.Medium)
        ])
        
        lineView.easy.layout([
            Top(Offset.Medium).to(titleSubtitleView),
            Leading(Offset.Medium),
            Trailing(Offset.Medium),
            Height(Layout.LineHeight),
            Bottom(Offset.Medium)
        ])
    }
}
