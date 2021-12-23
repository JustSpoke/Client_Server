//
//  ControlLike.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 21.10.2021.
//

import UIKit

class ControlLike: UIControl {
    
	var count: Int = 0
    
    private var iconView: UIImageView = UIImageView()
    private var label: UILabel = UILabel()
    private var stackView: UIStackView = UIStackView()
    
    lazy var recognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(click))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        return gesture
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addGestureRecognizer(recognizer)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        self.setupUI()
        addGestureRecognizer(recognizer)
    }
    
    func likeAnimation() {
        let scaleAnimation = CASpringAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.stiffness = 100
        scaleAnimation.mass = 2
        scaleAnimation.duration = 1
        self.label.layer.add(scaleAnimation, forKey: nil)
        self.iconView.layer.add(scaleAnimation, forKey: nil)
    }
    func setupUI() {
        self.backgroundColor = .clear
        let image = UIImage(systemName: "heart")
        iconView.image = image
        iconView.tintColor = .gray
        label.text = String(count)
        
        stackView.alignment = .center
        stackView.frame = bounds
        stackView.spacing = 0
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(iconView)
        
        self.addSubview(stackView)
        
    }
    @objc func click() {
        if count == 0 {
            iconView.image = UIImage(systemName: "heart.fill")
            count += 1
            iconView.tintColor = .red
            likeAnimation()
        } else {
            count -= 1
            iconView.image = UIImage(systemName: "heart")
            iconView.tintColor = .gray
        }
        label.text = String(count)
    }
    
}
