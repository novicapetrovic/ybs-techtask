//
//  MainCoordinator.swift
//  ybs-techtask
//
//  Created by Nov Petrović on 16/04/2023.
//

import UIKit

final class MainCoordinator: CoordinatorProtocol {
    
    // MARK: - Properties
    var navigationController: UINavigationController
    let networkService: NetworkServiceProtocol
    
    // MARK: - Init
    init(navigationController: UINavigationController,
         networkService: NetworkServiceProtocol
    ) {
        self.navigationController = navigationController
        self.networkService = networkService
    }
    
    // MARK: - Public Interface
    func start() {
        let viewModel = SearchViewModel()
        viewModel.coordinator = self
        let viewController = SearchVC(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func navigateToListVC(tag: String) {
        let viewModel = ListViewModel(networkService: networkService)
        viewModel.coordinator = self
        let viewController = ListVC(tag: tag, viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        navigationController.isNavigationBarHidden = false
    }
    
    func navigateToDetailVC(photoId: String) {
        let viewModel = DetailViewModel(photoId: photoId, networkService: networkService)
        viewModel.coordinator = self
        let viewController = DetailVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        navigationController.isNavigationBarHidden = false
    }
}
