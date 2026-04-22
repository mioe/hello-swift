// by mioe

import Foundation

class NetworkManager {
	func getTweetsApi(count: Int, chunk: Int) -> [TweetModel] {
		var cache = TweetModel.mock()
		
		var newData: [TweetModel] = [
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
		]

		return newData + cache
	}
}
