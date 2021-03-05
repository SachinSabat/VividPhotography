//
//  TestUtil.swift
//  VividPhotographyTests
//
//  Created by Sachin Sabat on 05/03/21.
//

import XCTest
@testable import VividPhotography

class TestUtil {
     func getGalleryPhotos() -> Gallery {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: "TestData", withExtension: "json")!
        let data = try! Data(contentsOf: fileUrl)
        let galleryPhotos = try! JSONDecoder().decode(Gallery.self, from: data)
        return galleryPhotos
    }
}
