//
//  NewsCollectionViewLayout.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 29.10.2021.
//

import UIKit

class NewsCollectionViewLayout: UICollectionViewLayout {
	
	var cacheAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
	var columns = 2
	var cellHeight: CGFloat = 150
	
	private var totalCellHeight: CGFloat = 0
	
	override func prepare() {
		self.cacheAttributes = [:]
		
		guard let collectionView = self.collectionView else { return }
		
		let itemsCount = collectionView.numberOfItems(inSection: 0)
		guard itemsCount > 0 else { return }
		
		let bigCell = collectionView.frame.width
		let smallCell = collectionView.frame.width / CGFloat(self.columns)
		
		var lastX: CGFloat = 0
		var lastY: CGFloat = 0
		
		for index in 0..<itemsCount {
			let indexPath = IndexPath(item: index, section: 0)
			let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
			let isBigCell = (index + 1) % (self.columns + 1) == 0
			
			if isBigCell && itemsCount != 4 {
				attributes.frame = CGRect(x: 0,
										  y: lastY,
										  width: bigCell,
										  height: self.cellHeight)
				lastY += self.cellHeight
				
			} else if itemsCount == 1 {
				attributes.frame = CGRect(x: 0,
										  y: 0,
										  width: bigCell,
										  height: self.collectionView?.frame.height ?? 0)
			} else {
				attributes.frame = CGRect(x: lastX,
										  y: lastY,
										  width: smallCell,
										  height: self.cellHeight)
				
				let isLast = (index + 2) % (self.columns + 1) == 0 || index == itemsCount - 1
				if isLast {
					lastX = 0
					lastY += self.cellHeight
				} else {
					lastX += smallCell
				}
			}
			
			cacheAttributes[indexPath] = attributes
		}
		self.totalCellHeight = lastY
	}
	
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		return cacheAttributes.values.filter { attributes in return rect.intersects(attributes.frame)
			
		}
	}
	
	override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		return cacheAttributes[indexPath]
	}
	
	override var collectionViewContentSize: CGSize {
		return CGSize(width: self.collectionView?.frame.width ?? 0, height: self.totalCellHeight)
	}
}
