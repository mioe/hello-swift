// by mioe

import UIKit

class TweetFooterView: UIView {

	private let comments: Int
	private let retweets: Int
	private let likes: Int
	private let views: Int
	private let bookmarks: Int
	private let visualType: TweetVisualType

	init(
		comments: Int,
		retweets: Int,
		likes: Int,
		views: Int,
		bookmarks: Int,
		visualType: TweetVisualType
	) {
		self.comments = comments
		self.retweets = retweets
		self.likes = likes
		self.views = views
		self.bookmarks = bookmarks
		self.visualType = visualType
		super.init(frame: .zero)
		self.setup()
	}

	private func setup() {
		self.translatesAutoresizingMaskIntoConstraints = false

		let flexRowView: UIStackView = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.axis = .horizontal
			$0.spacing = 0
			$0.distribution = .equalSpacing  // css justify-content: between
			return $0
		}(UIStackView())

		[
			("message", comments), ("repeat", retweets), ("heart", likes),
			("eye", views),
			("bookmark", bookmarks),
		]
		.forEach { (key, value) in
			let stackStatView: UIStackView = {
				$0.translatesAutoresizingMaskIntoConstraints = false
				$0.axis = .horizontal
				$0.spacing = 4
				return $0
			}(UIStackView())

			let imageView: UIImageView = {
				$0.translatesAutoresizingMaskIntoConstraints = false
				$0.tintColor = visualType == .collection ? .systemGray : .white
				return $0
			}(UIImageView())

			imageView.image = UIImage(
				systemName: key,
				withConfiguration: UIImage.SymbolConfiguration(
					font: .systemFont(ofSize: 12)
				)
			)

			let counterView: UILabel = {
				$0.translatesAutoresizingMaskIntoConstraints = false
				$0.font = .systemFont(ofSize: 10)
				$0.textColor = visualType == .collection ? .systemGray : .white
				return $0
			}(UILabel())
			counterView.text = "\(value)"

			stackStatView.addArrangedSubview(imageView)
			stackStatView.addArrangedSubview(counterView)
			flexRowView.addArrangedSubview(stackStatView)
		}

		self.addSubview(flexRowView)

		NSLayoutConstraint.activate([
			flexRowView.topAnchor.constraint(equalTo: self.topAnchor),
			flexRowView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			flexRowView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			flexRowView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
