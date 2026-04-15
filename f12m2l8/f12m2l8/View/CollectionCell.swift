// by mioe

import UIKit

class CollectionCell: UICollectionViewCell {

	static let cellId = "CollectionCell"

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.layer.cornerRadius = 28
		self.clipsToBounds = true
	}

	func setup(tweet: TweetModel) {
		let tweetHeader = TweetHeaderView(
			avatar: tweet.user.avatar,
			username: tweet.user.username,
			nickname: tweet.user.nickname,
			createdAt: tweet.createdAt,
			visualType: .collection
		)
		
		lazy var previewImageView: UIImageView = {
			$0.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height) // bounds контейнер UICollection
			$0.contentMode = .scaleAspectFill
			$0.clipsToBounds = true
			$0.backgroundColor = .systemGray5
			return $0
		}(UIImageView())
		previewImageView.image = UIImage(named: tweet.media.first?.precomposedStringWithCompatibilityMapping ?? "")
		
		lazy var btnMore: UIButton = {
			$0.frame = CGRect(x: bounds.width / 2 - 40, y: bounds.height - 32, width: 80, height: 24)
			$0.setTitle("more...", for: .normal)
			$0.setTitleColor(.white, for: .normal)
			$0.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
			$0.backgroundColor = .systemBlue
			$0.layer.cornerRadius = 12
			return $0
		}(UIButton())

		self.addSubview(previewImageView)
		self.addSubview(tweetHeader)
		self.addSubview(btnMore)
		
		NSLayoutConstraint.activate([
			// tweetHeader
			tweetHeader.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
			tweetHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
			tweetHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
			
			// btnMore
			btnMore.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
			btnMore.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
