//
//  ViewController.swift
//  ybs-techtask
//
//  Created by Nov Petrović on 24/05/2023.
//

import UIKit

class DetailVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var ownerTitleLabel: UILabel!
    
    // MARK: - Properties
    private let viewModel: DetailViewModel
    
    // MARK: - Init
    init(viewModel: DetailViewModel) {
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
        viewModel.fetchPhotoDetail()
    }
    
    // MARK: - Public Interface
    func updateUI(_ photoDetail: PhotoDetail) {
        photoTitleLabel.text = "photoId = \(photoDetail.id)"
        ownerTitleLabel.text = "Photo provided by \(photoDetail.owner.username)"
    }
}

extension DetailVC: DetailViewModelDelegate {
    func didFetchPhotoDetail(_ photoDetail: PhotoDetail) {
        updateUI(photoDetail)
    }
    
    func didGetError(_ error: APIError) {
        print(error)
    }
}
