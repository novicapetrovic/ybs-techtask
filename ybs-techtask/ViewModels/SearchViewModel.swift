//
//  ListViewModel.swift
//  ybs-techtask
//
//  Created by Nov Petrović on 24/05/2023.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func didTapSearch()
}

final class SearchViewModel {
    
    // MARK: - Properties
    weak var coordinator: CoordinatorProtocol?
    weak var delegate: SearchViewModelDelegate?
    
    // MARK: - Methods
    func didTapSearch(tag: String) {
        coordinator?.navigateToListVC(tag: tag)
    }
}
