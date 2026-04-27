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
				createdAt: Date(timeIntervalSince1970: 1_776_816_000),
				user: UserModel(
					username: "もかぽけ@ぽこあポケモン",
					nickname: "pokopokemokapo",
					avatar: nil
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
				createdAt: Date(timeIntervalSince1970: 1_776_816_000),
				user: UserModel(
					username: "MAGIKARP🦈💦",
					nickname: "UniteVids",
					avatar: nil
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
				createdAt: Date(timeIntervalSince1970: 1_776_816_000),
				user: UserModel(
					username: "mymind",
					nickname: "mymind",
					avatar: nil
				),
				// Dictionary не гарантирует порядок!
				media: ["img3", "img4"],
				likes: 476,
				comments: 9,
				retweets: 19,
				views: 20353,
				bookmarks: 0
			),
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
					avatar: nil,
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
					avatar: nil,
				),
				media: ["CharltonN2-img-1"],
				likes: 6654,
				comments: 30,
				retweets: 783,
				views: 182495,
				bookmarks: 686
			),
		]
	}
}
