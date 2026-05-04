// by mioe

import SwiftUI

struct HomeView: View {

	@Environment(ThemeStore.self) private var theme

	private let articles: [Article] = Article.mock()

	var body: some View {
		@Bindable var theme = theme

		ZStack(alignment: .top) {
			theme.background.ignoresSafeArea()

			VStack(spacing: 0) {
				StickyHeaderView(onTapTheme: { t in
					theme.current = t
				})

				ScrollView {
					VStack(spacing: 32) {
						VStack(spacing: 24) {
							ArticleCarouselView()
							BalanceView()
							FooterView()
						}
					}
				}
				.scrollClipDisabled()
				.scrollIndicators(.hidden)
				.padding(.top, 16)
				.padding(.horizontal, 16)
				.padding(.bottom, 24)
			}
		}
	}

	@ViewBuilder
	private func StickyHeaderView(
		onTapTheme: @escaping (ThemeStore.Theme) -> Void
	) -> some View {
		let bandeTextColor =
			theme.current == .youtube
			? .white
			: theme.current == .hacker
				? .hackerBackgroundForeground
				: theme.primary

		HStack {
			Button {
				print("onTap: neo")
			} label: {
				HStack {
					Image(.neoX2)
						.resizable()
						.scaledToFill()
						.frame(width: 34, height: 34)
						.clipShape(.circle)
				}
				.frame(width: 42, height: 42)
				.background(theme.accent.opacity(0.3))
				.clipShape(.circle)
				.overlay {
					Circle()
						.strokeBorder(theme.accent, lineWidth: 2)
				}
				VStack(alignment: .leading, spacing: 0) {
					Text("Vip")
						.font(.system(size: 8, weight: .black))
						.textCase(.uppercase)
						.padding(.vertical, 3)
						.padding(.horizontal, 5)
						.background(theme.accent.opacity(0.3))
						.clipShape(.capsule)
						.overlay {
							Capsule()
								.strokeBorder(theme.accent, lineWidth: 2)
						}
					HStack(spacing: 0) {
						Text("User01")
							.font(.system(size: 20, weight: .semibold))
						Image(.iChevronRight)
							.resizable()
							.scaledToFill()
							.frame(width: 20, height: 20)
					}
				}
				.foregroundStyle(theme.primary)
			}
			.buttonStyle(.plain)

			Spacer()

			HStack {
				Menu {
					ForEach(ThemeStore.Theme.allCases) { t in
						Button {
							onTapTheme(t)
						} label: {
							Text(t.title)
						}
					}
				} label: {
					HStack {
						Image(systemName: "swatchpalette.fill")
							.font(.system(size: 18))
							.symbolRenderingMode(.hierarchical)
							.foregroundStyle(theme.accent)
					}
					.frame(width: 40, height: 40)
					.clipShape(.circle)
				}

				Button {
					print("onTap: bell")
				} label: {
					HStack {
						Image(.iBell)
							.resizable()
							.scaledToFill()
							.frame(width: 24, height: 24)
							.foregroundStyle(theme.accent)
					}
					.badge(
						5,
						bgColor: theme.accent,
						textColor: bandeTextColor,
					)
				}
				.frame(width: 40, height: 40)
				.clipShape(.rect)
				.buttonStyle(.plain)
			}
		}
		.frame(maxWidth: .infinity)
		.padding(.vertical, 8)
		.padding(.horizontal, 16)
		.background(theme.backgroundForeground)
		.zIndex(1)
	}

	@ViewBuilder
	private func ArticleCarouselView() -> some View {
		ScrollView(.horizontal) {
			HStack(spacing: 8) {
				ForEach(articles, id: \.id) { a in
					ArticleCardView(
						article: a,
						accentColor: theme.accent,
					)
				}
			}
		}
		.scrollClipDisabled()
		.scrollIndicators(.hidden)
	}

	@ViewBuilder
	private func BalanceView() -> some View {
		VStack(spacing: 24) {
			BalanceCardView(
				textPrimaryColor: theme.primary,
				textSecondaryColor: theme.secondary,
				bgColor: theme.background,
				bgForegroundColor: theme.backgroundForeground
			)
		}
	}

	@ViewBuilder
	private func FooterView() -> some View {
		DefaultButtonView(
			onTap: { print("onTap: all market") },
			bgColor: theme.accent
		) {
			Text("All Market")
				.font(.system(size: 16, weight: .medium))
				.foregroundStyle(theme.background)
		}
	}
}
