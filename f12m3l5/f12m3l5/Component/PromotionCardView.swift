// by mioe

import SwiftUI

struct PromotionCardView: View {

	let yummy: Yummy

	var body: some View {

		VStack(alignment: .leading, spacing: 8) {
			Text(yummy.name)
				.lora(18)
				.foregroundStyle(.white)
				.frame(maxWidth: 160)
				.multilineTextAlignment(.leading)

			HStack(spacing: 12) {
				PriceView(yummy.basePrice, false)

				if let originalPrice = yummy.originalPrice {
					PriceView(originalPrice, true)
				}
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
		.padding(16)
		.background(.sAccent)
		.clipShape(.rect(cornerRadius: 20))
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
