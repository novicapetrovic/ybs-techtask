//
//  NetworkServiceTests.swift
//  ybs-techtaskTests
//
//  Created by Nov Petrović on 24/05/2023.
//

import XCTest
@testable import ybs_techtask

class NetworkServiceTests: XCTestCase {
    
    // MARK: - Properties
    var sut: NetworkServiceProtocol?
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
        sut = MockNetworkService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - Unit tests
extension NetworkServiceTests {
    
    func testFetchPhotosSuccessfully() {
        let mockPhotosList = mockPhotosList()
        let resultData = photosListData()
        
        sut?.result = .success(resultData)
        
        sut?.fetchPhotos(for: "cats", { result in
            switch result {
            case .success(let photosList):
                XCTAssertEqual(photosList.count, 1)
                XCTAssertEqual(photosList.first, mockPhotosList.first)
            case .failure(let error):
                print("Test Failed: \(error)")
                XCTAssertTrue(false)
            }
        })
    }
}

// MARK: - Helper functions
extension NetworkServiceTests {
    private func mockPhotosList() -> [PhotoModel] {
        return [
            .init(id: "1", secret: "1", server: "1", farm: 0, title: "1")
        ]
    }
    
    private func photosListData() -> Data {
        let photosList = mockPhotosList()
        let photosListData = try? JSONEncoder().encode(photosList)
        return photosListData ?? Data()
    }
}
