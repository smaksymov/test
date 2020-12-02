//
//  CommentsWebRepository.swift
//  testProject
//
//  Created by Stepan Maksymov on 02.12.2020.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import RxSwift

class CommentsWebRepository: WebRepository{

	static var shared = CommentsWebRepository()
	
	func getItems() -> Observable<[CommentWebModel]>? {
		return ApiHelper.shared.getComments()
	}
	
}
