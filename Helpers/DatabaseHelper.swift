//
//  DatabaseHelper.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation

class DatabaseHelper {
	static var shared = DatabaseHelper()
	var backQueue = DispatchQueue(label: "dataProcess", qos: .background)
	
	func updatePosts(posts: [PostWebModel]){
		backQueue.async {
			let moc = CoreDataHelper.shared.managedObjectContext
			guard let localPosts = PostCoreModel.getAll(moc: moc) else { return }
			let localIds = localPosts.compactMap{$0.id}
			for post in posts {
				if !localIds.contains(post.id) {
					_ = PostCoreModel.create(from: post, moc: moc)
				}
			}
			if !moc.hasChanges { return }
			do{
				try moc.save()
			}catch {
				print ("MOC save error")
			}
			moc.reset()
		}
	}

	func updateUsers(users: [UserWebModel]){
		backQueue.async {
			let moc = CoreDataHelper.shared.managedObjectContext
			guard let localUsers = UserCoreModel.getAll(moc: moc) else { return }
			let localIds = localUsers.compactMap{$0.id}
			for user in users {
				if !localIds.contains(user.id) {
					_ = UserCoreModel.create(from: user, moc: moc)
				}
			}
			if !moc.hasChanges { return }
			do{
				try moc.save()
			}catch {
				print ("MOC save error")
			}
			moc.reset()
		}
	}

	func updateComments(comments: [CommentWebModel]){
		backQueue.async {
			let moc = CoreDataHelper.shared.managedObjectContext
			guard let localComments = CommentCoreModel.getAll(moc: moc) else { return }
			let localIds = localComments.compactMap{$0.id}
			for comment in comments {
				if !localIds.contains(comment.id) {
					_ = CommentCoreModel.create(from: comment, moc: moc)
				}
			}
			if !moc.hasChanges { return }
			do{
				try moc.save()
			}catch {
				print ("MOC save error")
			}
			moc.reset()
		}
	}
	
}
