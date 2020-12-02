//
//  PostDetailViewController.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class PostDetailViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	private var disposeBag = DisposeBag()
	var post: PostDisplayable?
	var viewModel : CommentViewModel?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if let post = post {
			viewModel = CommentViewModel(post: post)
		}
		tableView.dataSource = nil
		tableView.delegate = nil
		setupBindingAndActions()
		viewModel?.getData()
	}
	
	func setupBindingAndActions() {
		let postDetailCellIdentifier = "PostDetailCell"
		let commentCellIdentifier = "CommentCell"

		viewModel?.dataSource.bind(to: tableView.rx.items) {(tableView, row, item) -> UITableViewCell in
			let indexPath = IndexPath(row: row, section: 0)
			switch(item){
			case let item as PostDisplayable:
				guard
					let cell = tableView.dequeueReusableCell(withIdentifier: postDetailCellIdentifier, for: indexPath ) as? PostDetailCell else {
					return UITableViewCell()
				}
				cell.setupCell(postDisplayable: item)
				return cell
			case let item as CommentDisplayable:
				guard let cell = tableView.dequeueReusableCell(withIdentifier: commentCellIdentifier, for: indexPath) as? CommentCell else {
					return UITableViewCell()
				}
				cell.setupCell(commentDisplayable: item)
				return cell
			default:
				return UITableViewCell()
			}
			
		}.disposed(by: disposeBag)

		
	}
	func configure(post: PostDisplayable) {
		self.post = post
	}
	
}

