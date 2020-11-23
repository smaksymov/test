//
//  UserModel.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import CoreData

protocol UserDisplayable: AnyObject {
	var id: Int32 { get }
    var name: String { get }
    var username: String { get }
    var email: String { get }
    var addressD: AddressDisplayable? { get }
    var phone: String { get }
    var website: String { get }
	var companyD: CompanyDisplayable? { get }
}

class UserWebModel: Codable, UserDisplayable {
    var id: Int32
    var name: String
    var username: String
    var email: String
    var address: AddressWebModel?
    var phone: String
    var website: String
    var company: CompanyWebModel?
	var addressD: AddressDisplayable? {
		return address
	}
	var companyD: CompanyDisplayable? {
		return company
	}

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case username = "username"
        case email = "email"
		case address = "address"
		case phone = "phone"
		case website = "website"
		case company = "company"
    }
}

class UserCoreModel: NSManagedObject, UserDisplayable {
	static let ENTITY = "User"
    @NSManaged var id: Int32
    @NSManaged var name: String
    @NSManaged var username: String
    @NSManaged var email: String
    var address: AddressCoreModel?
    @NSManaged var phone: String
    @NSManaged var website: String
    var company: CompanyCoreModel?
	var addressD: AddressDisplayable? {
		return address
	}
	var companyD: CompanyDisplayable? {
		return company
	}
	
	static func create(from user: UserWebModel, moc: NSManagedObjectContext) -> UserCoreModel {
		let userModel = NSEntityDescription.insertNewObject(forEntityName: UserCoreModel.ENTITY, into: moc) as! UserCoreModel
		userModel.id = user.id
		userModel.name = user.name
		userModel.username = user.username
		userModel.email = user.email
		userModel.phone = user.phone
		userModel.website = user.website
		if let address = user.address {
			userModel.address = AddressCoreModel.create(from: address, for: user.id, moc: moc)
		}
		if let company = user.company {
			userModel.company = CompanyCoreModel.create(from: company, for: user.id, moc: moc)
		}
		return userModel
	}
	
	static func getAll(moc: NSManagedObjectContext) -> [UserCoreModel]? {
		let request = NSFetchRequest<UserCoreModel>(entityName: UserCoreModel.ENTITY)
		do {
			let users = try moc.fetch(request)
			return users
		} catch {
			debugPrint("Users", "Failure to fetch: \(error)")
		}
		return nil
	}
	static func getByUserId(userId: Int32, moc: NSManagedObjectContext) -> UserCoreModel? {
		let request = NSFetchRequest<UserCoreModel>(entityName: UserCoreModel.ENTITY)
		request.predicate = NSPredicate(format: "%K == %@", "id", userId)
		do {
			let user = try moc.fetch(request)
			if user.count > 0 {
				let finalUser = user[0]
				finalUser.address = AddressCoreModel.getByUserId(userId: userId, moc: moc)
				finalUser.company = CompanyCoreModel.getByUserId(userId: userId, moc: moc)
				return finalUser
			}
		} catch {
			debugPrint("Users", "Failure to fetch: \(error)")
		}
		return nil
	}

	
	
}
