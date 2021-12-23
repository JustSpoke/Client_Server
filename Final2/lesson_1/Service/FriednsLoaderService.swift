//
//  FriednsLoaderService.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 29.10.2021.
//

import UIKit

class FriendsLoaderService  {

	 static var friends: [UserModel] = [
	 UserModel(name: "Lucas", image: "37", imageArray: ["21","28","35"]),
	 UserModel(name: "Molly", image: "27", imageArray: ["22","15","18"]),
	 UserModel(name: "Lucy", image: "26", imageArray: []),
	 UserModel(name: "Mariam", image: "22", imageArray: []),
	 UserModel(name: "Kate", image: "19", imageArray: []),
	 UserModel(name: "Starlord", image: "40", imageArray: []),
	 UserModel(name: "Jack", image: "38", imageArray: []),
	 UserModel(name: "Stephen", image: "31", imageArray: []),
	 UserModel(name: "Antony", image: "39", imageArray: ["22","23","13", "41", "40"]),
	 UserModel(name: "Tanos", image: "29", imageArray: []),
	 UserModel(name: "Peter", image: "23", imageArray: []),
	 UserModel(name: "Shackil", image: "28", imageArray: []),
	 UserModel(name: "Jane", image: "25", imageArray: []),
	 UserModel(name: "Zoe", image: "13", imageArray: [])]
	 
	 static func loadFriends() -> [SectionFriends] {
	 let filteredArray = sortedNames(friends)
	 let sectionsArray = sectionForFriends(filteredArray)
	 return sectionsArray
	 }
	 
	 static func sortedNames(_ array: [UserModel]) -> [Character: [UserModel]] {
	 var newArray: [Character: [UserModel]] = [:]
	 for user in array {
	 guard let firstLetter = user.name.first else {
	 continue
	 }
	 guard var array = newArray[firstLetter] else {
	 let newValue = [user]
	 newArray.updateValue(newValue, forKey: firstLetter)
	 continue
	 }
	 array.append(user)
	 newArray.updateValue(array, forKey: firstLetter)
	 }
	 return newArray
	 }
	 static func sectionForFriends(_ array: [Character : [UserModel]]) -> [SectionFriends] {
	 var sections: [SectionFriends] = []
	 for (key, array) in array {
	 sections.append(SectionFriends(key: key, data: array))
	 }
	 sections.sort {$0 < $1}
	 return sections
	 }
}
	
