// by mioe

import SwiftUI

struct BalanceCardView: View {
	
	@Environment(ThemeStore.self) private var theme

	enum TimeRange: String, CaseIterable, CustomStringConvertible {
		case w1 = "1w"
		case m1 = "1m"
		case m3 = "3m"
		case m6 = "6m"
		case y1 = "1y"
		case all = "All"
		var description: String { rawValue }
	}

	let textPrimaryColor: Color
	let textSecondaryColor: Color
	let bgColor: Color
	let bgForegroundColor: Color
	
	@State private var range: TimeRange = .m6

	var body: some View {
		VStack(alignment: .leading, spacing: 12) {
			HStack(spacing: 0) {
				VStack(alignment: .leading, spacing: 4) {
					HStack(spacing: 4) {
						Text("Total balance")
							.font(.system(size: 14))
						Image(.iEye)
							.resizable()
							.frame(width: 20, height: 20)
					}
					.foregroundStyle(textSecondaryColor)

					HStack(spacing: 4) {
						Text("10.240,98")
							.foregroundStyle(textPrimaryColor)
						Text("USDT")
							.foregroundStyle(textSecondaryColor)
					}
					.font(.system(size: 32, weight: .medium))

					HStack(spacing: 12) {
						Text("≈ $10.240,98")
							.font(.system(size: 16, weight: .medium))
						HStack(spacing: 0) {
							Image(.iArrowUp)
								.resizable()
								.scaledToFill()
								.frame(width: 20, height: 20)
							Text("+3.24%")
								.font(.system(size: 14, weight: .semibold))
						}
						.padding(.vertical, 2)
						.padding(.leading, 4)
						.padding(.trailing, 6)
						.foregroundStyle(.sGreen)
						.background(.sGreen.opacity(0.15))
						.clipShape(.rect(cornerRadius: 6))
					}
				}

				Spacer()
			}
			
			SegmentedPicker(options: TimeRange.allCases, selection: $range)
		}
		.padding(16)
		.background(bgForegroundColor)
		.clipShape(.rect(cornerRadius: 20))
		.overlay {
			if theme.current == .youtube {
				RoundedRectangle(cornerRadius: 20)
					.strokeBorder(.youtubeSecondary.opacity(0.15), style: StrokeStyle(lineWidth: 2))
			}
		}
	}
}
