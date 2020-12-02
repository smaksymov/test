//
//  PostViewModel.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class PostViewModel {

	private let disposeBag = DisposeBag()
	private let postDataManager = PostDataManager()
	lazy var dataSource = postDataManager.postsSource.asObservable()
	
	func getData() {
		postDataManager.getData()
	}
}

