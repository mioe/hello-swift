// by mioe

import Foundation

// FIX: Call to main actor-isolated static method 'map' in a synchronous nonisolated context
nonisolated struct Tweet: Identifiable, Hashable, Sendable {
	let id: UUID
	let text: String?
	let createdAt: Date
	let media: [URL]
	let ref: URL?
	let account: TwitterAccount
	let meta: TweetMeta
}

nonisolated struct TwitterAccount: Identifiable, Hashable, Sendable {
	let id: UUID
	let nickname: String
	let username: String
	let verify: Bool
	let avatar: URL?
	let ref: URL?
}

nonisolated struct TweetMeta: Hashable, Sendable {
	let likes: Int
	let comments: Int
	let retweets: Int
	let views: Int
	let bookmarks: Int
}
