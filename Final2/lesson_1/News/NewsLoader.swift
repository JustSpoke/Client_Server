//
//  NewsLoader.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 29.10.2021.
//

import UIKit

class NewsLoader {
    static func newsFeed() -> [NewsTableViewCellModel] {
        return [NewsTableViewCellModel(user: UserModel(name:"Zoe",
													   image: "13",
													   imageArray: []),
									   newsDate: "15.01.2021",
									   newsText: "здесь могла быть Ваша реклама",
									   newsImagesNames: ["1", "24", "31", "23", "29"]),
                NewsTableViewCellModel(user: UserModel(name:"Zoe",
													   image: "13",
													   imageArray: []),
									   newsDate: "15.01.2021",
									   newsText: "Здесь могла быть Ваша реклама",
									   newsImagesNames: ["1", "24", "31", "23", "29"])
        ]
    }
}
