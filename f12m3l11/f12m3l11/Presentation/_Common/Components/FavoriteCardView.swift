// by mioe

import SwiftUI

struct FavoriteCardView: View {

	@Environment(ThemeStore.self) private var theme

	let favorite: Favorite

	private var stonksColor: Color {
		favorite.up ? .sGreen : .sRed
	}

	var body: some View {
		Button {
			print("onTap: FavoriteCardView")
		} label: {
			VStack {
				HStack(spacing: 0) {
					HStack(spacing: 6) {
						CoinLogoView(img: favorite.coin.img)
						Text(favorite.coin.text)
							.textCase(.uppercase)
							.font(.system(size: 18, weight: .medium))
							.foregroundStyle(theme.primary)
					}
					Spacer(minLength: 0)
					Text(favorite.diffStep)
						.font(.system(size: 14, weight: .semibold))
						.foregroundStyle(stonksColor)
				}
				Spacer()
				VStack(alignment: .leading, spacing: 0) {
					Text(favorite.balance)
						.font(.system(size: 16, weight: .medium))
					Text(favorite.diff)
						.font(.system(size: 14, weight: .semibold))
						.foregroundStyle(stonksColor)
				}
				.frame(maxWidth: .infinity, alignment: .leading)
			}
			.padding(12)
			.frame(width: 168, height: 168)
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
