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
        // Limit memory cache size to 1000 MB.
        cache.memoryStorage.config.totalCostLimit = 1000 * 1024 * 1024

        // Limit memory cache to hold 10000 images at most.
        cache.memoryStorage.config.countLimit = 100000

        // Limit disk cache size to 3000 MB.
        cache.diskStorage.config.sizeLimit = 3000 * 1024 * 1024

        // Memory image expires after 1 days.
        cache.memoryStorage.config.expiration = .seconds(86400)
    }
}
