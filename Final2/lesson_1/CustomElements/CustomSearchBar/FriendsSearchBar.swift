//
//  FriendsSearchBar.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 29.10.2021.
//

import UIKit

extension UISearchBar {
    
    public var textField: UITextField? {
        if #available(iOS 13, *) {
            return searchTextField
        }
        let subView = subviews.flatMap { $0.subviews }
        guard let textField = (subView.filter { $0 is UITextField }).first as? UITextField else {
            return nil
        }
        return textField
    }
    func clearBackGround() {
        guard let UISearhBarBackground: AnyClass = NSClassFromString("UISearchBarBackground") else {
			return
			}
        
        for view in subviews {
            for subview in view.subviews where subview.isKind(of: UISearhBarBackground) { subview.alpha = 0
                
            }
        }
    }
    
    func changePlaceholderColor(_ color: UIColor) {
        guard let UISearchBarTextFieldLabel: AnyClass = NSClassFromString("UISearchBarTextFieldLabel"),
        let field = textField else { return
        }
        for subview in field.subviews where subview.isKind(of: UISearchBarTextFieldLabel) {
            (subview as! UILabel).textColor = color
        }
    }
    func setRightImage(normalImage: UIImage, highLightedImage: UIImage) {
        showsBookmarkButton = true
        if let button = textField?.rightView as? UIButton {
            button.setImage(normalImage,
							for: .normal)
            button.setImage(highLightedImage,
							for: .highlighted)
        }
    }
    
    func setLeftImage(_ image: UIImage, with padding: CGFloat = 0, tintColor: UIColor) {
        let imageView = UIImageView()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive =  true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.tintColor = tintColor
        
        
        if padding != 0 {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.distribution = .fill
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            let paddingView = UIView()
            paddingView.translatesAutoresizingMaskIntoConstraints = false
            paddingView.widthAnchor.constraint(equalToConstant: padding).isActive = true
            paddingView.heightAnchor.constraint(equalToConstant: padding).isActive = true
            stackView.addArrangedSubview(paddingView)
            stackView.addArrangedSubview(imageView)
            textField?.leftView = stackView
        } else {
            textField?.leftView = imageView
        }
    }
}

extension UIImage {
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1,
														   height: 1)) {
        let rect = CGRect(x: 0,
						  y: 0,
						  width: size.width,
						  height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size,
											   false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage!)!)
        
    }
}
