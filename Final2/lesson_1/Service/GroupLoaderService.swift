//
//  GroupLoaderService.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 12.11.2021.
//

import UIKit

class GroupLoaderService {
	static func giveGroup() -> [ModelGroup] {
		return [ModelGroup(name: "EvilRaccoon", image: UIImage(named: "2")),
				ModelGroup(name: "HardRock", image: UIImage(named: "3")),
				ModelGroup(name: "MindBlow", image: UIImage(named: "4"))]
	}
}

func groups() {
	let acceessToken = Session.instance
	let token = acceessToken.token
	
	let configuration = URLSessionConfiguration.default
	
	let session = URLSession(configuration: configuration)
	
	var urlComponents = URLComponents()
	urlComponents.scheme = "https"
	urlComponents.host = "api.vk.com"
	urlComponents.path = "/method/groups.get"
	urlComponents.queryItems = [URLQueryItem(name: "v", value: "5.131"),
								URLQueryItem(name: "access_token", value: token),
								URLQueryItem(name: "extended", value: "1"),
	]
	let startUp = session.dataTask(with: urlComponents.url!) { data, response, error in
		let json = try?  JSONSerialization.jsonObject(with: data!,
													  options: JSONSerialization.ReadingOptions.fragmentsAllowed)
		print(json!)
	}
	startUp.resume()
}

func groupsSearch() {
	let acceessToken = Session.instance
	let token = acceessToken.token
	
	let configuration = URLSessionConfiguration.default
	
	let session = URLSession(configuration: configuration)
	
	var urlComponents = URLComponents()
	urlComponents.scheme = "https"
	urlComponents.host = "api.vk.com"
	urlComponents.path = "/method/groups.get"
	urlComponents.queryItems = [URLQueryItem(name: "v", value: "5.131"),
								URLQueryItem(name: "access_token", value: token),
								URLQueryItem(name: "q", value: "Moscow"),
								URLQueryItem(name: "type", value: "group"),
								URLQueryItem(name: "sort", value: "6")
	]
	let startUp = session.dataTask(with: urlComponents.url!) { data, response, error in
		let json = try?  JSONSerialization.jsonObject(with: data!,
													  options: JSONSerialization.ReadingOptions.fragmentsAllowed)
		print(json!)
	}
	startUp.resume()
}
