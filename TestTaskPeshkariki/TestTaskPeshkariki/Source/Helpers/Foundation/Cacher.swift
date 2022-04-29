//
//  Cacher.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//

import Kingfisher
import UIKit.UIImageView

extension UIImageView {
    func setupCache() {
        let cache = ImageCache.default
        // Limit memory cache size to 100 MB.
        cache.memoryStorage.config.totalCostLimit = 100 * 1024 * 1024

        // Limit memory cache to hold 862 images at most.
        cache.memoryStorage.config.countLimit = 862
        
        // Limit disk cache size to 300 MB.
        cache.diskStorage.config.sizeLimit = 300 * 1024 * 1024
        
        // Memory image expires after 5 min.
        cache.memoryStorage.config.expiration = .seconds(60 * 5)
    }
}
