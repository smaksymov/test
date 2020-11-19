//
//  PostTableViewCell.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import UIKit

class PostTableViewCell: UITableViewCell {
	
	@IBOutlet weak var postTitle: UILabel!
	@IBOutlet weak var postUser: UILabel!
	
	func setupCell(with postDisplayable: PostDisplayable) {
		postTitle.text = postDisplayable.title
		guard let user = postDisplayable.userModel else {
			postUser.text = StringConstants.anonymous
			return
		}
		postUser.text = user.name
	}
	
}
