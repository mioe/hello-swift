// by mioe

import SwiftUI

struct TweetCardView: View {

	let tweet: Tweet

	private var stats: [(icon: String, value: Int)] {
		[
			("message", tweet.meta.comments),
			("repeat", tweet.meta.retweets),
			("heart", tweet.meta.likes),
			("bookmark", tweet.meta.bookmarks),
		]
	}

	var body: some View {
		VStack(spacing: 16) {
			HStack(alignment: .top) {
				AvatarView()
				VStack(alignment: .leading, spacing: 8) {
					HeaderView()
					BodyView()
					FooterView()
				}
				.frame(maxWidth: .infinity, alignment: .leading)
			}
			.padding(.horizontal, 16)

			Rectangle()
				.fill(.secondary.opacity(0.25))
				.frame(height: 1)
				.frame(maxWidth: .infinity)
		}
	}

	@ViewBuilder
	private func AvatarView() -> some View {
		let size: CGFloat = 48

		if tweet.account.avatar != nil {
			AsyncImage(url: tweet.account.avatar) {
				$0
					.resizable()
					.scaledToFill()
			} placeholder: {
				ProgressView()
			}
			.frame(width: size, height: size)
			.background(.secondary.opacity(0.25))
			.clipShape(.circle)
		} else {
			HStack {
				Image(systemName: "person.fill")
					.font(.system(size: 24))
			}
			.frame(width: size, height: size)
			.background(.secondary.opacity(0.25))
			.clipShape(.circle)
		}
	}

	@ViewBuilder
	private func HeaderView() -> some View {
		HStack(spacing: 4) {
			HStack(spacing: 2) {
				Text(tweet.account.username)
				if tweet.account.verify == true {
					VerifyBadgeView()
				}
			}
			Text(tweet.account.nickname)
				.foregroundStyle(.secondary)
		}
		.font(.system(size: 12))
	}

	@ViewBuilder
	private func MediaStackView() -> some View {
		VStackLayout(spacing: 4) {
			ForEach(tweet.media, id: \.self) { url in
				AsyncImage(url: url) {
					$0
						.resizable()
						.aspectRatio(contentMode: .fit)
				} placeholder: {
					ProgressView()
				}
				.frame(minHeight: 100)
				.frame(maxWidth: .infinity)
				.background(.secondary.opacity(0.25))
			}
		}
		.frame(maxWidth: .infinity)
		.clipShape(.rect(cornerRadius: 16))
	}

	@ViewBuilder
	private func BodyView() -> some View {
		VStack(spacing: 8) {
			if tweet.text != nil {
				Text(tweet.text!)
					.font(.system(size: 12))
					.multilineTextAlignment(.leading)
					.frame(maxWidth: .infinity, alignment: .leading)
			}
			if tweet.media.count > 0 {
				MediaStackView()
			}
		}
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

	@ViewBuilder
	private func FooterView() -> some View {
		VStack(alignment: .leading, spacing: 8) {
			HStack(spacing: 4) {
				Text(tweet.createdAt, format: .dateTime.hour().minute())
				Text("·")
				Text(tweet.createdAt, format: .dateTime.day().month(.twoDigits).year())
				Text("·")
				Text(tweet.meta.views, format: .number.notation(.compactName))
					.foregroundStyle(.primary)
				Text("Views")
			}
			.font(.system(size: 12))
			.foregroundStyle(.secondary)
			HStack(spacing: 0) {
				ForEach(Array(stats.enumerated()), id: \.offset) { index, stat in
					if index > 0 { Spacer(minLength: 0) }
					StatView(icon: stat.icon, value: stat.value)
				}
				if tweet.ref != nil {
					Spacer(minLength: 0)
					Link(destination: tweet.ref!) {
						Image(systemName: "square.and.arrow.up")
							.font(.system(size: 12))
							.foregroundStyle(.blue)
					}
				}
			}
			.foregroundStyle(.secondary)
		}
		.frame(maxWidth: .infinity)
	}
}
