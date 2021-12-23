//
//  NewsTableViewCellModel.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 29.10.2021.
//

import UIKit

struct NewsTableViewCellModel {
    var user: UserModel
    var newsDate: String
    var newsText: String
    var newsImagesNames: [String]
    var collection: [NewsCollectionViewCellModel] = []
    
    init(user: UserModel, newsDate: String, newsText: String, newsImagesNames: [String]) {
        self.user = user
        self.newsDate = newsDate
        self.newsText = newsText
        self.newsImagesNames = newsImagesNames
        
        for images in newsImagesNames {
            guard let photo = UIImage(named: images) else {
				continue
			}
            self.collection.append(NewsCollectionViewCellModel(image: photo))
        }
    }
}
