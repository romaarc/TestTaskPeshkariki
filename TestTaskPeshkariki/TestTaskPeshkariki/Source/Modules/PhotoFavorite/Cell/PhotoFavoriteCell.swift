//
//  PhotoFavoriteCell.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//

import UIKit

final class PhotoFavoriteCell: BaseUITableViewCell {

    private let pictImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        image.layer.masksToBounds = true
        return image
    }()
    
    private lazy var posterView: GradientView = {
        let gradientView = GradientView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.layer.cornerRadius = 15
        gradientView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        gradientView.layer.masksToBounds = true
        return gradientView
    }()
    
    private let label: TopAlignedLabel = {
        let label = TopAlignedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = Font.sber(ofSize: Font.Size.seventeen, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.90

        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.numberOfLines = 0
        return label
    }()
    
    override func setupView() {
        selectionStyle = .none
        backgroundColor = .white
        [pictImageView, posterView, label].forEach { addSubview($0) }
        setupUI()
    }
}

extension PhotoFavoriteCell {
//MARK: - UI
    private func setupUI() {
        NSLayoutConstraint.activate([
            pictImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            pictImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            pictImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            pictImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            posterView.topAnchor.constraint(equalTo: pictImageView.topAnchor, constant: 130),
            posterView.leadingAnchor.constraint(equalTo: pictImageView.leadingAnchor),
            posterView.trailingAnchor.constraint(equalTo: pictImageView.trailingAnchor),
            posterView.bottomAnchor.constraint(equalTo: pictImageView.bottomAnchor),
            
            label.topAnchor.constraint(equalTo: posterView.topAnchor, constant: 15),
            label.leadingAnchor.constraint(equalTo: posterView.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: -5),
            label.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
//MARK: - Update with ViewModel
    func update(with viewModel: PCDModel) {
        pictImageView.setImageOffline(with: URL(string: viewModel.url ?? ""))
        label.text = viewModel.autorName
    }
}
