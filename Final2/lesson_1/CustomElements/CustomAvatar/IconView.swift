//
//  IconView.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 21.10.2021.
//

import UIKit

@IBDesignable class IconView: UIView {
    
    private var iconView: UIImageView = UIImageView()
    private var containView: UIView = UIView()
    
    var icon: UIImage = UIImage() {
    didSet {
        iconView.image = icon
    }
    }

@IBInspectable var shadowColor :UIColor = .black {
    didSet {
        self.updateColor()
    }
}

    @IBInspectable var shadowOpacity: Float = 4.0 {
    didSet {
        self.updateOpacity()
    }
}

    @IBInspectable var shadowRadius :CGFloat = 3.0 {
    didSet {
        self.updateRadius()
    }
}

    @IBInspectable var shadowOffset: CGSize = .zero {
    didSet {
        self.updateOffset()
    }
}
 //MARK: Animaton
    @objc func animate() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [],
                       animations: {
            self.iconView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        })
        UIView.animate(withDuration: 0.5,
                       delay: 0.2,
                       usingSpringWithDamping: 0.8, //анимация "пружина"
                       initialSpringVelocity: 80, // жесткость пружины
                       options: [],
                       animations: {
            
            self.iconView.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    //Gestures/taps
    //MARK: Recognizer
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(animate))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        return recognizer
    }()
	
//MARK: Setup icon view
private func setupIcon() {
    containView.frame = self.bounds
    containView.layer.cornerRadius = 25
    
    iconView.layer.masksToBounds = true
    iconView.frame = containView.bounds // рамки аватарки
    iconView.contentMode = .scaleAspectFill // тип заполнения вьюхи
    iconView.layer.cornerRadius = iconView.frame.size.width / 3 //углы аватарки
    iconView.image = icon
    
    containView.addSubview(iconView)
    self.addSubview(containView)
    updateShadows()
    
}
	
private func updateOpacity() {
    self.containView.layer.shadowOpacity = shadowOpacity
}

private func updateColor() {
    self.containView.layer.shadowColor = shadowColor.cgColor
}

private func updateOffset() {
    self.containView.layer.shadowOffset = shadowOffset
}

private func updateRadius() {
    self.containView.layer.shadowRadius = shadowRadius
}

private func updateShadows() {
    self.containView.layer.shadowOpacity = shadowOpacity
    self.containView.layer.shadowColor = shadowColor.cgColor
    self.containView.layer.shadowRadius = shadowRadius
    self.containView.layer.shadowOffset = shadowOffset
    
}
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupIcon()
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        self.setupIcon()
        addGestureRecognizer(tapGestureRecognizer)
    }
}
