//
//  NetworkingTests.swift
//  VividPhotographyTests
//
//  Created by Sachin Sabat on 05/03/21.
//

import XCTest
@testable import VividPhotography

final class NetworkingTests: XCTestCase {

    var network: NetworkService!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        network = NetworkClientMock()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        network = nil
    }

    func testNetworkDataRequestSuccess() {
        _ = network.dataRequest(GalleryAPI.search(query: "Shiva", page: 1), objectType: Gallery.self, completion: { (result) in
            switch result {
            case let .success(photos):
                XCTAssertTrue(photos.hits?.count == 2)
                XCTAssertFalse(photos.hits?.count == 0)
                XCTAssertFalse(photos.total == 0)
            case .failure:
                break
            }
        })
    }
    
    func testNetworkDataRequestInvalidStatusFailure() {
        _ = network.dataRequest(GalleryAPI.search(query: "abc", page: -1), objectType: Gallery.self, completion: { (result) in
            switch result {
            case .success:
                XCTFail("Should fail with error")
            case let .failure(error):
                XCTAssertTrue(error.description == "Server is down with status code: 401")
            }
        })
    }
    
    func testNetworkDataRequestEmptyDataFailure() {
        _ = network.dataRequest(GalleryAPI.search(query: "dfdfdf123", page: 1), objectType: Gallery.self, completion: { (result) in
            switch result {
            case .success:
                XCTFail("Should fail with error")
            case let .failure(error):
                XCTAssertTrue(error.description == "Empty response from the server")
            }
        })
    }

    func testImageDownloadSuccess() {
        let imageUrl = URL(string: "https://cdn.pixabay.com/photo/2018/02/05/12/43/deity-3132133_150.jpg")!
        _ = network.downloadRequest(imageUrl, size: .zero, scale: 1, completion: { (result) in
            switch result {
            case let .success(image):
                XCTAssertFalse(image == UIImage(color: .black))
            case .failure:
                XCTFail("Should go to success")
            }
        })
    }
    
    func testImageDownloadFailure() {
        let imageUrl = URL(string: "https://cdn.pixabay.com/photo/2018/02/05/12/43/deity-3132133_1.jpg")!
        _ = network.downloadRequest(imageUrl, size: .zero, scale: 1, completion: { (result: Result<UIImage, NetworkError>) in
            switch result {
            case let .failure(networkError):
                 XCTAssertTrue(networkError.description == "Something went wrong.")
            case .success:
                XCTFail("Should go to failure")
            }
        })
    }
}

