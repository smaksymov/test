//
//  AddressModel.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import CoreData

protocol AddressDisplayable: AnyObject {
	var street: String { get }
    var suite: String { get }
	var city: String { get }
	var zipCode: String { get }
	var locationD: LocationDisplayable? { get }
}

class AddressWebModel: Codable, AddressDisplayable {
	var locationD: LocationDisplayable? {
		return location
	}
    let street: String
    let suite: String
	let city: String
	let zipCode: String
	let location: LocationWebModel?
    private enum CodingKeys: String, CodingKey {
        case street = "street"
        case suite = "suite"
		case city = "city"
		case zipCode = "zipcode"
		case location = "geo"
    }
}

class AddressCoreModel: NSManagedObject, AddressDisplayable {
	var locationD: LocationDisplayable? {
		return location
	}
	static let ENTITY = "Address"
	@NSManaged var userId: Int32
    @NSManaged var street: String
    @NSManaged var suite: String
	@NSManaged var city: String
	@NSManaged var zipCode: String
	var location: LocationCoreModel?
	
	static func create(from address: AddressWebModel, for userId: Int32, moc: NSManagedObjectContext) -> AddressCoreModel {
		let addressModel = NSEntityDescription.insertNewObject(forEntityName: AddressCoreModel.ENTITY, into: moc) as! AddressCoreModel
		addressModel.userId = userId
		addressModel.street = address.street
		addressModel.suite = address.suite
		addressModel.city = address.city
		addressModel.zipCode = address.zipCode
		if let location = address.location {
			addressModel.location = LocationCoreModel.create(from: location, for: userId, moc: moc)
		}
		return addressModel
	}
	
	static func getByUserId(userId: Int32, moc: NSManagedObjectContext) -> AddressCoreModel? {
		let request = NSFetchRequest<AddressCoreModel>(entityName: AddressCoreModel.ENTITY)
		request.predicate = NSPredicate(format: "%K == %@", "userId", userId)
		do {
			let addresses = try moc.fetch(request)
			if addresses.count > 0 {
				let finalAddress = addresses[0]
				finalAddress.location = LocationCoreModel.getByUserId(userId: userId, moc: moc)
				return finalAddress
			}
		} catch {
			debugPrint("Address", "Failure to fetch: \(error)")
		}
		return nil
	}
}
