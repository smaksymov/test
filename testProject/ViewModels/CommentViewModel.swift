//
//  CommentViewModel.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class CommentViewModel {

	var commentDisplayableInternal: BehaviorRelay<[AnyObject]> = BehaviorRelay(value: [])

	private let disposeBag = DisposeBag()
	private let commentDataManager: CommentDataManager
	private var post: PostDisplayable
	var dataSource: Observable<[AnyObject]>

	init (post: PostDisplayable) {
		self.post = post
		self.commentDataManager = CommentDataManager(post: post)
		dataSource = commentDisplayableInternal.asObservable()
		setupInternalBinding()
	}

	private func setupInternalBinding() {
		commentDataManager.commentsSource.subscribe(onNext: { [weak self] comments in
			guard let self = self else { return }
			self.commentDisplayableInternal.accept([self.post] + comments)
		   }).disposed(by: self.disposeBag)
	}

	func getData() {
		commentDataManager.getData()
	}
	
}
