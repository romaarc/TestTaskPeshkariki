//
//  UIDevice+Extension.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//

import UIKit
extension UIDevice {
    var isSimulator: Bool {
        #if IOS_SIMULATOR
            return true
        #else
            return false
        #endif
    }
}
