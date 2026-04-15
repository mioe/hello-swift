// by mioe

import Foundation

struct TweetModel {
	let text: String
	let createdAt: Date
	let user: UserModel
	let images: [String]
	let likes: Int
	let comments: Int
	let retweets: Int
	let views: Int
	let bookmarks: Int
	
	static func mock() -> [TweetModel] {
		[
			TweetModel(
				text:
					"ちょうど船のハンドル売ってて、キッチンカーの運転席にいいじゃんって思って置いたら、さっそくシャワーズが運転してくれててうれしかった(見えにくいけどw)",
				createdAt: Date().addingTimeInterval(-3600),
				user: UserModel(
					username: "もかぽけ@ぽこあポケモン",
					nickname: "pokopokemokapo",
					avatar: "pokopokemokapo",
				),
				images: ["img1"],
				likes: 5294,
				comments: 1,
				retweets: 248,
				views: 43256,
				bookmarks: 1436
			),
		]
	}
}
