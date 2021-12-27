//
//  URLService.swift.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 20.11.2021.
//

import Foundation

//MARK: - Requests
enum Requests {
	case friends
	case photos
	case groups
	case searchGroups
}


protocol ServiceManagerProtocol  {
	//requests for auth
	func loadRequests() -> URLRequest
	
	//choose request to load data
	func loadData(scenario: Requests)
}

//MARK: - WebRequest
final class URLServices: ServiceManagerProtocol {
	
	func loadRequests() -> URLRequest {
		
		var urlComponents = URLComponents()
		urlComponents.scheme = "https"
		urlComponents.host = "oauth.vk.com"
		urlComponents.path = "/authorize"
		urlComponents.queryItems = [
			URLQueryItem(name: "client_id", value: "8001822"), //app id
			URLQueryItem(name: "display", value: "mobile"), // type of displaying
			URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"), //redirect
			URLQueryItem(name: "scope", value: "offline"), //some params to display 262150
			URLQueryItem(name: "response_type", value: "token"), //response token
			URLQueryItem(name: "v", value: "5.131")] //version of API
		return URLRequest(url: urlComponents.url!)
	}
	
	func loadData(scenario: Requests) {
		
		guard
			  let token = Session.instance.token,
			  let userID = Session.instance.userId
		else {
			return
		}
//MARK: - Configuration params
		let configuration = URLSessionConfiguration.default
		let session = URLSession(configuration: configuration)
		var urlComponents = URLComponents()
		urlComponents.scheme = "https"
		urlComponents.host = "api.vk.com"
		urlComponents.queryItems = [
			URLQueryItem(name: "access_token", value: token),
			URLQueryItem(name: "v", value: "5.81")
		]
		
		switch scenario {
		case .friends: //configure friend api request
			urlComponents.path = "/method/friends.get"
			urlComponents.queryItems?.append(URLQueryItem(name: "user_id", value: String(userID)))
			urlComponents.queryItems?.append(URLQueryItem(name: "fields", value: "photo_50"))
		case .photos: //configure photo api request
			urlComponents.path = "/method/photos.getAll"
			urlComponents.queryItems?.append(URLQueryItem(name: "user_id", value: String(userID)))
		case .groups: //configure groups request
			urlComponents.path = "/method/groups.get"
			urlComponents.queryItems?.append(URLQueryItem(name: "user_id", value: String(userID)))
			urlComponents.queryItems?.append(URLQueryItem(name: "extended", value: "1"))
		case .searchGroups: //configure group search request
			urlComponents.path = "/method/groups.search"
			urlComponents.queryItems?.append(URLQueryItem(name: "q", value: "Funny"))
			urlComponents.queryItems?.append(URLQueryItem(name: "type", value: "group"))
		}
		
//MARK: - JSON
		let task = session.dataTask(with: urlComponents.url!) { (data, response, error)  in
			guard let data = data,
				  let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.fragmentsAllowed)
			else {
				return
			}
			print(String(describing: json))
		}
		task.resume()
	}
}
