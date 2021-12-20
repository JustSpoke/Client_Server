//
//  FriendViewCell.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 17.10.2021.
//

import UIKit

class FriendViewCell: UITableViewCell {
    
  
    @IBOutlet weak var friendPhoto: IconView!
    @IBOutlet weak var friendName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(name: String, image: UIImage) {
        friendName.text = name
        friendPhoto.icon = image
        animate()
    }
    
    func animate() {
        self.friendPhoto.alpha = 0
        self.frame.origin.x += 200
        
        UIView.animate(withDuration: 0.2,
                       delay: 0.1,
                       options: [],
                       animations: {
            self.friendPhoto.alpha = 1
            })
        
        UIView.animate(withDuration: 0.2,
                       delay: 0.06,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
            self.frame.origin.x = 0
        })
    }
}
