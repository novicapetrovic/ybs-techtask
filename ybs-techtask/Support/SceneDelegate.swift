//
//  SceneDelegate.swift
//  ybs-techtask
//
//  Created by Nov Petrović on 23/05/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private var coordinator: MainCoordinator?
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let networkService = NetworkService()
        let viewModel = SearchViewModel()
        let navigationController = UINavigationController(rootViewController: SearchVC(viewModel: viewModel))
        let mainCoordinator = MainCoordinator(
            navigationController: navigationController,
            networkService: networkService
        )
        coordinator = mainCoordinator
        coordinator?.start()
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
