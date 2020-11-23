//
//  ApiHelper.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation

class ApiHelper {
	static let shared: ApiHelper = ApiHelper()
	
	enum RequestError: Error {
		case invalidUrl
		case invalidResponseData(Data?)
	}
	
	func getRequest(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
		guard let url = URL(string: urlString) else {
			completion(.failure(RequestError.invalidUrl))
			return
		}
		
		let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				completion(.failure(error))
			}
			guard
				let responseData = data,
				let response = response as? HTTPURLResponse,
				response.statusCode == 200 else {
					completion(.failure(RequestError.invalidResponseData(data)))
					return
			}
			completion(.success(responseData))
		}
		dataTask.resume()
	}
}
