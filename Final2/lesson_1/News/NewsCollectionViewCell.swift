//
//  NewsCollectionViewCell.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 29.10.2021.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    
    func configure(with image: UIImage) {
        newsImage.image = image
    }
}
