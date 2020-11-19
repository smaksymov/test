//
//  CommentModel.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import CoreData

protocol CommentDisplayable: AnyObject {
	var id: Int32 { get }
	var postId: Int32 { get }
	var name: String { get }
	var email: String { get }
	var body: String { get }
}

class CommentWebModel: Codable, CommentDisplayable {
    let id: Int32
	let postId: Int32
	let name: String
    let email: String
    let body: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case postId = "postId"
        case name = "name"
        case email = "email"
		case body = "body"
    }
}

class CommentCoreModel: NSManagedObject, CommentDisplayable {
	static let ENTITY = "Comment"
    @NSManaged var id: Int32
	@NSManaged var postId: Int32
	@NSManaged var name: String
    @NSManaged var email: String
    @NSManaged var body: String
    
	static func create(from comment: CommentWebModel, moc: NSManagedObjectContext) -> CommentCoreModel {
		let commentModel = NSEntityDescription.insertNewObject(forEntityName: CommentCoreModel.ENTITY, into: moc) as! CommentCoreModel
		commentModel.id = comment.id
		commentModel.body = comment.body
		commentModel.postId = comment.postId
		commentModel.name = comment.name
		commentModel.email = comment.email
		return commentModel
	}
	
	static func getAll(moc: NSManagedObjectContext) -> [CommentCoreModel]? {
		let request = NSFetchRequest<CommentCoreModel>(entityName: CommentCoreModel.ENTITY)
		do {
			let comments = try moc.fetch(request)
			return comments
		} catch {
			debugPrint("Posts", "Failure to fetch: \(error)")
		}
		return nil
	}
	static func getByPostId(postId: Int32, moc: NSManagedObjectContext) -> [CommentCoreModel]? {
		let request = NSFetchRequest<CommentCoreModel>(entityName: CommentCoreModel.ENTITY)
		request.predicate = NSPredicate(format: "%K == %@", "postId", postId)
		do {
			let comments = try moc.fetch(request)
			return comments
		} catch {
			debugPrint("Posts", "Failure to fetch: \(error)")
		}
		return nil
	}

}
