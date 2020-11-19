//
//  PostViewModel.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import UIKit

class PostViewModel {

	var usersDisplayable = [UserDisplayable]()
	weak var dataSource : BaseDataSource<PostDisplayable>?

	
	init(dataSource : BaseDataSource<PostDisplayable>?) {
		self.dataSource = dataSource
	}
	
}

extension PostViewModel {
	
	// Get posts from web to make them live, if failed attempt to get them from local database,
	// If both failed then display that we need connection to load at least one time.

	func getData() {
		getUsersWeb(completion: { result in
			switch(result){
			case .failure:
				if let users = self.getUsersCore(), users.count > 0 {
					self.usersDisplayable = users
					self.getPosts()
				} else {
					print("Error getting users")
				}
			case .success(let users):
				self.usersDisplayable = users
				self.getPosts()
			}
		})
	}

	private func getPosts() {
		getPostsWeb(completion: { result in
			switch(result){
			case .failure:
				if let posts = self.getPostsCore(), posts.count > 0 {
					posts.forEach({$0.userModel = self.getUserById(userId: $0.userId)})
					DispatchQueue.main.async {
						self.dataSource?.data.value = posts
					}
					return
				} else {
					print("error getting posts")
				}
			case .success(let postsData):
				DispatchQueue.main.async {
					self.dataSource?.data.value = postsData
				}
			}
		})
	}
	
	private func getPostsCore() -> [PostCoreModel]? {
		let posts = PostCoreModel.getAll(moc: CoreDataHelper.shared.managedObjectContext)
		return posts
	}
	
	private func getPostsWeb(completion: @escaping (Result<[PostWebModel], Error>) -> Void) {
		ApiHelper.shared.getRequest(urlString: ApiUrls.postsUrl, completion: { result in
			switch result {
			case .failure(let error):
				completion(.failure(error))
			case .success(let data):
				let decoder = JSONDecoder()
				do {
					let tempPosts = try decoder.decode([PostWebModel].self, from: data)
					DatabaseHelper.shared.updatePosts(posts: tempPosts)
					completion(.success(tempPosts))
				} catch {
					completion(.failure(error))
				}
			}
		})
	}
	
	private func getUserById(userId: Int32) -> UserDisplayable?{
		return usersDisplayable.filter{$0.id == userId}.first
	}
	
	
	private func getUsersCore() -> [UserCoreModel]? {
		let users = UserCoreModel.getAll(moc: CoreDataHelper.shared.managedObjectContext)
		return users
	}
	
	private func getUsersWeb(completion: @escaping (Result<[UserWebModel], Error>) -> Void) {
		ApiHelper.shared.getRequest(urlString: ApiUrls.usersUrl, completion: { result in
			switch result {
			case .failure(let error):
				completion(.failure(error))
			case .success(let data):
				let decoder = JSONDecoder()
				do {
					let tempUsers = try decoder.decode([UserWebModel].self, from: data)
					DatabaseHelper.shared.updateUsers(users: tempUsers)
					completion(.success(tempUsers))
				} catch {
					completion(.failure(error))
				}
			}
		})
	}
	
	
}
