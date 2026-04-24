// by mioe

import SwiftUI

struct PromotionCardView: View {

	let yummy: Yummy
	var color: Color = .sAccent

	var body: some View {
		ZStack(alignment: .bottomTrailing) {
			VStack(alignment: .leading, spacing: 16) {
				Text(yummy.name)
					.lora(18)
					.foregroundStyle(.white)
					.multilineTextAlignment(.leading)
					.frame(maxWidth: 160, alignment: .leading)

				HStack(spacing: 16) {
					PriceView(yummy.basePrice, false)

					if let originalPrice = yummy.originalPrice {
						PriceView(originalPrice, true)
					}
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)

			Image(systemName: "gear")
				.font(.system(size: 20))
				.foregroundStyle(.sSecondary)
				.offset(x: 16, y: -16)
		}
		.padding(.horizontal, 32)
		.containerRelativeFrame(.horizontal)
		.frame(height: 160)
		.background(color)
		.clipShape(.rect(cornerRadius: 20))
		.animation(.spring(response: 0.3, dampingFraction: 0.8), value: color)
	}

	@ViewBuilder
	private func PriceView(_ cost: Decimal, _ withDiscount: Bool) -> some View {
		let tintColor: Color = withDiscount ? .sSecondary : .white
		let fontSize: CGFloat = withDiscount ? 14 : 18

		HStack(spacing: 2) {
			Text("$")
				.iAWritterQuattroS(fontSize)
			Text(
				cost,
				format: .number.precision(.fractionLength(0...2)).locale(
					Locale(identifier: "en_US")
				)
			)
			.iAWritterQuattroS(fontSize)
		}
		.strikethrough(withDiscount)
		.foregroundStyle(tintColor)
	}
}
