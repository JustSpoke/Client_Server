//
//  FriendListViewController.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 17.10.2021.
//

import UIKit

class FriendListViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    private var headerName = [String]()
    var friends = FriendsLoaderService.loadFriends()
    lazy var filteredArrray = friends
    
    func searchBarAnimation() -> () -> Void {
        return {
            guard let scope = self.searchBar.searchTextField.leftView else {
                return
            }
            guard let textHolder = self.searchBar.textField?.value(forKey: "placeholderLabel") as? UILabel else
			{
				return
			}
			
            UIView.animate(withDuration: 0.2,
                           animations: {
                scope.frame = CGRect(x: self.searchBar.frame.width / 2 - 14,
									 y: scope.frame.origin.y,
									 width: scope.frame.width,
									 height: scope.frame.height)
                textHolder.frame.origin.x -= 20
                self.searchBar.layoutSubviews()
            })
        }
    }
	
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self //указываем серч бару что поиском занимается он
        tableView.sectionHeaderTopPadding = 0
        self.tableView.showsVerticalScrollIndicator = false
        loadHeaderName() //добавляем первые букву имен как подгруппы
    }
    
    override func viewDidAppear(_ animated: Bool) { // появление серч бара
        UIView.animate(withDuration: 0.2,
                       animations: {
            UIView.animate(withDuration: 0,
                           animations:
                            self.searchBarAnimation() )
        })
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int { //сколько секций нужно создать
        return filteredArrray.count
    }
	
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 
        return filteredArrray[section].data.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = friends[section]
        return String(section.key)
    }
    //отображение имен секций, в данном случае первая буква имени
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return headerName
    }
    
    func loadHeaderName() { //буква на которую начинается имя
        for user in friends {
            headerName.append(String(user.key))
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewFriendCell", for: indexPath) as?
                FriendViewCell else {
                    return UITableViewCell() }
        let section = filteredArrray[indexPath.section]
        let name = section.data[indexPath.row].name //параметры для передачи в ячейку
        let icon = section.data[indexPath.row].image
        //конфигурируем ячейку
        cell.configure(name: name, image: UIImage(named: icon)!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = GradientColoueView()
        header.firstColor = .white
        header.endColor = .gray
        
        let label: UILabel = UILabel(frame: CGRect(x: 30, y: 5, width: 20, height: 20))
        label.textColor = UIColor.black
        label.text = headerName[section]
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.black)
        header.addSubview(label)
        
        return header
    }
    
    override func tableView(_ tableView: UITableView,
							willDisplay cell: UITableViewCell,
							forRowAt indexPath: IndexPath) {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewFriendCell",
													for: indexPath) as? FriendViewCell {
            cell.animate()
        }
    }
	
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell,
							forRowAt indexPath: IndexPath) {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewFriendCell", for: indexPath) as?
			FriendViewCell {
            cell.animate()
        }
    }
  
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //подготовка данных для передачи
        guard let vc  = segue.destination as? FriendCollectionViewController else { return
            
        }
        guard let indexPathSection = tableView.indexPathForSelectedRow?.section else { return
        }
        guard let indexPathRow = tableView.indexPathForSelectedRow?.row else { return
        }
        
        let section = filteredArrray[indexPathSection]
        vc.myFriend = section.data[indexPathRow]
    }
//MARK: SearchBar setup
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		filteredArrray = [] //делаем массив пустым
		if searchText == "" {
			filteredArrray = friends //если поле поиска пустое будут показаны все друзья
		} else {
			for section in friends {
				for (_, friend) in section.data.enumerated() {
					if friend.name.lowercased().contains(searchText.lowercased()) { //ищем по нижнему регистру
						var searchedSection = section
						if filteredArrray.isEmpty {
							searchedSection.data = [friend]
							filteredArrray.append(searchedSection)
							break
						}
						var found = false
						for (sectionIndex, filteredSection) in filteredArrray.enumerated() {
							if filteredSection.key == section.key { //если в имени есть нужная буква оно добавляется в массив
								filteredArrray[sectionIndex].data.append(friend)
								found = true
								break
							}
						}
						if !found {
							searchedSection.data = [friend]
							filteredArrray.append(searchedSection)
						}
					}
				}
			}
		}
		self.tableView.reloadData() //обновляем таблицу
	}
	
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) { //при нажатии на серч бар, добавляем кнопку отмены
		self.searchBar.showsCancelButton = true
		let cancelButton = searchBar.value(forKey: "cancelButton") as! UIButton
		cancelButton.backgroundColor = .systemBlue // цвет кнопки
		cancelButton.setTitleColor(.black, for: .normal) //цвет текста
		cancelButton.layer.cornerRadius = 8 // скругляем для более эстетичного вида
		UIView.animate(withDuration: 0.2, //параметры анимации кнопки отмены, ее появления
					   animations: {
			cancelButton.frame = CGRect(x: cancelButton.frame.origin.x - 50,
										y: cancelButton.frame.origin.y,
										width: cancelButton.frame.width,
										height: cancelButton.frame.height)
			self.searchBar.frame = CGRect(x: self.searchBar.frame.origin.x,
										  y: self.searchBar.frame.origin.y,
										  width: self.searchBar.frame.size.width - 1,
										  height: self.searchBar.frame.size.height)
			
			self.searchBar.layoutSubviews()
		})
	}
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) { //нажатие на кнопку отмены, анимация исчезания
		UIView.animate(withDuration: 0.2,
					   animations: {
			searchBar.showsCancelButton = false
			searchBar.text = nil
			searchBar.resignFirstResponder()
		}, completion: {
			_ in let closure = self.searchBarAnimation()
			closure()
		})
	}
}
