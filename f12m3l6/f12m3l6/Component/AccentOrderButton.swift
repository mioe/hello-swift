// by mioe

import SwiftUI

struct AccentOrderButton: View {
	
	let label: String
	let totalPrice: Decimal
	let onTap: () -> Void
	
	var body: some View {
		Button {
			onTap()
		} label: {
			HStack(spacing: 16) {
				Text(label)
					.lora(14)
					.foregroundStyle(.white)
				HStack(spacing: 2) {
					Text("$")
						.iAWritterQuattroS(14)
					Text(
						totalPrice,
						format: .number.precision(.fractionLength(0...2)).locale(
							Locale(identifier: "en_US")
						)
					)
					.iAWritterQuattroS(14)
				}
				.foregroundStyle(.white.opacity(0.5))
			}
			.frame(maxWidth: .infinity)
			.frame(height: 48)
			.background(.sAccent)
			.clipShape(Capsule())
		}
		.buttonStyle(.plain)
	}
}
