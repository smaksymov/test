//
//  AppStoryboard.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryboard : String, CaseIterable {
    case PostViewController,
		 PostDetailViewController
	
	private var ipadStoryboards : [String] {
		return []
	}
	
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }

    func viewController<T : UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }

	var instance : UIStoryboard {
		if UIDevice.current.userInterfaceIdiom == .pad && ipadStoryboards.contains(self.rawValue) {
			return UIStoryboard(name: "\(self.rawValue)Ipad", bundle: Bundle.main)
        }
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

}
