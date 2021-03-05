//
//  GalleryTests.swift
//  VividPhotographyTests
//
//  Created by Sachin Sabat on 05/03/21.
//

import XCTest
@testable import VividPhotography

final class GalleryTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGalleryEntity() {
        let galleryPhotos = getGalleryPhotos()
        XCTAssertNotNil(galleryPhotos)
        guard let hitsData = galleryPhotos.hits else {
            return
        }
        XCTAssertFalse(hitsData.isEmpty)
      //  XCTAssertTrue(hitsData.isEmpty)

        let photo = galleryPhotos.hits?[0]
        XCTAssertTrue(photo?.previewURL == "https://cdn.pixabay.com/photo/2018/02/05/12/43/deity-3132133_150.jpg")
        XCTAssertTrue(photo?.largeImageURL == "https://pixabay.com/get/ga103d3901f6514786d2e2258ec938b00fa95fecc049fca35a5f31b79dc1558496fc49bc1e014ec0fe9470a62ce94baa55912f3d9a0491428bf74da7465bd6d51_1280.jpg")
        XCTAssertEqual(photo?.imageWidth, 3453)
        XCTAssertTrue(photo?.imageHeight == 2151)
    }
    
    func getGalleryPhotos() -> Gallery {
       let bundle = Bundle(for: type(of: self))
       let fileUrl = bundle.url(forResource: "TestData", withExtension: "json")!
       let data = try! Data(contentsOf: fileUrl)
       let galleryPhotos = try! JSONDecoder().decode(Gallery.self, from: data)
       return galleryPhotos
   }
}
