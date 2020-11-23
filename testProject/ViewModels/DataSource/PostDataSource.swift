//
//  PostDataSource.swift
//  testProject
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import UIKit
import Foundation

class PostDataSource : BaseDataSource<PostDisplayable>, UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data.value.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let postCellIdentifier = "PostTableViewCell"
		guard let cell = tableView.dequeueReusableCell(withIdentifier: postCellIdentifier, for: indexPath) as? PostTableViewCell else {
			return UITableViewCell()
		}

		let cellDataPostDisplayable = self.data.value[indexPath.row]
		cell.setupCell(with: cellDataPostDisplayable)
		return cell
	}

	
	
}
