// by mioe

import SwiftUI

struct YummyCardView: View {

	let yummy: Yummy
	var onAddToCart: () -> Void = {}

	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			ImageView()

			Text(yummy.category.name)
				.iAWritterQuattroS(12)
				.foregroundStyle(.sPrimary.opacity(0.5))

			Text(yummy.name)
				.lora(15)
				.foregroundStyle(.sPrimary)
				.lineLimit(2)
				.multilineTextAlignment(.leading)

			HStack(spacing: 6) {
				Text("$\(yummy.basePrice, format: .number.precision(.fractionLength(0...2)).locale(Locale(identifier: "en_US")))")
					.lora(14)
					.foregroundStyle(.sPrimary)

				Circle()
					.fill(.sPrimary.opacity(0.3))
					.frame(width: 4, height: 4)

				Image(systemName: "star")
					.font(.system(size: 11))
					.foregroundStyle(.sPrimary.opacity(0.5))

				Text(yummy.rating, format: .number.precision(.fractionLength(1)))
					.iAWritterQuattroS(12)
					.foregroundStyle(.sPrimary.opacity(0.5))
			}
		}
	}

	@ViewBuilder
	private func ImageView() -> some View {
		ZStack(alignment: .bottomTrailing) {
			Group {
				if let data = yummy.image?.data,
				   let image = Image(data: data) {
					image
						.resizable()
						.scaledToFill()
				} else {
					Rectangle()
						.fill(.sPrimary.opacity(0.06))
						.overlay {
							Image(systemName: "photo")
								.font(.system(size: 28))
								.foregroundStyle(.sPrimary.opacity(0.2))
						}
				}
			}
			.frame(maxWidth: .infinity)
			.frame(height: 150)
			.clipShape(.rect(cornerRadius: 16))

			Button(action: onAddToCart) {
				Image(systemName: "bag")
					.font(.system(size: 16, weight: .medium))
					.foregroundStyle(.sPrimary)
					.frame(width: 40, height: 40)
					.background(.white)
					.clipShape(Circle())
					.shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)
			}
			.padding(8)
		}
	}
}
