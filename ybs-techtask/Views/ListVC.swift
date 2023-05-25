//
//  ViewController.swift
//  ybs-techtask
//
//  Created by Nov Petrović on 23/05/2023.
//

import UIKit

class ListVC: UIViewController {
    
    // MARK: - CollectionView Properties
    enum Section { case main }
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, PhotoModel>!
    
    // MARK: - Properties
    private let viewModel: ListViewModel
    private let tag: String
    
    // MARK: - Init
    init(tag: String,
         viewModel: ListViewModel
    ) {
        self.tag = tag
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        configureViewController()
        configureCollectionView()
        viewModel.fetchPhotos(for: tag)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Public
    func updateUI(with photos: [PhotoModel]) {
        self.updateData(on: photos)
    }
    
    func updateData(on photos: [PhotoModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, PhotoModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(photos)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    // MARK: - Configure subviews
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = tag
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(YBPhotoCell.self, forCellWithReuseIdentifier: YBPhotoCell.reuseID)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, PhotoModel>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, photo) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YBPhotoCell.reuseID, for: indexPath) as! YBPhotoCell
            Task { await cell.set(photo: photo) }
            return cell
        })
    }
}

extension ListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoId = viewModel.photoList[indexPath.row].id
        viewModel.handleTappedPhoto(photoId)
    }
}

extension ListVC: ListViewModelDelegate {
    func didFetchPhotos() {
        updateData(on: viewModel.photoList)
    }
    
    func didGetError(_ error: APIError) {
        print("DEBUG: Error")
    }
}
