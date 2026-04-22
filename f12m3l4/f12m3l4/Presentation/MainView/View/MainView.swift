// by mioe

import SwiftUI

struct MainView: View {
	@StateObject var viewModel = MainViewModel()  // тика let store = useStore() в pinia

	var body: some View {
		GeometryReader {
			let safeAreaInsets = $0.safeAreaInsets

			NavigationStack {
				PullEffectScrollView(
					dragDistance: 130,
					actionTopPadding: safeAreaInsets.top + 32,
					leadingAction: .init(
						symbol: "arrow.clockwise",
						action: {
							viewModel.reset()
						}
					),
					centerAction: .init(
						symbol: "plus",
						action: {
							print("Refresh")
						}
					),
					trailingAction: .init(
						symbol: "minus",
						action: {
							print("Close Tab")
						}
					)
				) {

					VStack(spacing: 0) {
						if !viewModel.idle {
							MainViewProgressView(label: $viewModel.actionLabel)
						}
						VStack(spacing: 16) {
							ForEach(viewModel.tweets, id: \.id) { tw in
								TweetCardView(
									avatar: tw.user.avatar,
									username: tw.user.username,
									nickname: tw.user.nickname,
									createdAt: tw.createdAt,
									text: tw.text,
									media: tw.media,
									comments: tw.comments,
									retweets: tw.retweets,
									likes: tw.likes,
									views: tw.views,
									bookmarks: tw.bookmarks,
								)
							}
						}
						.padding(.vertical, 32)
					}
					.animation(.default, value: viewModel.idle)
					.padding(.horizontal, 16)
				}
				.navigationBarTitleDisplayMode(.inline)
			}
			.scrollIndicators(.hidden)
			.onAppear {
				viewModel.setup()
			}
		}
	}

	@ViewBuilder
	private func TweetCardView(
		avatar: String?,
		username: String,
		nickname: String,
		createdAt: Date,
		text: String,
		media: [String],
		comments: Int,
		retweets: Int,
		likes: Int,
		views: Int,
		bookmarks: Int,
	) -> some View {
		let type: TweetVisualType = .card

		VStack(spacing: 8) {
			HStack(alignment: .top, spacing: 8) {
				UserAvatarView(avatar: avatar)
				VStack(alignment: .leading, spacing: 8) {
					TweetHeaderView(
						username: username,
						nickname: nickname,
						createdAt: createdAt,
						visualType: type
					)
					TweetBodyView(text: text, media: media, visualType: type)
					TweetFooterView(
						comments: comments,
						retweets: retweets,
						likes: likes,
						views: views,
						bookmarks: bookmarks,
						visualType: type
					)
				}
				.frame(maxWidth: .infinity)
			}
		}
		.padding(.horizontal, 16)
		
		Divider()
	}
}
