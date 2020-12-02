//
//  PostsWebRepository.swift
//  testProject
//
//  Created by Stepan Maksymov on 02.12.2020.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation

import RxSwift

class PostsWebRepository: WebRepository{

	func getItems() -> Observable<[PostWebModel]>? {
		return ApiHelper.shared.getPosts()
	}
	
}
