// by mioe

import UIKit

class TweetCell: UITableViewCell {

	private(set) var tweetBodyView: TweetBodyView?

	private lazy var wrapperView: UIView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		return $0
	}(UIView())

	private lazy var bottomBorder: UIView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.heightAnchor.constraint(equalToConstant: 1).isActive = true
		$0.backgroundColor = UIColor.separator
		return $0
	}(UIView())
	
	private lazy var avatar: UIImageView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.widthAnchor.constraint(equalToConstant: 48).isActive = true
		$0.heightAnchor.constraint(equalToConstant: 48).isActive = true
		$0.layer.cornerRadius = 24
		$0.clipsToBounds = true
		return $0
	}(UIImageView())
	
	private lazy var stack: UIStackView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.axis = .vertical
		$0.spacing = 8
		return $0
	}(UIStackView())
	
	private var isLayoutSetup = false

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		tweetBodyView?.pause()
		tweetBodyView = nil
		stack.arrangedSubviews.forEach {
			stack.removeArrangedSubview($0)
			$0.removeFromSuperview()
		}
	}

	func setup(tweet: TweetModel) {
		if !isLayoutSetup {
			isLayoutSetup = true

			self.contentView.addSubview(wrapperView)
			wrapperView.addSubview(avatar)
			wrapperView.addSubview(stack)
			wrapperView.addSubview(bottomBorder)

			NSLayoutConstraint.activate([
				// wrapperView
				wrapperView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
				wrapperView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
				wrapperView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
				wrapperView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),

				// avatar
				avatar.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 0),
				avatar.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 16),

				// stack
				stack.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 0),
				stack.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 8),
				stack.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -16),
				stack.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: 0),

				// bottomBorder
				bottomBorder.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: 16),
				bottomBorder.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 0),
				bottomBorder.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: 0),
			])
		}

		// init data
		avatar.image = UIImage(named: tweet.user.avatar ?? "img1")
		let tweetHeader = TweetHeaderView(
			tweet.user.username,
			tweet.user.nickname,
			tweet.createdAt,
		)
		let tweetBody = TweetBodyView(
			tweet.text,
			tweet.media,
			.card,
		)
		self.tweetBodyView = tweetBody
		let tweetFooter = TweetFooterView(
			comments: tweet.comments,
			retweets: tweet.retweets,
			likes: tweet.likes,
			views: tweet.views,
			bookmarks: tweet.bookmarks,
		)

		stack.addArrangedSubview(tweetHeader)
		stack.addArrangedSubview(tweetBody)
		stack.addArrangedSubview(tweetFooter)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

