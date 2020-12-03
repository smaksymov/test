//
//  DatabaseDataManageTest.swift
//  testProjectTests
//
//  Created by Stepan Maksymov on 03.12.2020.
//  Copyright © 2020 FindByte. All rights reserved.
//

import XCTest
@testable import testProject

class URLsDataTest: XCTestCase {

	func testPostsRequestData() throws {
		guard let url = URL(string: ApiUrls.postsUrl) else {
			XCTFail("invalid posts url \(ApiUrls.postsUrl)")
			return
		}
		let promise = expectation(description: "Posts request")
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			if let error = error {
				XCTFail("Error on posts request \(ApiUrls.postsUrl), \(error.localizedDescription)")
			} else if let responseData = data {
				do {
					let models = try JSONDecoder().decode([PostWebModel].self, from: responseData)
					XCTAssertTrue(models.count > 0, "Server returns empty Models list")
					if models.count > 0 {
						for model in models {
							XCTAssertTrue(model.body.count > 0, "Post body exists")
							XCTAssertTrue(model.id != 0, "Post Id ik ok")
							XCTAssertTrue(model.title.count > 0, "Post title exists")
							XCTAssertTrue(model.userId != 0, "userId is ok")
						}
					}
					promise.fulfill()
				} catch let error {
					XCTFail("Error on parsing Post models on posts request \(ApiUrls.postsUrl), \(error.localizedDescription)")
				}
			} else {
				XCTFail("No data returned from server on posts request \(ApiUrls.postsUrl)")
			}
		}
		task.resume()
		waitForExpectations(timeout: 5, handler: nil)
	}

	func testUsersRequestData() throws {
		guard let url = URL(string: ApiUrls.usersUrl) else {
			XCTFail("invalid users url \(ApiUrls.usersUrl)")
			return
		}
		let promise = expectation(description: "Users request")
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			if let error = error {
				XCTFail("Error on Users request \(ApiUrls.usersUrl), \(error.localizedDescription)")
			} else if let responseData = data {
				do {
					let models = try JSONDecoder().decode([UserWebModel].self, from: responseData)
					XCTAssertTrue(models.count > 0, "Server returns empty Models list")
					if models.count > 0 {
						for model in models {
							XCTAssertTrue(model.email.count > 0, "User email exists")
							XCTAssertTrue(model.id != 0, "User Id is ok")
							XCTAssertTrue(model.name.count > 0, "User name exists")
							_ = try XCTUnwrap(model.address, "Address is parsed")
							_ = try XCTUnwrap(model.company, "Company is parsed")
						}
					}
					promise.fulfill()
				} catch let error {
					XCTFail("Error on parsing Users models on posts request \(ApiUrls.usersUrl), \(error.localizedDescription)")
				}
			} else {
				XCTFail("No data returned from server on user request \(ApiUrls.usersUrl)")
			}
		}
		task.resume()
		waitForExpectations(timeout: 5, handler: nil)
	}

	func testCommentsRequestData() throws {
		guard let url = URL(string: ApiUrls.commentsUrl) else {
			XCTFail("invalid comments url \(ApiUrls.commentsUrl)")
			return
		}
		let promise = expectation(description: "Comments request")
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			if let error = error {
				XCTFail("Error on Comment request \(ApiUrls.usersUrl), \(error.localizedDescription)")
			} else if let responseData = data {
				do {
					let models = try JSONDecoder().decode([CommentWebModel].self, from: responseData)
					XCTAssertTrue(models.count > 0, "Server returns empty Models list")
					if models.count > 0 {
						for model in models {
							XCTAssertTrue(model.body.count > 0, "Comment body exists")
							XCTAssertTrue(model.email.count > 0, "User email exists")
							XCTAssertTrue(model.id != 0, "Comment Id is ok")
							XCTAssertTrue(model.name.count > 0, "User name exists")
						}
					}
					promise.fulfill()
				} catch let error {
					XCTFail("Error on parsing Comment models on comment request \(ApiUrls.commentsUrl), \(error.localizedDescription)")
				}
			} else {
				XCTFail("No data returned from server on comment request \(ApiUrls.commentsUrl)")
			}
		}
		task.resume()
		waitForExpectations(timeout: 5, handler: nil)
	}

}
