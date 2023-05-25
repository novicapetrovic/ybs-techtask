//
//  PhotoModel.swift
//  ybs-techtask
//
//  Created by Nov Petrović on 23/05/2023.
//

import Foundation

struct PhotoSearchResponse: Codable {
    let photos: Photos
}

struct Photos: Codable {
    let photo: [PhotoModel]
}

struct PhotoModel: Codable, Hashable {
    let id: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
}
