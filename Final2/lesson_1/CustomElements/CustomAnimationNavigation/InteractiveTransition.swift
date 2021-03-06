//
//  InteractiveTransition.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 05.11.2021.
//

import UIKit

final class InteractiveTransition: UIPercentDrivenInteractiveTransition {
	
	var viewController: UIViewController? {
		didSet {
			let recognizer = UIScreenEdgePanGestureRecognizer(target: self,
															  action: #selector(handling(_:)))
			recognizer.edges = [.left]
			viewController?.view.addGestureRecognizer(recognizer)
		}
	}
	var isStarted: Bool = false
	private var shouldFinish: Bool = false
	
	@objc func handling(_ recognizer: UIScreenEdgePanGestureRecognizer) {
		switch recognizer.state {
		case .began:
			isStarted = true
			viewController?.navigationController?.popViewController(animated: true)
		case .changed:
			let transition = recognizer.translation(in: recognizer.view)
			let relative = transition.x / (recognizer.view?.bounds.width ?? 1)
			let progress = max(0, min(1, relative * 3))
			self.shouldFinish = progress > 0.4
			update(progress)
		case .ended:
			isStarted = false
			shouldFinish ? finish() : cancel()
		case .cancelled:
			isStarted = false
			cancel()
		default:
			return
		}
	}
}
