//
//  AllGroupsViewController.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 17.10.2021.
//
import UIKit

protocol MyGroupsDelegate: AnyObject {
	func selectGroup(_ group: ModelGroup)
}

class MyGroupsViewController: UITableViewController {
	
	var myGroup = [ModelGroup]()
//	var delegateVC: AllGroupsViewController?
	
	override func viewDidLoad() {
		super.viewDidLoad()

	}
	
	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return myGroup.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
													   for: indexPath) as? MyGroupsViewCell else {
			return UITableViewCell()
		}
		cell.groupIcon.image = myGroup[indexPath.row].image
		cell.groupName.text = myGroup[indexPath.row].name
		return cell
	}
	//MARK: Remove Group
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
							forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			myGroup.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
		}
	}

	@IBAction func addGroup(segue: UIStoryboardSegue) {
//		if segue.identifier == "addGroup" {
			guard let myGroupsController = segue.source as? AllGroupsViewController else { return }
			myGroupsController.delegate = self
			if let indexPath = myGroupsController.tableView.indexPathForSelectedRow {
				let group = myGroupsController.groups[indexPath.row]
				myGroupsController.delegate?.selectGroup(group)
		}
	}
}

extension MyGroupsViewController: MyGroupsDelegate {
	func selectGroup (_ group: ModelGroup) {
		if !myGroup.contains(group) {
			myGroup.append(group)
			tableView.reloadData()
		}
	}
}
