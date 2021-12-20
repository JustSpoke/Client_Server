//
//  FriendTableViewCell.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 29.10.2021.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    static let xibIdentifier = "FriendCell"
    static let cellIdentifier = "FriendCellIdentifier"
    
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendImage: IconView!
    
  //конфигурация ячейки
    func configure(name: String, image: UIImage) {
        friendName.text = name
        friendImage.icon = image
    }
}
