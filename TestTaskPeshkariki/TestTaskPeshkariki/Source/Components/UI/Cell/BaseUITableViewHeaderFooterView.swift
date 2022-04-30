//
//  BaseUITableViewHeaderFooterView.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//

import UIKit

class BaseUITableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {}
}
