//
//  GradientColourView.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 17.10.2021.
//

import UIKit

class GradientColoueView: UIView {
	
	override class var layerClass: AnyClass {
		return CAGradientLayer.self
	}
	var gradientLayer: CAGradientLayer {
		return self.layer as! CAGradientLayer
	}
	//Задать параметры по умолчанию
	@IBInspectable var firstColor: UIColor = .white {
		didSet {
			self.updateColor()
		}
	}
	@IBInspectable var endColor: UIColor = .black {
		didSet {
			self.updateColor()
		}
	}
	
	@IBInspectable var startLocation: CGFloat = 0 {
		didSet {
			self.updateLocation()
		}
	}
	
	@IBInspectable var endLocation: CGFloat = 1 {
		didSet {
			self.updateLocation()
		}
	}
	@IBInspectable var startPoint: CGPoint = .zero {
		didSet {
			self.updateStartPoint()
		}
	}
	@IBInspectable var endPoint: CGPoint = CGPoint(x: 0, y: 1) {
		didSet {
			self.updateEndPoint()
		}
	}
	//обновляем параметры
	func updateLocation() {
		self.gradientLayer.locations = [self.startLocation as NSNumber,
										self.endLocation as NSNumber]
	}
	
	func updateColor() {
		self.gradientLayer.colors = [self.firstColor.cgColor,
									 self.endColor.cgColor]
	}
	
	func updateStartPoint() {
		self.gradientLayer.startPoint = startPoint
	}
	
	func updateEndPoint() {
		self.gradientLayer.endPoint = endPoint
	}
}
