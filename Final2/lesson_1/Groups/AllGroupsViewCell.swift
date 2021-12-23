//
//  MyGroupsViewCell.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 17.10.2021.
//
import UIKit

class AllGroupsViewCell: UITableViewCell {

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
	
	func configure(name: String, image: UIImage?) {
		groupName.text = name
		groupIcon.image = image
	}
}
