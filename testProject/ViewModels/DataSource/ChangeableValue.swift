//
//  ChangeableValue.swift
//  testProject
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation

typealias ObserveHandler = (() -> Void)

class ChangeableValue<T> {

	var value : T {
		didSet {
			self.notify()
		}
	}

	private var observers = [String: ObserveHandler]()

	init(_ value: T) {
		self.value = value
	}

	public func addObserver(_ observer: NSObject, completionHandler: @escaping ObserveHandler) {
		observers[observer.description] = completionHandler
	}

	public func addAndNotify(observer: NSObject, completionHandler: @escaping ObserveHandler) {
		self.addObserver(observer, completionHandler: completionHandler)
		self.notify()
	}

	private func notify() {
		observers.forEach({ $0.value() })
	}

	deinit {
		observers.removeAll()
	}
}
