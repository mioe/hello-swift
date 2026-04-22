// by mioe

import SwiftUI

struct TweetFooterView: View {
	let comments: Int
	let retweets: Int
	let likes: Int
	let views: Int
	let bookmarks: Int
	let visualType: TweetVisualType

	private var tintColor: Color {
		visualType == .card ? .secondary : .white
	}

	private var stats: [(icon: String, value: Int)] {
		[
			("message", comments),
			("repeat", retweets),
			("heart", likes),
			("eye", views),
			("bookmark", bookmarks),
		]
	}

	var body: some View {
		HStack(spacing: 0) {
			ForEach(Array(stats.enumerated()), id: \.offset) { index, stat in
				if index > 0 { Spacer(minLength: 0) }
				StatView(icon: stat.icon, value: stat.value)
			}
		}
		.foregroundStyle(tintColor)
	}

	@ViewBuilder
	private func StatView(icon: String, value: Int) -> some View {
		HStack(spacing: 4) {
			Image(systemName: icon)
				.font(.system(size: 12))
			Text("\(value)")
				.font(.system(size: 10))
		}
	}
}
