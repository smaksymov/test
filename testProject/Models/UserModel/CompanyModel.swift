//
//  CompanyModel.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import CoreData

protocol CompanyDisplayable: AnyObject {
	var name: String { get }
    var catchPhrase: String { get }
	var bs: String { get }
}


class CompanyWebModel: Codable, CompanyDisplayable {
    let name: String
    let catchPhrase: String
	let bs: String // Who is naming json vars like this? name should introduce meaning of the value :((
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case catchPhrase = "catchPhrase"
		case bs = "bs"
    }
}

class CompanyCoreModel: NSManagedObject, CompanyDisplayable {
	static let ENTITY = "Company"
	@NSManaged var userId: Int32
    @NSManaged var name: String
    @NSManaged var catchPhrase: String
	@NSManaged var bs: String
	
	static func create(from company: CompanyWebModel, for userId: Int32, moc: NSManagedObjectContext) -> CompanyCoreModel {
		let companyModel = NSEntityDescription.insertNewObject(forEntityName: CompanyCoreModel.ENTITY, into: moc) as! CompanyCoreModel
		companyModel.userId = userId
		companyModel.name = company.name
		companyModel.catchPhrase = company.catchPhrase
		companyModel.bs = company.bs
		return companyModel
	}
	
	static func getByUserId(userId: Int32, moc: NSManagedObjectContext) -> CompanyCoreModel? {
		let request = NSFetchRequest<CompanyCoreModel>(entityName: CompanyCoreModel.ENTITY)
		request.predicate = NSPredicate(format: "%K == %@", "userId", userId)
		do {
			let companies = try moc.fetch(request)
			if companies.count > 0 {
				let finalCompany = companies[0]
				return finalCompany
			}
		} catch {
			debugPrint("Company", "Failure to fetch: \(error)")
		}
		return nil
	}
}
