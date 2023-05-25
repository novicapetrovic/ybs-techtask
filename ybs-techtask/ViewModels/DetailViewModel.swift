//
//  DetailViewModel.swift
//  ybs-techtask
//
//  Created by Nov Petrović on 24/05/2023.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func didFetchPhotoDetail(_ photoDetail: PhotoDetail)
    func didGetError(_ error: APIError)
}

final class DetailViewModel {
    
    // MARK: - Properties
    private var networkService: NetworkServiceProtocol
    private var photoId: String
    var photoDetail: PhotoDetail?
    
    weak var coordinator: CoordinatorProtocol?
    weak var delegate: DetailViewModelDelegate?
    
    init(photoId: String,
         networkService: NetworkServiceProtocol) {
        self.photoId = photoId
        self.networkService = networkService
    }
    
    // MARK: - Methods
    func fetchPhotoDetail() {
        networkService.fetchPhotoDetail(photoId: photoId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photoDetail):
                self.photoDetail = photoDetail
                DispatchQueue.main.async {
                    self.delegate?.didFetchPhotoDetail(photoDetail)
                }
                return
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.didGetError(error)
                }
                return
            }
        }
    }
}
