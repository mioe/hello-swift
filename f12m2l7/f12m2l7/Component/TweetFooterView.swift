// by mioe

import UIKit

class TweetFooterView: UIView {
	
	private let comments: Int
	private let retweets: Int
	private let likes: Int
	private let views: Int
	private let bookmarks: Int
	
	init(comments: Int, retweets: Int, likes: Int, views: Int, bookmarks: Int) {
		self.comments = comments
		self.retweets = retweets
		self.likes = likes
		self.views = views
		self.bookmarks = bookmarks
		super.init(frame: .zero)
		self.setup()
	}
	
	private func setup() {
		self.translatesAutoresizingMaskIntoConstraints = false
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
