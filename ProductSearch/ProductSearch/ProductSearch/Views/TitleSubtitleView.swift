//
//  TitleSubtitleView.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 17.11.24.
//

import Foundation
import UIKit
import EasyPeasy

private enum Layout {
    static let TitleFontSize: CGFloat = 14
    static let DescriptionFontSize: CGFloat = 12
}

class TitleSubtitleView: UIView {
    
    struct Data {
        let title: String
        let description: String
    }
    
    var data: Data? {
        didSet {
            titleLabel.text = data?.title
            descriptionLabel.text = data?.description
        }
    }
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
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

        titleLabel.font = .systemFont(ofSize: Layout.TitleFontSize, weight: .bold)
        titleLabel.textAlignment = .natural
        titleLabel.textColor = .black
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 1
        addSubview(titleLabel)
        
        descriptionLabel.font = .systemFont(ofSize: Layout.DescriptionFontSize, weight: .regular)
        descriptionLabel.textAlignment = .natural
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byTruncatingTail
        addSubview(descriptionLabel)
        
        addConstraints()
    }
    
    private func addConstraints() {
        titleLabel.easy.layout([
            Top(0),
            Leading(0),
            Trailing(0)
        ])
        
        descriptionLabel.easy.layout([
            Top(Offset.Small).to(titleLabel),
            Leading(0),
            Trailing(0),
            Bottom(0)
        ])
    }
}
