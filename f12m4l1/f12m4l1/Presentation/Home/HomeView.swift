// by mioe

import SwiftUI

struct HomeView: View {
	@StateObject var viewModel = HomeViewModel()

	var body: some View {
		GeometryReader {
			let safeAreaInsets = $0.safeAreaInsets

			ZStack(alignment: .bottom) {
				VStack(spacing: 0) {
					PullEffectScrollView(
						dragDistance: 130,
						actionTopPadding: safeAreaInsets.top + 32,
						leadingAction: .init(
							symbol: "arrow.clockwise",
							action: { viewModel.reset() }
						),
						centerAction: .init(symbol: "plus", action: { viewModel.add() }),
						trailingAction: .init(
							symbol: "minus",
							action: { viewModel.remove() }
						),
					) {
						VStack(spacing: 0) {
							if !viewModel.idle {
								TaskProgressView(label: $viewModel.actionLabel)
							}
							VStack(spacing: 16) {
								ForEach(viewModel.tweets.reversed(), id: \.id) {
									TweetCardView(tweet: $0)
								}
								if viewModel.tweets.isEmpty && viewModel.idle {
									ZeroTweetView()
								}
							}
							.padding(.vertical, 32)
							.padding(.horizontal, 16)
						}
						.frame(maxWidth: .infinity)
						.animation(.default, value: viewModel.idle)
					}
					.scrollIndicators(.hidden)
					Spacer(minLength: 0)
					FooterView()
				}
				.edgesIgnoringSafeArea(.bottom)
			}
			.onAppear {
				viewModel.setup()
			}
		}
	}

	@ViewBuilder
	private func ZeroTweetView() -> some View {
		HStack {
			Image(systemName: "signpost.right.and.left")
			Text("Пусто...")
				.font(.system(size: 14))
		}
		.foregroundStyle(.secondary)
		.frame(maxWidth: .infinity)
		.padding(.vertical)
	}

	@ViewBuilder
	private func FooterView() -> some View {
		VStack(spacing: 8) {
			Text("Потяни вниз, чтобы изменить состояния (Pull-to-Refresh)")
				.font(.system(size: 12))
			Image(.iTw)
				.resizable()
				.frame(width: 24, height: 20)
		}
		.padding(16)
		.frame(maxWidth: .infinity)
		.background(.secondary.opacity(0.25))
		.clipShape(
			.rect(
				topLeadingCorner: 32,
				topTrailingCorner: 32,
				bottomLeadingCorner: 0,
				bottomTrailingCorner: 0
			)
		)
	}
}
