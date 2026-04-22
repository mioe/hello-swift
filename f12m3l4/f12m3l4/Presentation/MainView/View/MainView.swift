// by mioe

import SwiftUI

struct MainView: View {
	@StateObject var viewModel = MainViewModel()  // тика let store = useStore() в pinia
	@State private var navigationPath = NavigationPath()

	var body: some View {
		GeometryReader {
			let safeAreaInsets = $0.safeAreaInsets

			ZStack(alignment: .bottom) {
				NavigationStack(path: $navigationPath) {
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
								viewModel.add()
							}
						),
						trailingAction: .init(
							symbol: "minus",
							action: {
								viewModel.remove()
							}
						)
					) {

						VStack(spacing: 0) {
							if !viewModel.idle {
								MainViewProgressView(label: $viewModel.actionLabel)
							}
							VStack(spacing: 16) {
								ForEach(viewModel.tweets.reversed(), id: \.id) { tw in
									NavigationLink(value: tw) {
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
									.buttonStyle(.plain)
								}
								if viewModel.tweets.isEmpty && viewModel.idle {
									HStack {
										Image(systemName: "signpost.right.and.left")
										Text("Пусто...")
									}
									.frame(maxWidth: .infinity)
								}
							}
							.padding(.vertical, 32)
						}
						.animation(.default, value: viewModel.idle)
						.padding(.horizontal, 16)
					}
					.navigationBarTitleDisplayMode(.inline)
					.navigationDestination(for: TweetModel.self) { tweet in
						ArticleView(tweet: tweet)
					}
				}
				.scrollIndicators(.hidden)
				.onAppear {
					viewModel.setup()
				}

				VStack(spacing: 16) {
					Divider()
					HStack {
						Image(systemName: "info.circle")
						Text("Потяни вниз, чтобы изменить состояния (Pull-to-Refresh)")
							.font(.system(size: 10))
					}
					.padding(.horizontal, 32)
				}
				.frame(maxWidth: .infinity)
				.background(.background)
				.offset(y: navigationPath.isEmpty ? 0 : 100)
				.animation(.easeInOut, value: navigationPath.isEmpty)
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
