//
//  PollfishAppSupportUITests.swift
//  PollfishAppSupportUITests
//
//  Created by guillermo on 1/26/20.
//  Copyright © 2020 pollfish. All rights reserved.
//

import XCTest

class PollfishAppSupportUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func testLaunchPerformance() {
        if #available(iOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
//
    func testViewDismiss() {
        let app = XCUIApplication()

        // When
        let predicate = NSPredicate(format: "exists == 1")
        let query = app.staticTexts["X"]

        // Then
        expectation(for: predicate, evaluatedWith: query, handler: nil)
        waitForExpectations(timeout: 20, handler: nil)
    }
}
