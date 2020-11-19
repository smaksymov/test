//
//  PostModel.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import CoreData


protocol PostDisplayable: AnyObject {
	var id: Int32 { get }
	var userId: Int32 { get }
	var title: String { get }
	var body: String { get }
	var userModel: UserDisplayable? { get set }
}


class PostWebModel: Codable, PostDisplayable {
	var id: Int32
	var userId: Int32
	var title: String
	var body: String
	var userModel: UserDisplayable?
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "userId"
        case title = "title"
        case body = "body"
    }
}

class PostCoreModel: NSManagedObject, PostDisplayable {
	static let ENTITY = "Post"
    @NSManaged var id: Int32
    @NSManaged var userId: Int32
    @NSManaged var title: String
    @NSManaged var body: String
	var userModel: UserDisplayable?
	
	static func create(from post: PostWebModel, moc: NSManagedObjectContext) -> PostCoreModel {
		let postModel = NSEntityDescription.insertNewObject(forEntityName: PostCoreModel.ENTITY, into: moc) as! PostCoreModel
		postModel.id = post.id
		postModel.body = post.body
		postModel.title = post.title
		postModel.userId = post.userId
		return postModel
	}
	
	static func getAll(moc: NSManagedObjectContext) -> [PostCoreModel]? {
		let request = NSFetchRequest<PostCoreModel>(entityName: PostCoreModel.ENTITY)
		do {
			let posts = try moc.fetch(request)
			return posts
		} catch {
			debugPrint("Posts", "Failure to fetch: \(error)")
		}
		
		return nil
	}
}
