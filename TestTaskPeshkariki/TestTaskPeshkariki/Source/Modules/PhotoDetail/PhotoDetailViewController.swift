//
//  PhotoDetailViewController.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//  
//

import UIKit

final class PhotoDetailViewController: UIViewController {
	private let output: PhotoDetailViewOutput
    private let viewModel: PhotoViewModel
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var tableView = UITableView(frame: .zero, style: .grouped)
    private lazy var photoDetailsHeaderView = PhotoDetailsHeaderView()
    
    private let saveButton: UIButton = {
        let btn = RoundedButton(radius: 10, backgroundColor: Colors.purple, textColor: .white)
        btn.setTitle("Сохранить", for: .normal)
        btn.isEnabled = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.hidesWhenStopped = true
        activity.color = .black
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()

    init(output: PhotoDetailViewOutput, viewModel: PhotoViewModel) {
        self.output = output
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        setupNavBar()
        setupTableView()
        output.viewDidLoad(withId: viewModel.id)
	}
    
    private func setupNavBar() {
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        title = viewModel.user.name
    }
}

//MARK: - TableView
private extension PhotoDetailViewController {
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let contentViewHeightAnchor = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        contentViewHeightAnchor.priority = .defaultLow
        contentViewHeightAnchor.isActive = true
        
        contentView.backgroundColor = .white
    }
    
    private func setupHeaderView() {
        contentView.addSubview(photoDetailsHeaderView)
        NSLayoutConstraint.activate([
            photoDetailsHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoDetailsHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoDetailsHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoDetailsHeaderView.heightAnchor.constraint(equalToConstant: 254)
        ])
        photoDetailsHeaderView.update(viewModel: viewModel)
    }
    
    func setupTableView() {
        setupScrollView()
        setupHeaderView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.isUserInteractionEnabled = true
        tableView.backgroundColor = .white
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = .zero
        }
        tableView.sectionFooterHeight = .zero
        
        tableView.register(PhotoDetailViewCell.self)
        tableView.register(PhotoHeaderSectionView.self)

        contentView.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: photoDetailsHeaderView.bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        contentView.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            saveButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 7),
            saveButton.heightAnchor.constraint(equalToConstant: 47)
        ])
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
    }
    
    @objc private func save() {
        if saveButton.titleLabel?.text == "Cохранено" {
            let alert = UIAlertController(title: "Вы уверены?", message: "Данные будут удалены из сохраненных", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                guard let self = self else { return }
                self.output.remove(with: self.viewModel)
                self.saveButton.setTitle("Cохранить", for: .normal)
                self.output.back()
            }))

            alert.addAction(UIAlertAction(title: "Нет", style: .destructive))

            present(alert, animated: true, completion: nil)
        } else {
            output.onSaveButtonTap(with: viewModel)
            present(UIAlertController.display(msg: ""), animated: true) { [weak self] in
                self?.output.back()
            }
            saveButton.setTitle("Cохранено", for: .normal)
        }
    }
}

//MARK: - UITableViewDataSource
extension PhotoDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        PhotoDetailConstants.Layout.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return PhotoDetailConstants.Layout.cellCount
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueCell(cellType: PhotoDetailViewCell.self, for: indexPath)
            cell.update(with: viewModel, indexPath: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
//MARK: - UITableViewDelegate
extension PhotoDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueHeaderFooterViewCell(cellType: PhotoHeaderSectionView.self)
        switch section {
        case 0:
            header.update(someText: PhotoDetailConstants.Strings.headerInfo)
        default:
            return nil
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 54.5
        default:
            return 0.0
        }
    }
}
//MARK: - activityIndicator
extension PhotoDetailViewController {
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }

    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
}

extension PhotoDetailViewController: PhotoDetailViewInput {
    func setSaveButton(isSaved: Bool) {
        saveButton.setTitle(isSaved ? "Cохранено" : "Сохранить", for: .normal)
    }
}
