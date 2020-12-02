//
//  UserRepository.swift
//  testProject
//
//  Created by Stepan Maksymov on 02.12.2020.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation

protocol Repository{
	associatedtype T
	func getItems() -> [T]?
	func getItemById(id: Int32) -> T?
	func getItemsById(subId: Int32) -> [T]?
}

extension Repository {
	func getItemsById(subId: Int32) -> [T]? { return nil }
}
