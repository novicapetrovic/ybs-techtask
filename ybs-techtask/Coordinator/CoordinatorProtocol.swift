//
//  CoordinatorProtocol.swift
//  ybs-techtask
//
//  Created by Nov Petrović on 16/04/2023.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    
    func start()
    func navigateToListVC(tag: String)
    func navigateToDetailVC(photoId: String)
}
