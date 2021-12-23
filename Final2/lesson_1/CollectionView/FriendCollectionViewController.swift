//
//  FriendCollectionViewController.swift
//  lesson_1
//
//  Created by Vladimir Kobelev on 17.10.2021.
//

import UIKit



class FriendCollectionViewController: UIViewController,
									  UICollectionViewDataSource,
									  UICollectionViewDelegate,
									  UICollectionViewDelegateFlowLayout{
	
	@IBOutlet weak var friendImage: UIImageView!
	@IBOutlet weak var friendName: UILabel!
	@IBOutlet weak var collectionView: UICollectionView!
	
	let identifier = "PhotoViewCell"
	let cellCount = 3.0
	let offsetCells = 2.0
	
	var myFriend: UserModel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.delegate = self
		collectionView.dataSource = self
		friendImage.image = myFriend.uiImage
		friendName.text = myFriend.name
		collectionView.register(UINib(nibName: "PhotoViewCell", bundle: nil),
								forCellWithReuseIdentifier: identifier)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return myFriend.imageArray.count
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
	UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
															for: indexPath) as? PhotoViewCell else {
			return UICollectionViewCell()
		}
		cell.imageViewCell.image = myFriend.imageArray[indexPath.item]
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexpath: IndexPath) -> CGSize {
		
		let frameCV = collectionView.frame
		let cellWidth = frameCV.width / cellCount
		let cellHeight = cellWidth / 3
		let spaceBetweenImage = (cellCount + 1) * offsetCells / cellCount
		
		return CGSize(width: cellWidth - spaceBetweenImage, height: cellHeight - (offsetCells * 2))
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let vc  = storyboard?.instantiateViewController(withIdentifier: "GalleryViewController") as?
				GalleryViewController else {
					return
				}
		vc.photos = myFriend.imageArray
		vc.selectedPhoto = indexPath.item
		self.navigationController?.pushViewController(vc, animated: true)
	}
}

