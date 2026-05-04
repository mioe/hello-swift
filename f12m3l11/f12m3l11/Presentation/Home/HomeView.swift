// by mioe

import SwiftUI

struct HomeView: View {

	@Environment(ThemeStore.self) private var theme

	var body: some View {
		@Bindable var theme = theme

		ZStack(alignment: .top) {
			theme.background.ignoresSafeArea()

			VStack(spacing: 0) {
				StickyHeaderView(onTapTheme: { t in
					theme.current = t
				})

				ScrollView {
					VStack(spacing: 24) {

					}
				}
				.scrollClipDisabled()
				.scrollIndicators(.hidden)
				.padding(32)
			}
		}
	}

	@ViewBuilder
	private func StickyHeaderView(
		onTapTheme: @escaping (ThemeStore.Theme) -> Void
	) -> some View {
		HStack {
			Button {
				print("onTap: neo")
			} label: {
				HStack {
					Image(.neoX2)
						.resizable()
						.scaledToFill()
						.frame(width: 38, height: 38)
						.clipShape(.circle)
				}
				.frame(width: 42, height: 42)
				.background(theme.accent.opacity(0.3))
				.clipShape(.circle)
				.overlay {
					Circle()
						.stroke(theme.accent, lineWidth: 2)
				}
				VStack(alignment: .leading, spacing: 0) {
					Text("Vip")
						.font(.system(size: 8, weight: .black))
						.textCase(.uppercase)
						.padding(.vertical, 4)
						.padding(.horizontal, 5)
						.background(theme.accent.opacity(0.3))
						.clipShape(.capsule)
						.overlay {
							Capsule()
								.stroke(theme.accent, lineWidth: 2)
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
						textColor: theme.current == .youtube ? .white : theme.primary
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
}
