//
//  ViewController.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import UIKit
import RxSwift

class PostsViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	private lazy var postNavigation = PostNavigation(controller: self)
	private let viewModel = PostViewModel()
	private var disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = nil
		tableView.delegate = nil
		setupBindingAndActions()
		viewModel.getData()
	}
	
	func setupBindingAndActions() {
		let postCellIdentifier = "PostTableViewCell"
		viewModel.dataSource.bind(to: tableView.rx.items(cellIdentifier: postCellIdentifier, cellType: PostTableViewCell.self)) {  row, element, cell in
			cell.setupCell(with: element)
		}.disposed(by: disposeBag)

		Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(PostDisplayable.self))
			.bind { [weak self] indexPath, item in
				self?.tableView.deselectRow(at: indexPath, animated: true)
				self?.postNavigation.navigate(to: PostRoute.postDetail.rawValue, params: [item])
			}.disposed(by: disposeBag)
	}
}
