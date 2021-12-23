//
//  CollectionViewCell.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 17.10.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    
 
   func configure(with model: ModelFriend) {
    friendImage.image = UIImage(named: model.icon)
    friendName.text  = model.name
   }
}
