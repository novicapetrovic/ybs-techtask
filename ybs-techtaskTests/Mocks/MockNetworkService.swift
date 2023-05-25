//
//  MockNetworkService.swift
//  ybs-techtaskTests
//
//  Created by Nov Petrović on 24/05/2023.
//

import UIKit
@testable import ybs_techtask

class MockNetworkService: NetworkServiceProtocol {
    
    var result: Result<Data, APIError>?
    
    func fetchPhotos(for tag: String, _ completion: @escaping (Result<[PhotoModel], APIError>) -> Void) {
        guard let result = result else {
            fatalError("Result is nil")
        }
        do {
            let decodedData = try result.get()
            let decodedObject = try JSONDecoder().decode([PhotoModel].self, from: decodedData)
            completion(.success(decodedObject))
        } catch {
            completion(.failure(.decodingProblem))
        }
    }
    
    func downloadImage(from urlString: String) async -> UIImage? {
        return nil
    }
}
