//
//  File.swift
//  ybs-techtask
//
//  Created by Nov Petrović on 24/05/2023.
//

import UIKit

protocol NetworkServiceProtocol {
    var result: Result<Data, APIError>? { get set }
    func fetchPhotos(for tag: String, _ completion: @escaping(Result<[PhotoModel], APIError>) -> Void)
    func fetchPhotoDetail(photoId: String, _ completion: @escaping(Result<PhotoDetail, APIError>) -> Void)
    func downloadImage(from urlString: String) async -> UIImage?
}

final class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Properties
    var result: Result<Data, APIError>?
    private let decoder = JSONDecoder()
    private let baseURL = "https://api.flickr.com/services/rest/"
    static let apiKey = "30803986605ccedc9be8c5c14f7d2f2b"
    let cache = NSCache<NSString, UIImage>()
    
    func fetchPhotos(for tag: String, _ completion: @escaping(Result<[PhotoModel], APIError>) -> Void) {
        let endpoint = baseURL + "?method=flickr.photos.search&api_key=30803986605ccedc9be8c5c14f7d2f2b&text=\(tag)&format=json"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        do {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response , _ in
                guard let self = self else { return }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200..<300).contains(httpResponse.statusCode),
                      let data = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                
                if let extractedData = self.extractJSONData(from: data) {
                    do {
                        let wrappedResponse = try decoder.decode(PhotoSearchResponse.self, from: extractedData)
                        completion(.success(wrappedResponse.photos.photo))
                    } catch {
                        completion(.failure(.decodingProblem))
                    }
                } else {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        }
    }
    
    func fetchPhotoDetail(photoId: String, _ completion: @escaping(Result<PhotoDetail, APIError>) -> Void) {
        let endpoint = baseURL + "?method=flickr.photos.getInfo&api_key=30803986605ccedc9be8c5c14f7d2f2b&photo_id=\(photoId)&format=json"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        do {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response , _ in
                guard let self = self else { return }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200..<300).contains(httpResponse.statusCode),
                      let data = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                
                if let extractedData = self.extractJSONData(from: data) {
                    print(String(data: extractedData, encoding: .utf8))
                    do {
                        let wrappedResponse = try decoder.decode(PhotoDetailResponse.self, from: extractedData)
                        completion(.success(wrappedResponse.photo))
                    } catch {
                        completion(.failure(.decodingProblem))
                    }
                } else {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        }
    }
    
    
    private func extractJSONData(from data: Data) -> Data? {
        guard let jsonString = String(data: data, encoding: .utf8) else {
            return nil
        }

        let prefix = "jsonFlickrApi("
        let suffix = ")"
        guard jsonString.hasPrefix(prefix), jsonString.hasSuffix(suffix) else {
            return nil
        }

        let startIndex = jsonString.index(jsonString.startIndex, offsetBy: prefix.count)
        let endIndex = jsonString.index(jsonString.endIndex, offsetBy: -suffix.count)
        let jsonSubstring = jsonString[startIndex..<endIndex]

        if let jsonData = jsonSubstring.data(using: .utf8) {
            return jsonData
        } else {
            return nil
        }
    }
    
    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) { return image }
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}

