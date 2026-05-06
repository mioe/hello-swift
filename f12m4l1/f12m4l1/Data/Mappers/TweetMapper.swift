// by mioe

import Foundation

nonisolated enum TweetMapper {
	static func map(_ dto: TweetDTO) -> Tweet {
		Tweet(
			id: dto.id,
			text: dto.text,
			createdAt: dto.createdAt,
			media: dto.media.compactMap(URL.init(string:)),
			ref: dto.ref,
			account: map(dto.account),
			meta: map(dto.meta)
		)
	}

	static func map(_ dtos: [TweetDTO]) -> [Tweet] {
		dtos.map(map) // FIX: Call to main actor-isolated static method 'map' in a synchronous nonisolated context
	}

	private static func map(_ dto: TwitterAccountDTO) -> TwitterAccount {
		TwitterAccount(
			id: dto.id,
			nickname: dto.nickname,
			username: dto.username,
			verify: dto.verify,
			avatar: dto.avatar,
			ref: dto.ref
		)
	}

	private static func map(_ dto: TweetMetaDTO) -> TweetMeta {
		TweetMeta(
			likes: dto.likes,
			comments: dto.comments,
			retweets: dto.retweets,
			views: dto.views,
			bookmarks: dto.bookmarks
		)
	}
}
