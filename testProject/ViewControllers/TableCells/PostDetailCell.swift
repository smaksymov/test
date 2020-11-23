//
//  PostDetailCell.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import UIKit

class PostDetailCell: UITableViewCell {
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var bodyLabel: UILabel!
	@IBOutlet weak var authorLabel: UILabel!
	
	func setupCell(postDisplayable: PostDisplayable){
		titleLabel.text = postDisplayable.title
		bodyLabel.text = postDisplayable.body
		guard let user = postDisplayable.userModel else {
			authorLabel.text = StringConstants.anonymous
			return
		}
		authorLabel.text = user.name
	}
	
}
