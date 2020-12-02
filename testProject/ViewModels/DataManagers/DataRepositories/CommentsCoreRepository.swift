//
//  CommentsCoreRepository.swift
//  testProject
//
//  Created by Stepan Maksymov on 02.12.2020.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation

class CommentsCoreRepository: RepositoryCached{

	var cachedItems: [CommentDisplayable] = []
	
	func getItems() -> [CommentDisplayable]? {
		if cachedItems.count > 0 {
			return cachedItems
		}
		guard let users = CommentCoreModel.getAll(moc: CoreDataHelper.shared.managedObjectContext) else { return []}
		self.cachedItems = users
		return self.cachedItems
	}
	
	func getItemById(id: Int32) -> CommentDisplayable? {
		return self.cachedItems.filter{$0.id == id}.first
	}
	func getItemsById(subId: Int32) -> [CommentDisplayable]? {
		return self.cachedItems.filter{$0.postId == subId}
	}

}
