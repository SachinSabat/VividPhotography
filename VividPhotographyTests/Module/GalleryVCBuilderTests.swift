//
//  GalleryVCBuilderTests.swift
//  VividPhotographyTests
//
//  Created by Sachin Sabat on 05/03/21.
//

import XCTest
import UIKit
import Foundation
@testable import VividPhotography

final class GalleryVCBuilderTests: XCTestCase {

    var viewController: GalleryVC!
    var presenter: GalleryPresenter!
    var interactor: GalleryIneractor!
    var router: GalleryRouter!
    
    override func setUp() {
        super.setUp()
        let moduleBuilder = GalleryModuleBuilder()
        viewController = moduleBuilder.buildModule()
        presenter = viewController.presenter as? GalleryPresenter
        interactor = presenter.interactor as? GalleryIneractor
        router = presenter.router as? GalleryRouter
    }

    override func tearDown() {
        viewController = nil
        presenter = nil
        interactor = nil
        router = nil
    }

    func testGalleryBuilder() {
        XCTAssertTrue(viewController != nil)
        XCTAssertTrue(presenter != nil)
        XCTAssertTrue(interactor != nil)
        XCTAssertTrue(router != nil)
    }
    
    func testGalleryVC() {
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController.presenter)
        XCTAssertTrue(viewController.presenter is GalleryPresenter)
    }

    func testGalleryModulePresenter() {
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(presenter.view)
        XCTAssertNotNil(presenter.interactor)
        XCTAssertTrue(presenter.view is GalleryVC)
        XCTAssertTrue(presenter.interactor is GalleryIneractor)
        XCTAssertTrue(presenter.router is GalleryRouter)
    }
    
    func testGalleryModuleInteractor() {
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(interactor.presenter)
        XCTAssertTrue(interactor.presenter is GalleryPresenter)
    }
}
