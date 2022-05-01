//
//  PhotoDetailViewCell.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//
import UIKit

final class PhotoDetailViewCell: BaseUITableViewCell {
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = Font.sber(ofSize: Font.Size.seventeen, weight: .bold)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: -0.41, .paragraphStyle: paragraphStyle])
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.gray
        label.font = Font.sber(ofSize: Font.Size.fithteen, weight: .regular)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: -0.24, .paragraphStyle: paragraphStyle])
        return label
    }()
    
    override func setupView() {
        [label, subLabel].forEach { contentView.addSubview($0) }
        setupUI()
    }
}
//MARK: - UI
extension PhotoDetailViewCell {
    private func setupUI() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.5),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            subLabel.topAnchor.constraint(equalTo: label.bottomAnchor),
            subLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            subLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.5),
        ])
    }
//MARK: - Updating ViewModel
    func update(with viewModel: PhotoViewModel, indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            label.text = "Имя автора"
            subLabel.text = viewModel.user.name
            isUserInteractionEnabled = false
        case 1:
            label.text = "Дата создания"
            subLabel.text = viewModel.createdAt
            isUserInteractionEnabled = false
        case 2:
            label.text = "Местоположение"
            if let city = viewModel.location.city, let country = viewModel.location.country  {
                if !city.isEmpty || !country.isEmpty {
                    subLabel.text = country + ", " + city
                } else {
                    subLabel.text = "Нет информации"
                }
            } else {
                subLabel.text = "Нет информации"
            }
            isUserInteractionEnabled = false
        case 3:
            label.text = "Количество скачиваний"
            subLabel.text = String(viewModel.downloads)
            isUserInteractionEnabled = false
        default:
            break
        }
    }
}
