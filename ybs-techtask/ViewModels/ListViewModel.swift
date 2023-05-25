//
//  ListViewModel.swift
//  ybs-techtask
//
//  Created by Nov Petrović on 24/05/2023.
//

import Foundation

protocol ListViewModelDelegate: AnyObject {
    func didFetchPhotos()
    func didGetError(_ error: APIError)
}

final class ListViewModel {
    
    // MARK: - Properties
    private var networkService: NetworkServiceProtocol
    weak var coordinator: CoordinatorProtocol?
    weak var delegate: ListViewModelDelegate?
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    var photoList = [PhotoModel]()
    
    // MARK: - Methods
    func fetchPhotos(for tag: String) {
        networkService.fetchPhotos(for: tag) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photoList):
                self.photoList = photoList
                DispatchQueue.main.async {
                    self.delegate?.didFetchPhotos()
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
    
    func handleTappedPhoto(_ photoId: String) {
        coordinator?.navigateToDetailVC(photoId: photoId)
    }
}
