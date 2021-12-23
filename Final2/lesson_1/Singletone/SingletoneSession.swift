//
//  SingletoneSession.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 12.11.2021.
//

import UIKit

class Session {
	static let instance = Session()
	
	private init() {}
	
	var token: String? = "3c89461bddace463026848b1f3255e7099cf3fed58bbaadb4d263301cd3e271545eb5897f7c1d177b4757"
	var userId: Int? = 59188903
}
