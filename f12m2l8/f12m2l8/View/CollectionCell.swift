// by mioe

import UIKit

class CollectionCell: UICollectionViewCell {

	static let cellId = "CollectionCell"

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.layer.cornerRadius = 28
		self.layer.borderColor = UIColor.systemGray4.cgColor
		self.layer.borderWidth = 0.5
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
		
		lazy var tweetBodyView: UIView = {
			let hBody: CGFloat = 100
			$0.frame = CGRect(x: 0, y: bounds.height - hBody, width: bounds.width, height: hBody)
			$0.layer.cornerRadius = 28
			$0.backgroundColor = .systemBackground
			
			lazy var textView: UILabel = {
				$0.translatesAutoresizingMaskIntoConstraints = false
				$0.font = .systemFont(ofSize: 12)
				$0.numberOfLines = 3
				return $0
			}(UILabel())
			textView.text = tweet.text
			
			lazy var btnMore: UIButton = {
				$0.translatesAutoresizingMaskIntoConstraints = false
				$0.setTitle("Подробнее", for: .normal)
				$0.setTitleColor(.white, for: .normal)
				$0.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
				$0.backgroundColor = .systemBlue
				$0.heightAnchor.constraint(equalToConstant: 24).isActive = true
				$0.layer.cornerRadius = 12
				return $0
			}(UIButton(primaryAction: UIAction { [weak self] _ in
				self?.navigationController?.pushViewController(
					ArticleViewController(tweet: tweet),
					animated: true
				)
			}))
			
			$0.addSubview(textView)
			$0.addSubview(btnMore)
			
			NSLayoutConstraint.activate([
				// textView
				textView.topAnchor.constraint(equalTo: $0.topAnchor, constant: 12),
				textView.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 16),
				textView.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: -16),
				
				// btnMore
				btnMore.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: -12),
				btnMore.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: -16),
				btnMore.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 16),
			])
			
			return $0
		}(UIView())
		
		self.addSubview(previewImageView)
		self.addSubview(tweetHeader)
		self.addSubview(tweetBodyView)
		
		NSLayoutConstraint.activate([
			// tweetHeader
			tweetHeader.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
			tweetHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
			tweetHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
			
			// btnMore
			tweetBodyView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
			tweetBodyView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
