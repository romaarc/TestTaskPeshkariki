//
//  PhotoFavoriteViewController.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//  
//

import UIKit

final class PhotoFavoriteViewController: UIViewController {
	private let output: PhotoFavoriteViewOutput

    init(output: PhotoFavoriteViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension PhotoFavoriteViewController: PhotoFavoriteViewInput {
}
