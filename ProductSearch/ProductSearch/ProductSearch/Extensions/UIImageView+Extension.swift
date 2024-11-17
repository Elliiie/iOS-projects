//
//  UIImageView+Extension.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 17.11.24.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: String) {
        DispatchQueue.global().async { [weak self] in
            if let url = URL(string: url), let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
