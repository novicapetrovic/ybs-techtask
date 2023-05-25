//
//  YBCell.swift
//  ybs-techtask
//
//  Created by Nov Petrović on 24/05/2023.
//

import UIKit

class YBPhotoCell: UICollectionViewCell {
    
    // MARK: - Dependencies
    let networkService: NetworkServiceProtocol
    
    // MARK: - Properties
    static let reuseID = "YBPhotoCell"
    let imageView: YBImageView
    let titleLabel = YBTitleLabel(textAlignment: .center, fontSize: 16)
    
    // MARK: - Init
    override init(frame: CGRect) {
        self.networkService = NetworkService()
        self.imageView = YBImageView(networkService: networkService)
        super.init(frame: frame)
        configure()
    }
    
    init(networkService: NetworkServiceProtocol, frame: CGRect) {
        self.networkService = networkService
        self.imageView = YBImageView(networkService: networkService)
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Interface
    func set(photo: PhotoModel) async {
        await imageView.downloadImage(fromURL: "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg")
        titleLabel.text = photo.title
    }
    
    // MARK: - Private helpers
    private func configure() {
        addSubviews(imageView, titleLabel)
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
