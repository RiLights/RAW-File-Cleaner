//
//  RAW_File_CleanerUITests.swift
//  RAW File CleanerUITests
//
//  Created by Yaryna Pochtarenko on 4/10/19.
//  Copyright © 2019 Ostap Pochtarenko. All rights reserved.
//

import XCTest

class RAW_File_CleanerUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEmtyDirectory() {
        let app = XCUIApplication()
        app.launch()
        app.buttons.element(boundBy: 1).click()
        XCTAssert(app.staticTexts["Warning"].isHittable)
    }
}
