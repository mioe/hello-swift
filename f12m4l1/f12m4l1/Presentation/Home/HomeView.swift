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
						leadingAction: .init(symbol: "arrow.clockwise", action: { viewModel.reset() }),
						centerAction: .init(symbol: "plus", action: { viewModel.add() }),
						trailingAction: .init(symbol: "minus", action: { viewModel.remove() }),
					) {
						VStack(spacing: 0) {
							if !viewModel.idle {
								TaskProgressView(label: $viewModel.actionLabel)
							}
							VStack(spacing: 16) {
								ForEach(viewModel.tweets.reversed(), id: \.id) { tw in
									Text(tw.text ?? "")
								}
								if viewModel.tweets.isEmpty && viewModel.idle {
									ZeroTweetView()
								}
							}
							.padding(.vertical, 32)
						}
						.frame(maxWidth: .infinity)
						.animation(.default, value: viewModel.idle)
					}
					.scrollIndicators(.hidden)
					Spacer(minLength: 0)
					FooterView()
				}
			}
			.padding(.horizontal, 32)
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
		HStack {
			Text("by mioe")
		}
		.frame(maxWidth: .infinity)
		.background(.red)
	}
}
