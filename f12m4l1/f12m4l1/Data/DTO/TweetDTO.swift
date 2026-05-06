// by mioe

import Foundation

// FIX: Call to main actor-isolated static method 'map' in a synchronous nonisolated context
/// https://mioe.app/hono/ref#model/tweet
nonisolated struct TweetDTO: Decodable, Sendable {
	let id: UUID
	let text: String?
	let createdAt: Date
	let media: [String]
	let ref: URL?
	let account: TwitterAccountDTO
	let meta: TweetMetaDTO
}

/// https://mioe.app/hono/ref#model/twitterAccount
nonisolated struct TwitterAccountDTO: Decodable, Sendable {
	let id: UUID
	let nickname: String
	let username: String
	let verify: Bool
	let avatar: URL?
	let ref: URL?
}

/// https://mioe.app/hono/ref#model/tweetMeta
nonisolated struct TweetMetaDTO: Decodable, Sendable {
	let likes: Int
	let comments: Int
	let retweets: Int
	let views: Int
	let bookmarks: Int
}
