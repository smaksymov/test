//
//  UsersWebRepository.swift
//  testProject
//
//  Created by Stepan Maksymov on 02.12.2020.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import RxSwift

class UsersWebRepository: WebRepository{

	static var shared = UsersWebRepository()
	
	func getItems() -> Observable<[UserWebModel]>? {
		return ApiHelper.shared.getUsers()
	}
	
}
