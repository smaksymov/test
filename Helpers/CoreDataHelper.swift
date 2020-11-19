//
//  CoreDataHelper.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHelper {
	static var shared = CoreDataHelper()
	private var managedContext: NSManagedObjectContext?
	
	var managedObjectContext: NSManagedObjectContext {
		if let managedContext = managedContext {
			return managedContext
		} else {
			let mContext = createManagedObjectContext()
			managedContext = mContext
			return mContext
		}
	}
	
	private func applicationDocumentsDirectory() -> URL {
		let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return urls[urls.count-1]
	}
	
	private func managedObjectModel() -> NSManagedObjectModel {
		let modelURL = Bundle.main.url(forResource: "DataModel", withExtension: "momd")!
		return NSManagedObjectModel(contentsOf: modelURL)!
	}
	
	private func persistentStoreCoordinator() -> NSPersistentStoreCoordinator {
		let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel())
		let url = applicationDocumentsDirectory().appendingPathComponent("test.sqlite")
		let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
		do {
			try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
		} catch {
			abort()
		}
		return coordinator
	}

	private func createManagedObjectContext() -> NSManagedObjectContext {
		let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
		moc.persistentStoreCoordinator = persistentStoreCoordinator()
		moc.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
		moc.undoManager = nil
		return moc
	}

	private func createSyncManagedObjectContext() -> NSManagedObjectContext {
		let moc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
		moc.persistentStoreCoordinator = persistentStoreCoordinator()
		moc.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
		moc.undoManager = nil
		return moc
	}

}
