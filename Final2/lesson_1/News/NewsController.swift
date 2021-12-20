//
//  NewsController.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 29.10.2021.
//

import UIKit

class NewsController: UITableViewController {
	
	let news = NewsLoader.newsFeed()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 500
		tableView.sectionHeaderTopPadding = 0
		tableView.reloadData()
	}
	
	// MARK: - Table view data source
	override func numberOfSections(in tableView: UITableView) -> Int {
		return news.count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell",
													   for: indexPath) as? NewsTableViewCell else {
			return UITableViewCell()
		}
		cell.configure(with: news[indexPath.section])
		return cell
	}
	
	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let footer = UIView(frame: CGRect(x: 0,
										  y: 0,
										  width: tableView.frame.width,
										  height: 30))
		
		let likes = ControlLike(frame: CGRect(x: 5,
											  y: 0,
											  width: 50,
											  height: 20))
		likes.tintColor = .red
		
		let views = UILabel(frame: CGRect(x: footer.frame.size.width - 50,
										  y: 0,
										  width: 50,
										  height: 20))
		views.text = "50"
		views.font = UIFont.systemFont(ofSize: 16)
		footer.addSubview(likes)
		footer.addSubview(views)
		return footer
	}
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 1))
		header.backgroundColor = .systemBackground
		
		return header
	}
	
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		4.0
	}
	
}
