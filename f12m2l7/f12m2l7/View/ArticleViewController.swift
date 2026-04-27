// by mioe

// by mioe

import UIKit

class ArticleViewController: UIViewController {
	
	private let tweet: TweetModel
	
	init(tweet: TweetModel) {
		self.tweet = tweet
		super.init(nibName: nil, bundle: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black
		
		title = "ArticleViewController.swift"
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.largeTitleDisplayMode = .never
		navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
		
		let articleHeader = TweetHeaderView(
			tweet.user.username,
			tweet.user.nickname,
			tweet.createdAt,
			.article,
		)
		articleHeader.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		let articleBody = TweetBodyView(
			tweet.text,
			tweet.media,
			.article,
		)
		
		let articleFooter = TweetFooterView(
			comments: tweet.comments,
			retweets: tweet.retweets,
			likes: tweet.likes,
			views: tweet.views,
			bookmarks: tweet.bookmarks,
			visualType: .article,
		)
		
		view.addSubview(articleHeader)
		view.addSubview(articleBody)
		view.addSubview(articleFooter)
		
		NSLayoutConstraint.activate([
			// articleHeader
			articleHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
			articleHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
			articleHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
			
			// articleBody
			articleBody.topAnchor.constraint(equalTo: articleHeader.bottomAnchor, constant: 16),
			articleBody.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
			articleBody.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
			
			// articleFooter
			articleFooter.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
			articleFooter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
			articleFooter.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
