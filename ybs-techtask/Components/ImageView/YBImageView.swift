//
//  YBImageView.swift
//  ybs-techtask
//
//  Created by Nov Petrović on 24/05/2023.
//

import UIKit

class YBImageView: UIImageView {
    
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(fromURL url: String) async {
        Task { image = await networkService.downloadImage(from: url) }
    }
}
