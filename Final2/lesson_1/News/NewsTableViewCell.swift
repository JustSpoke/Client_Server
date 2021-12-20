//
//  NewsTableViewCell.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 29.10.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var newsText: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    var collection: [NewsCollectionViewCellModel] = []
    
    
    func configure(with model: NewsTableViewCellModel) {
        userImage.image = model.user.uiImage
        userName.text = model.user.name
        self.newsDate.text = model.newsDate
        newsText.text = model.newsText
        
        updateCell(collection: model.collection)
    }
    
}


extension NewsTableViewCell: UICollectionViewDataSource,
								UICollectionViewDelegate,
								UICollectionViewDelegateFlowLayout {
    
    func updateCell(collection: [NewsCollectionViewCellModel]) {
        self.collection = collection
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collection.count > 5 {
            return 5
        } else {
            return collection.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
						cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell",
															for: indexPath) as? NewsCollectionViewCell else {
			return UICollectionViewCell()
            }
        let collectionCell = collection[indexPath.row]
        cell.configure(with: collectionCell.image)
        
        return cell
    }
	
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
