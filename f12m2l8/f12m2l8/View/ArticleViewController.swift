// by mioe

import UIKit

class ArticleViewController: UIViewController {

	private let tweet: TweetModel

	init(tweet: TweetModel) {
		self.tweet = tweet
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black
		
		title = "ArticleViewController.swift"
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.largeTitleDisplayMode = .never
		navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
		
		let articleHeader = TweetHeaderView(
			avatar: tweet.user.avatar,
			username: tweet.user.username,
			nickname: tweet.user.nickname,
			createdAt: tweet.createdAt,
			visualType: .article,
		)
		
		let imageView: UIImageView = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			return $0
		}(UIImageView())
		imageView.image = UIImage(named: tweet.media.first?.precomposedStringWithCompatibilityMapping ?? "")
		
		if let image = imageView.image {
			let aspectRatio = image.size.height / image.size.width
			let c = imageView.heightAnchor.constraint(
				equalTo: imageView.widthAnchor,
				multiplier: aspectRatio
			)
			c.isActive = true
		}
		
		let textView: UILabel = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.numberOfLines = 0
			$0.textColor = .white
			return $0
		}(UILabel())
		textView.text = tweet.text

		view.addSubview(articleHeader)
		view.addSubview(imageView)
		view.addSubview(textView)
		
		NSLayoutConstraint.activate([
			// articleHeader
			articleHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
			articleHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			articleHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			
			// imageView
			imageView.topAnchor.constraint(equalTo: articleHeader.bottomAnchor, constant: 16),
			imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
			imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0),
			
			// textView
			textView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
			textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
		])
	}
}
