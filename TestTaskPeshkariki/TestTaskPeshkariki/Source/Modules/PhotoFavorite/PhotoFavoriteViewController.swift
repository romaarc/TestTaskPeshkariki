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
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var viewModels = [PCDModel]()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.hidesWhenStopped = true
        activity.color = .black
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()

    init(output: PhotoFavoriteViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        setupTableView()
        setupActivityIndicator()
        output.viewDidLoad()
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.safeAreaLayoutGuide.layoutFrame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModels.removeAll()
        output.viewDidLoad()
    }
}

//MARK: - TableView
private extension PhotoFavoriteViewController {
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = .clear
        tableView.separatorInset = UIEdgeInsets(top: 10, left: .zero, bottom: .zero, right: .zero)
        tableView.register(PhotoFavoriteCell.self)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension PhotoFavoriteViewController: UITableViewDelegate {}

extension PhotoFavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cellType: PhotoFavoriteCell.self, for: indexPath)
        let viewModel = viewModels[indexPath.row]
        cell.update(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let generator = UISelectionFeedbackGenerator()
        let cdModel = viewModels[indexPath.row]
        generator.selectionChanged()
        output.onCellTap(with: PhotoViewModel(id: cdModel.id ?? "",
                                              user: User(name: cdModel.autorName ?? ""),
                                              urls: Urls(regular: cdModel.url ?? "", thumb: ""),
                                              createdAt: cdModel.createdAt ?? "",
                                              downloads: Int(cdModel.downloads),
                                              location: Location(city: cdModel.city, country: cdModel.country)))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

extension PhotoFavoriteViewController: PhotoFavoriteViewInput {
    func set(viewModels: [PCDModel]) {
        self.viewModels = viewModels
        self.tableView.reloadData()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }

    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
}
