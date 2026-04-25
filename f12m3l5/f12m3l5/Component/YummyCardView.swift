// by mioe

import SwiftUI

struct YummyCardView: View {

	let yummy: Yummy
	let onTap: () -> Void
	let onTapCart: () -> Void

	var body: some View {
		Button {
			onTap()
		} label: {
			VStack(alignment: .leading, spacing: 12) {
				ImageView()
				
				VStack(alignment: .leading, spacing: 8) {
					Text(yummy.category.name)
						.iAWritterQuattroS(10)
						.foregroundStyle(.sPrimary)
					
					Text(yummy.name)
						.lora(15)
						.foregroundStyle(.sPrimary)
						.lineLimit(2)
						.multilineTextAlignment(.leading)
				}
				
				HStack(spacing: 12) {
					PriceView(yummy.basePrice)
					
					Circle()
						.fill(.sPrimary.opacity(0.2))
						.frame(width: 4, height: 4)
					
					StarView(yummy.rating)
				}
			}
		}
		.buttonStyle(.plain)
	}
	
	@ViewBuilder
	private func PriceView(_ cost: Decimal) -> some View {
		HStack(spacing: 2) {
			Text("$")
				.iAWritterQuattroS(14)
			Text(
				cost,
				format: .number.precision(.fractionLength(0...2)).locale(
					Locale(identifier: "en_US")
				)
			)
			.iAWritterQuattroS(14)
		}
		.foregroundStyle(.sPrimary)
	}
	
	@ViewBuilder
	private func StarView(_ val: Double) -> some View {
		HStack(spacing: 2) {
			Image(systemName: "star")
				.font(.system(size: 14))
				.foregroundStyle(.sPrimary.opacity(0.5))
			
			Text(val, format: .number.precision(.fractionLength(1)))
				.iAWritterQuattroS(14)
				.foregroundStyle(.sPrimary.opacity(0.5))
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
						.fill(.sAccent.opacity(0.06))
						.overlay {
							Image(systemName: "photo")
								.font(.system(size: 28))
								.foregroundStyle(.sAccent.opacity(0.2))
						}
				}
			}
			.frame(maxWidth: .infinity)
			.frame(height: 100)
			.clipShape(.rect(cornerRadius: 16))

			Button {
				onTapCart()
			} label: {
				Image(systemName: "bag")
					.font(.system(size: 16))
					.foregroundStyle(.sPrimary)
					.frame(width: 40, height: 40)
					.background(.background)
					.clipShape(.rect(cornerRadius: 8))
					.shadow(color: .black.opacity(0.25), radius: 18, x: 0, y: 4)
			}
			.buttonStyle(.plain)
			.offset(x: -16, y: 20)
		}
	}
}
