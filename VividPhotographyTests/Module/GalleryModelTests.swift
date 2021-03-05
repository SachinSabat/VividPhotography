//
//  GalleryModelTests.swift
//  VividPhotographyTests
//
//  Created by Sachin Sabat on 05/03/21.
//

import XCTest
@testable import VividPhotography

final class GalleryModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //MARK: Test sample response mapping to GalleryPhotos
    func testGalleryPhotosJSONDecoder() {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: "TestData", withExtension: "json")!
        let data = try! Data(contentsOf: fileUrl)
        let galleryPhotos = try! JSONDecoder().decode(Gallery.self, from: data)
        
        guard let galleryHitData = galleryPhotos.hits else {
            return
        }
        
        XCTAssertFalse(galleryHitData.isEmpty)
        XCTAssertTrue(galleryPhotos.hits?.count == 2)
   //     XCTAssertTrue(galleryPhotos.hits?.count == 1)
        XCTAssertFalse(galleryPhotos.total == 1364)
        XCTAssertTrue(galleryPhotos.total == 136)
    }
}
