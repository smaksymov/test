//
//  PostDetailViewController.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import UIKit

class PostDetailViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	var post: PostDisplayable?
	var dataSource: CommentDataSource?
	var viewModel : CommentViewModel?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if let post = post {
			dataSource = CommentDataSource(postModel: post)
			viewModel = CommentViewModel(dataSource: dataSource)
		}
		tableView.dataSource = dataSource
		dataSource?.data.addAndNotify(observer: self) { [weak self] in
			self?.tableView.reloadData()
		}
		viewModel?.getData()
	}

	func configure(post: PostDisplayable) {
		self.post = post
	}
	
}

