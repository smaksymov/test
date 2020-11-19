//
//  CommentDataSource.swift
//  testProject
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//
import UIKit
import Foundation

class CommentDataSource : BaseDataSource<CommentDisplayable>, UITableViewDataSource {

	var postModel: PostDisplayable?
	
	init(postModel: PostDisplayable?) {
		super.init()
		self.postModel = postModel
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data.value.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let postDetailCellIdentifier = "PostDetailCell"
		let commentCellIdentifier = "CommentCell"
		if indexPath.row > 0 {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: commentCellIdentifier, for: indexPath) as? CommentCell else {
				return UITableViewCell()
			}
			let commentDisplayable = self.data.value[indexPath.row]
			cell.setupCell(commentDisplayable: commentDisplayable)
			return cell
		}
		guard
			let cell = tableView.dequeueReusableCell(withIdentifier: postDetailCellIdentifier, for: indexPath) as? PostDetailCell,
			let post = postModel else {
			return UITableViewCell()
		}
		cell.setupCell(postDisplayable: post)
		return cell

	}
	
	
}
