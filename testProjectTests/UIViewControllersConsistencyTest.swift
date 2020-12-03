//
//  testProjectTests.swift
//  testProjectTests
//
//  Created by Stepan Maksymov on 03.12.2020.
//  Copyright © 2020 FindByte. All rights reserved.
//

import XCTest
@testable import testProject

class UIViewControllersConsistencyTest: XCTestCase {

	override func setUpWithError() throws {
	}

	override func tearDownWithError() throws {
	}

	func testControllersInstantiate() throws {
		AppStoryboard.allCases.forEach {
			print($0.rawValue + "\n")
			let storyboard = UIStoryboard(name: $0.rawValue, bundle: Bundle(for: Self.self))
			guard let controller = storyboard.instantiateInitialViewController() else {
				XCTFail("Cannot instantiate initial controller for storyboard \($0)")
				return
			}
			if nil == controller as? UINavigationController {
				if let identifier = controller.value(forKey: "storyboardIdentifier") as? String, identifier.count > 0 {
					if identifier != $0.rawValue {
						XCTFail("Wrong storyboardID for initial controller for storyboard \($0)")
						return
					}
				} else {
					XCTFail("Not set storyboardID for initial controller for storyboard \($0)")
					return
				}
			}
		}
	}

}
