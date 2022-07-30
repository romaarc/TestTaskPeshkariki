//
//  UIAlertController+Extension.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//

import UIKit

extension UIAlertController {
    static func display(msg: String) -> UIAlertController {
        let alertContoller = UIAlertController(
            title: "Произошло сохранение",
            message: msg,
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: "Хорошо",
            style: .default,
            handler: { [weak alertContoller] _ in
                alertContoller?.dismiss(animated: true, completion: nil)
        })
        alertContoller.addAction(action)
        return alertContoller
    }
}
