//
//  PhotosViewController.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//  
//

import UIKit

final class PhotosViewController: BaseViewController {
	private let output: PhotosViewOutput
    private let searchController = UISearchController(searchResultsController: nil)
    private var viewModels: [PhotoViewModel] = []

    init(output: PhotosViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        super.setupUI()
        output.viewDidLoad()
        setupSearchController()
	}
    
    override func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        collectionView.register(PhotoCell.self)
        collectionView.addSubview(activityIndicator)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.frame
    }
}

//MARK: - UICollectionViewDataSource
extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellType: PhotoCell.self, for: indexPath)
        let viewModel = viewModels[indexPath.row]
        cell.update(with: viewModel)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let generator = UISelectionFeedbackGenerator()
        //let viewModel = viewModels[indexPath.row]
        generator.selectionChanged()
        //output.onCellTap(with: viewModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //output.willDisplay(at: indexPath.item)
    }
}

extension PhotosViewController: PhotosViewInput {
    func didError() {
//        DispatchQueue.main.async {
//            if self.viewModels.isEmpty {
//                self.collectionView.performBatchUpdates {
//                    var indexPaths: [IndexPath] = []
//                    for s in 0..<self.collectionView.numberOfSections {
//                        for i in 0..<self.collectionView.numberOfItems(inSection: s) {
//                            indexPaths.append(IndexPath(row: i, section: s))
//                        }
//                    }
//                    self.collectionView.deleteItems(at: indexPaths)
//                } completion: {_ in
//                    self.collectionView.setEmptyMessage(message: PhotosConstants.Strings.emptyMessageDidError)
//                }
//            }
//        }
    }
    
    func set(viewModels: [PhotoViewModel]) {
        self.viewModels = viewModels
        DispatchQueue.main.async {
            if self.viewModels.isEmpty {
                //self.collectionView.setEmptyMessage(message: PhotosConstants.Strings.emptyMessage)
            } else {
                //self.collectionView.restore()
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: - Search bar methods
extension PhotosViewController: UISearchBarDelegate, UISearchResultsUpdating {
    private func setupSearchController() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = PhotosConstants.Strings.searchBarPlaceholder
        searchController.searchBar.searchTextField.font = Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
        searchController.obscuresBackgroundDuringPresentation = false
        
        let attributes:[NSAttributedString.Key: Any] = [
            .font: Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = PhotosConstants.Strings.UISearchBarTitle
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if !text.isEmpty {
            viewModels.removeAll()
            //output.searchBarTextDidEndEditing(with: text, and: filter)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        if let _ = filter.statusIndexPath, let _ = filter.genderIndexPath {
//            viewModels.removeAll()
//            //output.searchBarTextDidEndEditing(with: "", and: filter)
//        } else {
//            viewModels.removeAll()
//            //output.searchBarCancelButtonClicked()
//        }
    }
}
