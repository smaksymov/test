//
//  LocationModel.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import CoreData

protocol LocationDisplayable: AnyObject {
	var latitude: String { get }
	var longitude: String { get }
}

class LocationWebModel: Codable, LocationDisplayable {
    let latitude: String
    let longitude: String
    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}

class LocationCoreModel: NSManagedObject, LocationDisplayable {
	static let ENTITY = "Location"
	@NSManaged var userId: Int32
    @NSManaged var latitude: String
    @NSManaged var longitude: String
	
	
	static func create(from location: LocationWebModel, for userId: Int32, moc: NSManagedObjectContext) -> LocationCoreModel {
		let locationModel = NSEntityDescription.insertNewObject(forEntityName: LocationCoreModel.ENTITY, into: moc) as! LocationCoreModel
		locationModel.userId = userId
		locationModel.latitude = location.latitude
		locationModel.longitude = location.longitude
		return locationModel
	}

	static func getByUserId(userId: Int32, moc: NSManagedObjectContext) -> LocationCoreModel? {
		let request = NSFetchRequest<LocationCoreModel>(entityName: LocationCoreModel.ENTITY)
		request.predicate = NSPredicate(format: "%K == %@", "userId", userId)
		do {
			let locations = try moc.fetch(request)
			if locations.count > 0 {
				let finalLocation = locations[0]
				return finalLocation
			}
		} catch {
			debugPrint("Location", "Failure to fetch: \(error)")
		}
		return nil
	}

	
}
