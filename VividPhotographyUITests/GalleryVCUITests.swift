//
//  VividPhotographyUITests.swift
//  VividPhotographyUITests
//
//  Created by Sachin Sabat on 03/03/21.
//

import XCTest
@testable import VividPhotography

class GalleryVCUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        app.terminate()
    }

    func testElementExists() {
        XCTAssert(app.staticTexts["Vivid Photos"].exists)
        XCTAssert(app.searchFields["Search for photos..."].exists)
        XCTAssert(app.collectionViews.element.exists)
    }
    
    func testElementIsEnabled() {
        let vividPhotosNavigationBar = app.navigationBars["Vivid Photos"]
        let searchTextField = vividPhotosNavigationBar.searchFields["Search for photos..."]

        XCTAssertTrue(searchTextField.isEnabled, "Not enabled for user")
        XCTAssertTrue(app.collectionViews.element.isEnabled, "Not enabled for user")

    }
    
    func testTappingCollectionViewCell(){
        app.collectionViews.children(matching: .cell).element(boundBy: 1).tap()
        XCTAssert(app.navigationBars["Vivid Photos"].exists)
    }
    
    
    func testTappingSearchTextField(){
        
        let vividPhotosNavigationBar = app.navigationBars["Vivid Photos"]
        let searchTextField = vividPhotosNavigationBar.searchFields["Search for photos..."]
        
        searchTextField.tap()
        XCTAssert(app.navigationBars["Vivid Photos"].exists)

        vividPhotosNavigationBar.buttons["Cancel"].tap()
        XCTAssert(app.navigationBars["Vivid Photos"].exists)
  
        searchTextField.tap()
        app.buttons["Search"].tap()
        XCTAssert(app.navigationBars["Vivid Photos"].exists)

        searchTextField.typeText("Shiva")
        searchTextField.buttons["Clear text"].tap()
        XCTAssert(app.navigationBars["Vivid Photos"].exists)

    }
    
    
    func testGalleryVC_ShowingAnAlertWhileWrongTextSearched() {
        
        let vividPhotosNavigationBar = app.navigationBars["Vivid Photos"]
        let searchTextField = vividPhotosNavigationBar.searchFields["Search for photos..."]
        
        searchTextField.tap()
        searchTextField.typeText("Shiva123ShowMe")
        
        app.buttons["Search"].tap()
        let errorDialog = app.alerts["errorDialog"]
        waitForElementToAppear(errorDialog)
        XCTAssert(errorDialog.exists)

    }
    
    func testGalleryVC_DismissingAnAlertWhileWrongTextSearched() {
        
        let vividPhotosNavigationBar = app.navigationBars["Vivid Photos"]
        let searchTextField = vividPhotosNavigationBar.searchFields["Search for photos..."]
        
        searchTextField.tap()
        searchTextField.typeText("Shiva123ShowMe")
        
        app.buttons["Search"].tap()
        let errorDialog = app.alerts["errorDialog"]
        
        errorDialog.buttons["Retry"].tap()
        errorDialog.buttons["Cancel"].tap()
        
    }
    
    
    func testWaitForElementToAppear(){
        
        app.navigationBars["Vivid Photos"].searchFields["Search for photos..."].tap()
        app.tables["Search results"].staticTexts["Shiva"].tap()
        let nextGameLabel = app.staticTexts["Vivid Photos"]
        let existsPredicate = NSPredicate(format: "exists == 1")
        expectation(for: existsPredicate, evaluatedWith: nextGameLabel, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(nextGameLabel.exists)
        
    }
    
    func testPushingGalleryVC_to_PageVC() {
        
        app.collectionViews.children(matching: .cell).element(boundBy: 1).tap()
        app.collectionViews.children(matching: .cell).element(boundBy: 2).tap()
        app.collectionViews.children(matching: .cell).element(boundBy: 7).tap()
        app.collectionViews.children(matching: .cell).element(boundBy: 5).tap()

        XCTAssert(app.navigationBars["Vivid Photos"].exists)

    }
    
    func testPoppingPageVC_to_GalleryVC() {

        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).tap()
        XCTAssert(app.navigationBars["Vivid Photos"].exists)

        app.scrollViews.children(matching: .other).element.children(matching: .other).element.swipeDown()
        XCTAssert(app.navigationBars["Vivid Photos"].exists)

        collectionViewsQuery.children(matching: .cell).element(boundBy: 2).tap()
        app.buttons["delete"].tap()

        XCTAssert(app.navigationBars["Vivid Photos"].exists)
        
        
    }

    func waitForElementToAppear(_ element: XCUIElement, file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)

        waitForExpectations(timeout: 5) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after 5 seconds."
                self.recordFailure(withDescription: message, inFile: file, atLine: Int(line), expected: true)
            }
        }
    }

}


