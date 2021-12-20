//
//  SearchCell.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 17.11.2021.
//

import UIKit

class SearchCell: UITableViewCell {
	
	@IBOutlet weak var groupName: UILabel!
	@IBOutlet weak var groupIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
