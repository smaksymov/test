//
//  WebRepository.swift
//  testProject
//
//  Created by Stepan Maksymov on 02.12.2020.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import RxSwift

protocol WebRepository{
	associatedtype T
	func getItems() -> Observable<[T]>?
}
