// by mioe

import Foundation

class NetworkManager {
	func getTweetsApi(count: Int, chunk: Int) -> [TweetModel] {
		let allTweets: [TweetModel] =
			TweetModel.mock() + [
				TweetModel(
					text:
						"""
						GPT image2（Thinking）で、誰でも簡単にこんな感じのデザインシステムボードを作れるように！
						これをClaude Designに食べさせたら、うまくいくかも。プロンプトは下に置いておきます😊
						""",
					createdAt: Date(timeIntervalSince1970: 1_776_816_000),
					user: UserModel(
						username: "ミヤマ",
						nickname: "mmmiyama_D",
						avatar: "mmmiyama_D",
					),
					media: ["mmmiyama_D-img-2", "mmmiyama_D-img-1"],
					likes: 1284,
					comments: 2,
					retweets: 109,
					views: 1324,
					bookmarks: 2
				),

				TweetModel(
					text:
						"""
						Splatoon is so funny in that it’ll get its playerbase to seriously consider putting jars, cables, plastic forks, rubber duckies and clothing hangers in their hair to look cool. I love it so much
						""",
					createdAt: Date(timeIntervalSince1970: 1_776_816_000),
					user: UserModel(
						username: "Charlton!",
						nickname: "CharltonN2",
						avatar: "CharltonN2",
					),
					media: ["CharltonN2-img-1"],
					likes: 6654,
					comments: 30,
					retweets: 783,
					views: 182495,
					bookmarks: 686
				),
			]

		guard count < allTweets.count else {
			return [
				TweetModel(
					text: "Callback #\(count)",
					createdAt: Date(timeIntervalSince1970: 1_776_816_000),
					user: UserModel(
						username: "duckduckduck 🐥🐥🐣",
						nickname: "duck",
						avatar: nil,
					),
					media: [],
					likes: 0,
					comments: 0,
					retweets: 0,
					views: 0,
					bookmarks: 0
				)
			]
		}
		let end = min(count + chunk, allTweets.count)
		return Array(allTweets[count..<end])
	}
}
