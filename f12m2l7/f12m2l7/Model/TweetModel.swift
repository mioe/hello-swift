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

	static func mock() -> [TweetModel] {
		[
			TweetModel(
				text: "SwiftUI is amazing! Just built my first app with it 🚀",
				createdAt: Date().addingTimeInterval(-3600),
				user: UserModel(username: "swift_dev", avatar: nil),
				images: [],
				likes: 42,
				comments: 5,
				retweets: 12,
				views: 1580
			),
			TweetModel(
				text: "Working on a new open source project. Stay tuned for updates!",
				createdAt: Date().addingTimeInterval(-7200),
				user: UserModel(username: "ios_engineer", avatar: nil),
				images: [],
				likes: 128,
				comments: 23,
				retweets: 34,
				views: 4200
			),
		]
	}
}
