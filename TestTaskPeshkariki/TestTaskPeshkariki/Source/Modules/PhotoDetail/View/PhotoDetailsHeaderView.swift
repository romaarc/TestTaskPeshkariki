//
//  PhotoDetailsHeaderView.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//

import UIKit

final class PhotoDetailsHeaderView: BaseView {

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = Colors.grayDetail
        return imageView
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = Colors.grayDetail.cgColor
        imageView.layer.borderWidth = 5.0
        imageView.layer.cornerRadius = 70.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = Font.sber(ofSize: Font.Size.twentyEight, weight: .bold)

        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.02
        
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: 0.34, .paragraphStyle: paragraphStyle])
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func setupView() {
        backgroundColor = Colors.grayDetail
        [backgroundImageView, avatarImageView, nameLabel].forEach { addSubview($0) }
    }

    override func setupLayout() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 19.0),
            avatarImageView.leadingAnchor.constraint(equalTo: centerXAnchor, constant: -70.0),
            avatarImageView.heightAnchor.constraint(equalToConstant: 140.0),
            avatarImageView.widthAnchor.constraint(equalToConstant: 140.0),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
        ])
    }
    
    func update(viewModel: PhotoViewModel) {
        nameLabel.text = viewModel.user.name
        avatarImageView.setImageOffline(with: URL(string: viewModel.urls.regular))
    }
}
