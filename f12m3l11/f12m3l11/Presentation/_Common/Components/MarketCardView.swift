// by mioe

import SwiftUI

struct MarketCardView: View {

	@Environment(ThemeStore.self) private var theme

	let coin: Coin

	var body: some View {
		Button {
			print("onTap: MarketCardView")
		} label: {
			HStack(spacing: 8) {
				HStack(spacing: 12) {
					CoinLogoView(img: coin.img, size: .md)
					VStack(alignment: .leading, spacing: 0) {
						HStack(spacing: 0) {
							Text(coin.text)
								.foregroundStyle(theme.primary)
							Text(" / USDT")
								.foregroundStyle(theme.secondary)
						}
						.textCase(.uppercase)
						.font(.system(size: 16, weight: .medium))
						Text(coin.price ?? "")
							.font(.system(size: 14, weight: .medium))
							.foregroundStyle(theme.secondary)
					}
				}
				Spacer()
				VStack(alignment: .trailing, spacing: 0) {
					Text(coin.diff ?? "")
						.font(.system(size: 16, weight: .medium))
						.foregroundStyle(theme.primary)
					HStack(spacing: 0) {
						Image(coin.up == true ? "i-arrow-up" : "i-arrow-down")
							.resizable()
							.frame(width: 20, height: 20)
						Text(coin.diffStep ?? "")
							.font(.system(size: 14, weight: .semibold))
					}
					.foregroundStyle(coin.up == true ? .sGreen : .sRed)
				}
			}
			.padding(.vertical, 12)
			.padding(.horizontal, 16)
			.background(theme.backgroundForeground)
			.clipShape(.rect(cornerRadius: 16))
			.overlay {
				if theme.current == .youtube {
					RoundedRectangle(cornerRadius: 16)
						.strokeBorder(
							.youtubeSecondary.opacity(0.15),
							style: StrokeStyle(lineWidth: 2)
						)
				}
			}
		}
		.buttonStyle(.plain)
	}
}
