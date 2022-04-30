//
//  UIButton+Extension.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//

import UIKit.UIButton

final class RoundedButton: UIButton {
    
    convenience init(radius: CGFloat, backgroundColor: UIColor, textColor: UIColor) {
        self.init()
        layer.cornerRadius = radius
        clipsToBounds = true
        self.setBackgroundImage(UIImage(color: backgroundColor), for: .normal)
        self.setBackgroundImage(UIImage(color: Colors.rowFilterColor), for: .highlighted)
        setTitleColor(textColor, for: .normal)
    }
}
