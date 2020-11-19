//
//  CommentCell.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import UIKit

class CommentCell: UITableViewCell {
	
	@IBOutlet weak var bodyLabel: UILabel!
	@IBOutlet weak var authorLabel: UILabel!
	
	func setupCell(commentDisplayable: CommentDisplayable) {
		bodyLabel.text = commentDisplayable.body
		authorLabel.text = commentDisplayable.email
	}
	
}
