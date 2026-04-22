// by mioe

import SwiftUI

struct ArticleView: View {
	let tweet: TweetModel
	
	var body: some View {
		VStack(spacing: 16) {
			TweetHeaderView(
				username: tweet.user.username,
				nickname: tweet.user.nickname,
				createdAt: tweet.createdAt,
				visualType: .article
			)
			.frame(height: 20) // как в UIKit версии
			
			TweetBodyView(
				text: tweet.text,
				media: tweet.media,
				visualType: .article
			)
			
			Spacer()
			
			TweetFooterView(
				comments: tweet.comments,
				retweets: tweet.retweets,
				likes: tweet.likes,
				views: tweet.views,
				bookmarks: tweet.bookmarks,
				visualType: .article
			)
		}
		.padding(.horizontal, 32)
		.padding(.bottom, 16)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.black)
	}
}
