// by mioe

import UIKit

class CollectionCell: UICollectionViewCell {
	
	static let cellId = "CollectionCell"
	
	// по дефолту 50x50 размеры frame
	override init(frame: CGRect) {
		super.init(frame: frame)
		print(frame)
	}
	
	func setup(tweet: TweetModel) {
		let tweetBody = TweetBodyView(
			text: tweet.text,
			media: tweet.media,
			visualType: .collection
		)
		
		self.addSubview(tweetBody)
		
		NSLayoutConstraint.activate([
			self.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
			self.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
			self.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
			
			// tweetBody
			tweetBody.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
			tweetBody.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
			tweetBody.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
