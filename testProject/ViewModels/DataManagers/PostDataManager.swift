//
//  PostDataManager.swift
//  testProject
//
//  Created by Stepan Maksymov on 02.12.2020.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PostDataManager {
	
	let postsSource: BehaviorRelay<[PostDisplayable]> = BehaviorRelay(value: [])
	
	private let disposedBag = DisposeBag()
	private var postWeb = PostsWebRepository()
	private var postCore = PostsCoreRepository()
	private var usersWeb = UsersWebRepository.shared
	private var usersCore = UsersCoreRepository.shared
	
	func getData() {
		if usersCore.cachedItems.count == 0 && usersCore.getItems()?.count == 0 {
			usersWeb.getItems()?.subscribe(onNext: { [weak self] users in
				guard let self = self else { return }
				DatabaseHelper.shared.updateUsers(users: users)
				_ = self.usersCore.getItems()
				self.getPosts()
			}).disposed(by: self.disposedBag)
			return
		}
		
		if postCore.cachedItems.count == 0 && postCore.getItems()?.count == 0 {
			getPosts()
			return
		}
		postsSource.accept(postCore.cachedItems)
	}

	private func getPosts() {
		self.postWeb.getItems()?.subscribe(onNext: { [weak self] posts in
			guard let self = self else { return }
			posts.forEach({$0.userModel = self.usersCore.getItemById(id: $0.userId)})
			DatabaseHelper.shared.updatePosts(posts: posts)
			self.postsSource.accept(posts)
		}).disposed(by: self.disposedBag)

	}
	
	
	
}
