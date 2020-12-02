//
//  ApiHelper.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import RxSwift

private enum RequestType: String {
	case GET, POST
}

enum ApiError: Error {
	case invalidUrl
}

class ApiHelper {
	static let shared: ApiHelper = ApiHelper()

	func getUsers() -> Observable<[UserWebModel]>? {
		return self.request(urlString: ApiUrls.usersUrl, requestType: RequestType.GET.rawValue)
	}
	func getPosts() -> Observable<[PostWebModel]>? {
		return self.request(urlString: ApiUrls.postsUrl, requestType: RequestType.GET.rawValue)
	}
	func getComments() -> Observable<[CommentWebModel]>? {
		return self.request(urlString: ApiUrls.commentsUrl, requestType: RequestType.GET.rawValue)
	}

	private func request<T: Codable>(urlString: String, requestType: String) -> Observable<T>? {
		guard let url = URL(string: urlString) else {
			return nil
		}
		var request = URLRequest(url: url)
		request.httpMethod = requestType
		return Observable<T>.create { observer in
			let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
				if let error = error {
					observer.onError(error)
				} else if let responseData = data {
					do {
						let model: T = try JSONDecoder().decode(T.self, from: responseData)
						observer.onNext(model)
					} catch let error {
						observer.onError(error)
					}
				}
				observer.onCompleted()
			}
			task.resume()
			return Disposables.create {
				task.cancel()
			}
		}
	}

	
}
