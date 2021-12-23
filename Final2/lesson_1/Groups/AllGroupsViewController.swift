//
//  MyGroupsViewController.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 17.10.2021.
//
import UIKit

class AllGroupsViewController: UITableViewController {
	
	var groups = GroupLoaderService.giveGroup()
	
	weak var delegate: MyGroupsDelegate?

	override func viewDidLoad() {
		super.viewDidLoad()

	}

	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return groups.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell",
													   for: indexPath) as? AllGroupsViewCell
		else {
			return UITableViewCell()
		}
		
		cell.groupName.text = groups[indexPath.row].name
		cell.groupIcon.image = groups[indexPath.row].image
	
		return cell
	}
}

