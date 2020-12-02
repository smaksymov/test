//
//  PostsCoreRepository.swift
//  testProject
//
//  Created by Stepan Maksymov on 02.12.2020.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation

class PostsCoreRepository: RepositoryCached{

	var cachedItems: [PostDisplayable] = []
	
	func getItems() -> [PostDisplayable]? {
		if cachedItems.count > 0 {
			return cachedItems
		}
		guard let users = PostCoreModel.getAll(moc: CoreDataHelper.shared.managedObjectContext) else { return []}
		self.cachedItems = users
		return self.cachedItems
	}
	
	func getItemById(id: Int32) -> PostDisplayable? {
		return self.cachedItems.filter{$0.id == id}.first
	}
	
}
