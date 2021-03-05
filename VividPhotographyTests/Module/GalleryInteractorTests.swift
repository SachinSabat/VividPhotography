//
//  GalleryIneractorTests.swift
//  VividPhotographyTests
//
//  Created by Sachin Sabat on 05/03/21.
//

import XCTest
@testable import VividPhotography

final class GalleryInteractorTests: XCTestCase {
    
    var interactor: GalleryIneractorMock!
    var presenter: GalleryPresenterInputMock!
    
    override func setUp() {
        presenter = GalleryPresenterInputMock()
        let network = NetworkClientMock()
        interactor = GalleryIneractorMock(presenter: presenter, network: network)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        interactor = nil
        presenter = nil
    }
    
    func testLoadFlickrPhotos() {
        interactor.loadPhotos(matching: "Shiva", pageNum: 1)
        XCTAssertTrue(presenter.gallerySuccessCalled)
        XCTAssertTrue(interactor.loadPhotosCalled)
    }
    
    func testLoadFlickrPhotosErrorResponse() {
        interactor.loadPhotos(matching: "Shiva", pageNum: -1)
        XCTAssertFalse(presenter.gallerySuccessCalled)
        XCTAssertTrue(interactor.loadPhotosCalled)
    }
}


final class GalleryIneractorMock: GalleryInteractorInput {

    weak var presenter: GalleryInteractorOutput?
    var loadPhotosCalled: Bool = false
    var network: NetworkService?
    
    init(presenter: GalleryInteractorOutput, network: NetworkService) {
        self.presenter = presenter
        self.network = network
    }
    
    func loadPhotos(matching imageName: String, pageNum: Int) {
        
        network?.dataRequest(GalleryAPI.search(query: imageName, page: pageNum), objectType: Gallery.self) { (result) in
            switch result {
            case let .success(galleryPhotos):
                self.loadPhotosCalled = true
                self.presenter?.gallerySearchSuccess(galleryPhotos)
            case let .failure(error):
                self.presenter?.gallerySearchError(error)
                self.loadPhotosCalled = true
            }
        }
    }
}

final class GalleryPresenterInputMock: GalleryInteractorOutput {
    
    
    var gallerySuccessCalled = false
    
    func gallerySearchSuccess(_ galleryPhotos: Gallery) {
        gallerySuccessCalled = true
        
        guard let gallery = galleryPhotos.hits else {
            return
        }
        XCTAssertFalse(gallery.isEmpty)
    }
    
    func gallerySearchError(_ error: NetworkError) {
        gallerySuccessCalled = false

    }
    
}
