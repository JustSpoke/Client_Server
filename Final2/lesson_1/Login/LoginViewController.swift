//
//  ViewController.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 07.10.2021.
//

import UIKit

class LoginViewController: UIViewController {
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var loginInput: UITextField!
	@IBOutlet weak var passwordInput: UITextField!
	@IBOutlet weak var loading: LoadingDot!
	@IBOutlet var backgroundView: UIView!
	
	//MARK: Life
	override func viewDidLoad() {
		super.viewDidLoad()
		let hideKeyboardGesture = UITapGestureRecognizer(target: self,
														 action: #selector(hideKeyboard))
		scrollView?.addGestureRecognizer(hideKeyboardGesture)
	}
	//Появления клавиатуры
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		NotificationCenter.default.addObserver(self,
											   selector: #selector(self.keyboardWasShown),
											   name: UIResponder.keyboardWillShowNotification,
											   object: nil)
		NotificationCenter.default.addObserver(self,
											   selector: #selector(self.keyboardWillBeHidden(notification:)),
											   name: UIResponder.keyboardWillHideNotification,
											   object: nil)
		self.navigationController?.isNavigationBarHidden = true
	}
	//MARK: Start animations
	override func viewDidAppear(_ animated: Bool) {
		//loading.animateDots()
		pathAnimation()
	}
	//Убрать клавиатуру
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		NotificationCenter.default.removeObserver(self,
												  name: UIResponder.keyboardWillShowNotification,
												  object: nil)
		NotificationCenter.default.removeObserver(self,
												  name: UIResponder.keyboardWillHideNotification,
												  object: nil)
	}
	//MARK: LogIn check
	override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
		let checkResult = checkUserData()
		if !checkResult {
			showLoginError()
		}
		return checkResult
	}
	
	//Настройки размера клавиатуры/ скролл при клавиатуре
	@objc func keyboardWasShown(notification: Notification) {
		let info = notification.userInfo! as NSDictionary
		let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
		let contentInsets = UIEdgeInsets(top: 0.0,
										 left: 0.0,
										 bottom: kbSize.height,
										 right: 0.0)
		self.scrollView?.contentInset = contentInsets
		scrollView?.scrollIndicatorInsets = contentInsets
	}
	//Скролл при убранной клавиатуре
	@objc func keyboardWillBeHidden(notification: Notification) {
		let contentInsets = UIEdgeInsets.zero
		scrollView?.contentInset = contentInsets
	}
	// функция скрытия клавиатуры
	@objc func hideKeyboard() {
		self.scrollView?.endEditing(true)
	}
	
	//Сигвей для выхода из учетной записи
	@IBAction func logOut(unwindSegue: UIStoryboardSegue) {
		
	}
}
// MARK: UIScrollViewDelegate
extension LoginViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		scrollView.contentOffset.x = 0.0
	}
}
//MARK: - Private
private extension LoginViewController {
	
	func checkUserData() -> Bool {
		guard let login = loginInput.text,
			  let password = passwordInput.text else {
				  return false
			  }
		if login == "admin" && password == "123456" {
			return true
		} else {
			return false
		}
	}
	//MARK: ALERT
	//Alert уведомление
	func showLoginError() {
		let alert = UIAlertController(title: "Ошибка",
									  message: "Не верные данные, проверьте и повторите попытку еще раз",
									  preferredStyle: .alert)
		let action = UIAlertAction(title: "OK",
								   style: .cancel,
								   handler: nil)
		alert.addAction(action)
		present(alert,
				animated: true,
				completion: nil)
	}
	
	//MARK: Loading Animation
	func pathAnimation() {
		let cloudView = UIView()
		view.addSubview(cloudView)
		cloudView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			cloudView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			cloudView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor,
											  constant: -10),
			cloudView.widthAnchor.constraint(equalToConstant: 120),
			cloudView.heightAnchor.constraint(equalToConstant: 70)
		])
		// отрисовка по точкам
		let path = UIBezierPath()
		path.move(to: CGPoint(x: 10, y: 60))
		path.addQuadCurve(to: CGPoint(x: 20, y: 40), controlPoint: CGPoint(x: 5, y: 50))
		path.addQuadCurve(to: CGPoint(x: 40, y: 20), controlPoint: CGPoint(x: 20, y: 20))
		path.addQuadCurve(to: CGPoint(x: 70, y: 20), controlPoint: CGPoint(x: 55, y: 0))
		path.addQuadCurve(to: CGPoint(x: 80, y: 30), controlPoint: CGPoint(x: 80, y: 20))
		path.addQuadCurve(to: CGPoint(x: 110, y: 60), controlPoint: CGPoint(x: 110, y: 30))
		path.close()
		
		let layerAnimation = CAShapeLayer()
		layerAnimation.path = path.cgPath //отрисовка пути
		layerAnimation.strokeColor = UIColor.white.cgColor // цвет линии
		layerAnimation.fillColor = UIColor.clear.cgColor // цвет заполнения фигуры
		layerAnimation.lineWidth = 7 //ширина линии
		layerAnimation.lineCap = .round //закругление углов линии
		cloudView.layer.addSublayer(layerAnimation)
		
		//начало анимации
		let pathAnimationStart = CABasicAnimation(keyPath: "strokeStart")
		pathAnimationStart.fromValue = 0
		pathAnimationStart.toValue = 1
		pathAnimationStart.duration = 1
		pathAnimationStart.fillMode = .both
		pathAnimationStart.isRemovedOnCompletion = false
		pathAnimationStart.beginTime = 1
		
		//конец анимации
		let pathAnimationEnd = CABasicAnimation(keyPath: "strokeEnd")
		pathAnimationEnd.fromValue = 0
		pathAnimationEnd.toValue = 1
		pathAnimationEnd.duration = 1
		pathAnimationEnd.fillMode = .both
		pathAnimationEnd.isRemovedOnCompletion = false
		layerAnimation.add(pathAnimationEnd, forKey: nil)
		
		//создание группы анимаций
		let animationGroup = CAAnimationGroup()
		animationGroup.duration = 3
		animationGroup.fillMode = CAMediaTimingFillMode.backwards
		animationGroup.animations = [pathAnimationEnd, pathAnimationStart]
		animationGroup.repeatCount = .infinity
		layerAnimation.add(animationGroup, forKey: nil)
	}
	
}

