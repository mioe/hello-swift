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
		$0.spacing = 8
		return $0
	}(UIStackView())

	private lazy var avatarView: UIImageView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.widthAnchor.constraint(equalToConstant: 48).isActive = true
		$0.heightAnchor.constraint(equalToConstant: 48).isActive = true
		$0.layer.cornerRadius = 24
		$0.clipsToBounds = true
		return $0
	}(UIImageView())

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

		avatarView.image = UIImage(named: tweet.user.avatar)

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

		stackContentView.arrangedSubviews.forEach { $0.removeFromSuperview() }
		stackContentView.addArrangedSubview(tweetHeader)
		stackContentView.addArrangedSubview(tweetBody)
		stackContentView.addArrangedSubview(tweetFooter)

		contentView.addSubview(avatarView)
		contentView.addSubview(stackContentView)
		contentView.addSubview(borderBottomView)

		NSLayoutConstraint.activate([
			avatarView.topAnchor.constraint(
				equalTo: contentView.topAnchor,
				constant: 12
			),
			avatarView.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: 32
			),

			stackContentView.topAnchor.constraint(equalTo: avatarView.topAnchor),
			stackContentView.leadingAnchor.constraint(
				equalTo: avatarView.trailingAnchor,
				constant: 8
			),
			stackContentView.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -32
			),
			stackContentView.bottomAnchor.constraint(
				equalTo: contentView.bottomAnchor
			),

			borderBottomView.topAnchor.constraint(
				equalTo: stackContentView.bottomAnchor,
				constant: 12
			),
			borderBottomView.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: 16
			),
			borderBottomView.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -16
			),
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
