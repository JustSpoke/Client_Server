//
//  UserModel.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 29.10.2021.
//

import UIKit

struct UserModel {
	let name: String
	let image: String
	let uiImage: UIImage
	var imageArray: [UIImage] = []
	
	init(name: String, image: String, imageArray: [String]) {
		self.name = name
		self.image = image
		
		uiImage = UIImage(named: image) ?? UIImage()
		
		for storedImage in imageArray {
			guard let image = UIImage(named: storedImage) else {
				continue
			}
			self.imageArray.append(image)
		}
	}
}
