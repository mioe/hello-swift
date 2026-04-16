// by mioe

import UIKit

class CollectionCell: UICollectionViewCell {

	static let cellId = "CollectionCell"

	private var widthConstraint: NSLayoutConstraint?
	
	private lazy var borderBottomView: UIView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.heightAnchor.constraint(equalToConstant: 1).isActive = true
		$0.backgroundColor = .separator
		return $0
	}(UIView())
	
	private lazy var stackContentView: UIStackView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.axis = .vertical
		$0.spacing = 16
		return $0
	}(UIStackView())

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	func setup(tweet: TweetModel, collectionWidth: CGFloat) {
		// удаляем старые subview при переиспользовании ячейки
		contentView.subviews.forEach { $0.removeFromSuperview() }

		// фиксируем ширину ячейки по ширине коллекции
		if widthConstraint == nil {
			widthConstraint = contentView.widthAnchor.constraint(
				equalToConstant: collectionWidth
			)
			widthConstraint?.isActive = true
		}
		widthConstraint?.constant = collectionWidth
		
		let tweetHeader = TweetHeaderView(
			username: tweet.user.username,
			nickname: tweet.user.nickname,
			createdAt: tweet.createdAt,
			visualType: .collection
		)

		let tweetBody = TweetBodyView(
			text: tweet.text,
			media: tweet.media,
			visualType: .collection
		)
		
		let tweetFooter = TweetFooterView(
			comments: tweet.comments,
			retweets: tweet.retweets,
			likes: tweet.likes,
			views: tweet.views,
			bookmarks: tweet.bookmarks,
			visualType: .collection
		)

		stackContentView.addArrangedSubview(tweetHeader)
		stackContentView.addArrangedSubview(tweetBody)
		stackContentView.addArrangedSubview(tweetFooter)
		
		contentView.addSubview(stackContentView)
		contentView.addSubview(borderBottomView)

		NSLayoutConstraint.activate([
			stackContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
			stackContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			stackContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			stackContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
