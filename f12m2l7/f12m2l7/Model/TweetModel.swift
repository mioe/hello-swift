// by mioe

import Foundation

struct TweetModel {
	let text: String
	let createdAt: Date
	let user: UserModel
	let media: [String: TweetMediaType]
	let likes: Int
	let comments: Int
	let retweets: Int
	let views: Int
	let bookmars: Int

	static func mock() -> [TweetModel] {
		[
			TweetModel(
				text: "ちょうど船のハンドル売ってて、キッチンカーの運転席にいいじゃんって思って置いたら、さっそくシャワーズが運転してくれててうれしかった(見えにくいけどw)",
				createdAt: Date().addingTimeInterval(-3600),
				user: UserModel(
					username: "もかぽけ@ぽこあポケモン",
					nickname: "pokopokemokapo",
					avatar: "pokopokemokapo",
				),
				media: ["img1": .image],
				likes: 5294,
				comments: 1,
				retweets: 248,
				views: 43256,
				bookmars: 1436
			),
		]
	}
}
