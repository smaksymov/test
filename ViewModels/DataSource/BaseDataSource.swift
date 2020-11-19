//
//  GenericDataSource.swift
//  testProject
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import UIKit

class BaseDataSource<T> : NSObject {
	var data: ChangeableValue<[T]> = ChangeableValue([])
}
