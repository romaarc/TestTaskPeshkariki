//
//  UIImageView+Extension.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//

import UIKit.UIImageView
import SDWebImage
import Kingfisher

extension UIImageView {
    func setImage(with url: URL?) {
        self.sd_setImage(with: url)
    }
}

