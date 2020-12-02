//
//  PostCached.swift
//  testProject
//
//  Created by Stepan Maksymov on 02.12.2020.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation

protocol RepositoryCached: Repository {
	var cachedItems: [T] { get set }
}
