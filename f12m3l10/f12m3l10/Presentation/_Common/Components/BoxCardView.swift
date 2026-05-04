// by mioe

import SwiftUI

struct BoxCardView: View {

	let order: Order

	private var cardBgColor: Color {
		switch order.status {
		case .transit: .sAccent.opacity(0.08)
		case .arrived: .sMint
		}
	}
	
	private var statusBgColor: Color {
		switch order.status {
		case .transit: .sAccentForeground
		case .arrived: .sGreenForeground
		}
	}
	
	private var statusForegroundColor: Color {
		switch order.status {
		case .transit: .sAccent
		case .arrived: .sGreen
		}
	}
	
	private var statusText: String {
		switch order.status {
		case .transit: "Transit"
		case .arrived: "Arrived"
		}
	}

	var body: some View {
		VStack(spacing: 16) {
			HStack {
				Image(.boxX2)
					.resizable()
					.scaledToFill()
					.frame(width: 118, height: 93)
				Spacer()
				VStack(alignment: .trailing, spacing: 0) {
					Text(order.title)
						.poppins(24, .medium)
					Text(order.serial)
						.poppins(24)
				}
				.foregroundStyle(.sPrimary)
			}

			HStack {
				TextChunkView(key: "From", val: order.from, alignment: .leading)
				Spacer()
				TextChunkView(key: "To", val: order.to, alignment: .trailing)
			}

			HStack(alignment: .bottom) {
				StatusView()
				Spacer()
				VStack(alignment: .trailing, spacing: 0) {
					TextChunkView(key: "Date", val: order.date, alignment: .trailing)
				}
			}
		}
		.padding(20)
		.frame(maxWidth: .infinity)
		.background(cardBgColor)
		.clipShape(.rect(cornerRadius: 36))
	}

	@ViewBuilder
	private func TextChunkView(
		key: String,
		val: String,
		alignment: HorizontalAlignment,
	) -> some View {
		VStack(alignment: alignment, spacing: 0) {
			Text(key)
				.poppins(14, .medium)
				.foregroundStyle(.sSecondary)
			Text(val)
				.poppins(16, .medium)
				.foregroundStyle(.sPrimary)
		}
	}
	
	@ViewBuilder
	private func StatusView() -> some View {
		HStack(spacing: 4) {
			Text(statusText)
				.poppins(12)
				.foregroundStyle(statusForegroundColor)
			Circle()
				.fill(statusForegroundColor)
				.frame(width: 10, height: 10)
		}
		.padding(.vertical, 4)
		.padding(.horizontal, 12)
		.background(statusBgColor)
		.clipShape(.capsule)
	}
}
