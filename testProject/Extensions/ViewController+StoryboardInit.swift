//
//  ViewController+StoryboardInit.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

	class var storyboardID : String {
		return "\(self)"
	}
	
    static func instanticateFromStoryboard(storyboard: AppStoryboard) -> Self {
        return storyboard.viewController(viewControllerClass: self)
    }
    
    func setMainViewController(sourceController: UIViewController) {
        sourceController.present(self, animated: true, completion: nil)
    }

    func setMainViewControllerWithoutAnimation(sourceController: UIViewController) {
        sourceController.present(self, animated: false, completion: nil)
    }

    func setMainViewControllerViaNavigation(sourceController: UIViewController) {
        sourceController.navigationController?.pushViewController(self, animated: true)
    }

    func setMainViewControllerViaNavigationNoAnimation(sourceController: UIViewController) {
        sourceController.navigationController?.pushViewController(self, animated: false)
    }

	
}
