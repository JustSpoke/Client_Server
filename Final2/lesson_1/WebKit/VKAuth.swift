//
//  VKAuth.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 17.11.2021.
//

import UIKit
import WebKit

class VKAuth: UIViewController {
	
	let session = Session.instance
	
	@IBOutlet weak var webView: WKWebView!{
		didSet {
			webView.navigationDelegate = self
		}
	}
	
	let service: ServiceManagerProtocol = URLServices()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		webView.load(service.loadRequests())
		service.loadData(scenario: .friends)
		service.loadData(scenario: .photos)
		service.loadData(scenario: .groups)
		service.loadData(scenario: .searchGroups)
	}
}

extension VKAuth: WKNavigationDelegate {
	func webView(_ webView: WKWebView,
				 decidePolicyFor navigationResponse: WKNavigationResponse,
				 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
		guard
			let url = navigationResponse.response.url,
			url.path == "/blank.html",
			let fragment = url.fragment
		else {
				decisionHandler(.allow)
				return
			}
		let params = fragment
			.components(separatedBy: "&")
			.map { $0.components(separatedBy: "=")}
			.reduce ([String: String]()) { result, param in
				var dict = result
				let key = param[0]
				let value = param[1]
				dict[key] = value
				return dict
			}
		
		//MARK: Segue to TabBar
		if let token = params["access_token"] {
			session.token = token
			
			print(token)
			
			decisionHandler(.cancel)
			performSegue(withIdentifier: "loginPass", sender: nil)
		}
	}
}
