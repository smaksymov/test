//
//  NavigationProtocol.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import UIKit

protocol NavigationProtocol {
	func navigate(to destination: String, params: [Any?])
}
