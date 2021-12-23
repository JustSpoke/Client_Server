//
//  CustomNavigationController.swift.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 05.11.2021.
//

import UIKit

final class CustomNavigationController: UINavigationController, UINavigationControllerDelegate{
	let intTransition = InteractiveTransition()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		delegate = self
	}
	
	//MARK: NavigationControllerDelegate
	func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
		return intTransition.isStarted ? intTransition : nil
	}
	
	func navigationController(_ navigationController: UINavigationController,
							  animationControllerFor operation: UINavigationController.Operation,
							  from fromVC: UIViewController,
							  to toVC: UIViewController
	) -> UIViewControllerAnimatedTransitioning? {
		switch operation {
		case .pop:
			if navigationController.viewControllers.first != toVC {
				intTransition.viewController = toVC
			}
			return PopAnimator()
		case .push:
		intTransition.viewController = toVC
		return PushAnimator()
	default:
		return nil
	}
}
}
