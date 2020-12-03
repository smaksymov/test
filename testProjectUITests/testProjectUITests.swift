//
//  testProjectUITests.swift
//  testProjectUITests
//
//  Created by Stepan Maksymov on 03.12.2020.
//  Copyright © 2020 FindByte. All rights reserved.
//

import XCTest

class testProjectUITests: XCTestCase {

    func testPostListItemTap() throws {
        let app = XCUIApplication()
        app.launch()
		let postsTable = app.tables["table-posts"]
		XCTAssertTrue(postsTable.exists, "The posts tableview exists")
		if postsTable.cells.count > 0 {
			let tableCell = postsTable.cells.element(boundBy: 0)
			tableCell.tap()
			let postsDetailTable = app.tables["table-postsDetail"]
			XCTAssertTrue(postsDetailTable.exists, "The postsDetail tableview exists")
			XCTAssertTrue(postsDetailTable.cells.count > 0, "Posts detail cells exist")
			app.navigationBars.buttons.element(boundBy: 0).tap()
			XCTAssertTrue(true, "Post tap flow validated")
		 
		} else {
			XCTAssert(false, "No posts cells")
		}
		
		
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
