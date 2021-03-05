//
//  GalleryViewModelTests.swift
//  VividPhotographyTests
//
//  Created by Sachin Sabat on 05/03/21.
//

import XCTest
@testable import VividPhotography

final class GalleryViewModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModelUrlEmptyList() {
        let viewModel = GalleryViewModel(urlList: [])
        XCTAssertTrue(viewModel.isEmpty)
    }
    
    func testViewModelUrlListNotEmpty() {
        var urls: [Photo] = []
        let gallery = getGalleryPhotos()
        
        for _ in 0...3 {
            let url = gallery.hits![0]
            urls.append(url)
        }
        let viewModel = GalleryViewModel(urlList: urls)
        XCTAssertFalse(viewModel.photosUrlList.isEmpty)
        XCTAssertTrue(viewModel.totalCount == 4)
    }
    
    func testAddMorePhoto() {
        var urls: [Photo] = []
        let gallery = getGalleryPhotos()
        
        for _ in 0...3 {
            let url = gallery.hits![0]
            urls.append(url)
        }
        var viewModel = GalleryViewModel(urlList: urls)
        viewModel.appendPhotodUrlList(with: urls)
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertTrue(viewModel.totalCount == 8)
    }
    
    func getGalleryPhotos() -> Gallery {
       let bundle = Bundle(for: type(of: self))
       let fileUrl = bundle.url(forResource: "TestData", withExtension: "json")!
       let data = try! Data(contentsOf: fileUrl)
       let galleryPhotos = try! JSONDecoder().decode(Gallery.self, from: data)
       return galleryPhotos
   }
    
}
