//
//  GroupSearchController.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 17.11.2021.
//

import UIKit

class GroupSearchController: UITableViewController, UISearchBarDelegate {

	@IBOutlet weak var searchBar: UISearchBar!
	
	var group = GroupLoaderService.giveGroup()
	lazy var filteredGroups = group
	
    override func viewDidLoad() {
        super.viewDidLoad()
		searchBar.delegate = self
    }
	
	//MARK: SearchBar
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		filteredGroups = []
		if searchText == "" {
			filteredGroups = group
		} else {
			for newGroup in group {
				if newGroup.name.lowercased().contains(searchText.lowercased()) {
					filteredGroups.append(newGroup)
				}
			}
		}
		self.tableView.reloadData()
	}
	

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		return filteredGroups.count
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as?
				SearchCell else {
			return UITableViewCell()
		}
		cell.groupName.text = filteredGroups[indexPath.row].name
		cell.groupIcon.image = filteredGroups[indexPath.row].image
		
		return cell
	}


}
