//
//  PhotoDetail.swift
//  ybs-techtask
//
//  Created by Nov Petrović on 24/05/2023.
//

import Foundation

struct PhotoDetailResponse: Codable {
    let photo: PhotoDetail
}

struct PhotoDetail: Codable {
    let id: String
    let farm: Int
    let secret: String
    let server: String
    let owner: Owner
}

struct Owner: Codable {
    let username: String
    let realname: String
}
