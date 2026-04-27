// by mioe

import UIKit

class TweetFooterView: UIView {

	private let comments: Int
	private let retweets: Int
	private let likes: Int
	private let views: Int
	private let bookmarks: Int
	private let visualType: TweetVisualType

	init(comments: Int, retweets: Int, likes: Int, views: Int, bookmarks: Int, visualType: TweetVisualType) {
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

		let stackView: UIStackView = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.axis = .horizontal
			$0.spacing = 0
			$0.distribution = .equalSpacing  // css justify-content: between
			return $0
		}(UIStackView())

		// Dictionary["message": comments, ..:..] не гарантирует порядок!
		[
			("message", comments), ("repeat", retweets), ("heart", likes), ("eye", views),
			("bookmark", bookmarks),
		]
		.forEach { (key, value) in
			let view: UIStackView = {
				$0.translatesAutoresizingMaskIntoConstraints = false
				$0.axis = .horizontal
				$0.spacing = 4

				let icon: UIImageView = {
					$0.translatesAutoresizingMaskIntoConstraints = false
					$0.tintColor = visualType == .card ? .systemGray : .white
					return $0
				}(UIImageView())
				icon.image = UIImage(
					systemName: key,
					withConfiguration: UIImage.SymbolConfiguration(
						font: .systemFont(ofSize: 12)
					)
				)

				let counter: UILabel = {
					$0.translatesAutoresizingMaskIntoConstraints = false
					$0.font = .systemFont(ofSize: 10)
					$0.textColor = visualType == .card ? .systemGray : .white
					return $0
				}(UILabel())
				counter.text = "\(value)"

				$0.addArrangedSubview(icon)
				$0.addArrangedSubview(counter)

				return $0
			}(UIStackView())

			stackView.addArrangedSubview(view)
		}

		self.addSubview(stackView)

		NSLayoutConstraint.activate([
			// stackView
			stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
			stackView.leadingAnchor.constraint(
				equalTo: self.leadingAnchor,
				constant: 0
			),
			stackView.trailingAnchor.constraint(
				equalTo: self.trailingAnchor,
				constant: 0
			),
			stackView.bottomAnchor.constraint(
				equalTo: self.bottomAnchor,
				constant: 0
			),
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
