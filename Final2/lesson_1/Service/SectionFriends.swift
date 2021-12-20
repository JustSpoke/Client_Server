//
//  SectionFriends.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 29.10.2021.
//

import UIKit

struct SectionFriends: Comparable {
    var key: Character
    var data: [UserModel]
    
    static func < (lhs: SectionFriends, rhs: SectionFriends) -> Bool {
        return lhs.key < rhs.key
    }
    
    static func == (lhs: SectionFriends, rhs: SectionFriends) -> Bool {
        return lhs.key == rhs.key
    }
}
