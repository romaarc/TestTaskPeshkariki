//
//  PhotoCell.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//

import UIKit

class PhotoCell: BaseUICollectionViewCell {
    
    private let imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override func setupView() {
        [imageView].forEach { contentView.addSubview($0) }
        setupUI()
    }
}
//MARK: - UI
extension PhotoCell {
    private func setupUI() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
//MARK: - Update with ViewModel
    func update(with viewModel: PhotoViewModel) {
        imageView.setImage(with: URL(string: viewModel.urls.regular))
    }
}
