// by mioe

import Foundation

struct TweetModel {
	let text: String
	let createdAt: Date
	let user: UserModel
	let media: [String]
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
				media: ["img1"],
				likes: 5294,
				comments: 1,
				retweets: 248,
				views: 43256,
				bookmarks: 1436
			),
			TweetModel(
				text: "🌧️ Habitat for Tinkmaster 🌧️",
				createdAt: Date().addingTimeInterval(-36000),
				user: UserModel(
					username: "MAGIKARP🦈💦",
					nickname: "UniteVids",
					avatar: "UniteVids"
				),
				media: ["img2"],
				likes: 2435,
				comments: 4,
				retweets: 174,
				views: 39524,
				bookmarks: 2
			),
			TweetModel(
				text: "Today we're unlocking THE DREAMER 🧡",
				createdAt: Date().addingTimeInterval(-3_600_000),
				user: UserModel(
					username: "mymind",
					nickname: "mymind",
					avatar: "mymind"
				),
				media: ["img3", "img4"],
				likes: 476,
				comments: 9,
				retweets: 19,
				views: 20353,
				bookmarks: 0
			),
		]
	}
}
