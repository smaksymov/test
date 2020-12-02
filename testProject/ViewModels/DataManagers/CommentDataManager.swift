//
//  CommentDataManager.swift
//  testProject
//
//  Created by Stepan Maksymov on 02.12.2020.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CommentDataManager {
	
	let commentsSource: BehaviorRelay<[CommentDisplayable]> = BehaviorRelay(value: [])
	
	private let disposedBag = DisposeBag()
	private var commentsWeb = CommentsWebRepository()
	private var commentsCore = CommentsCoreRepository()
	private var post: PostDisplayable

	init(post: PostDisplayable) {
		self.post = post
	}
	
	func getData() {
		if commentsCore.cachedItems.count == 0 && commentsCore.getItems()?.count == 0 {
			self.commentsWeb.getItems()?.subscribe(onNext: { [weak self] comments in
				guard let self = self else { return }
				DatabaseHelper.shared.updateComments(comments: comments)
				self.commentsSource.accept(comments.filter({$0.postId == self.post.id}))
			}).disposed(by: self.disposedBag)
			return
		}
		commentsSource.accept(commentsCore.cachedItems.filter({$0.postId == self.post.id}))
	}

	
	
	
}
