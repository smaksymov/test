//
//  ViewController.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	private lazy var postNavigation = PostNavigation(controller: self)

	let dataSource = PostDataSource()

	lazy var viewModel : PostViewModel = {
		let viewModel = PostViewModel(dataSource: dataSource)
		return viewModel
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = dataSource
		tableView.delegate = self
		self.tableView.dataSource = self.dataSource
		self.dataSource.data.addAndNotify(observer: self) { [weak self] in
			self?.tableView.reloadData()
		}
		viewModel.getData()
	}

}


extension PostsViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		postNavigation.navigate(to: PostRoute.postDetail.rawValue, params: [viewModel.dataSource?.data.value[indexPath.row]])
	}

}
