//
//  PostNavigation.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import UIKit

enum PostRoute: String {
	case postDetail = "PostDetail"
}

class PostNavigation: NavigationProtocol {
	
	weak var currentViewController: UIViewController?
	init(controller: UIViewController) {
		currentViewController = controller
	}
	
	func navigate(to destination: String, params: [Any?]) {
		switch destination {
		case PostRoute.postDetail.rawValue:
			guard
				params.count == 1,
				let post = params[0] as? PostDisplayable,
				let currentController = currentViewController
				else { return }
			guard let postDetailController = AppStoryboard.PostDetailViewController.initialViewController() as? PostDetailViewController else { return }
			postDetailController.configure(post: post)
			postDetailController.setMainViewControllerViaNavigation(sourceController: currentController)
		default:
			break
		}
	}


	
}
