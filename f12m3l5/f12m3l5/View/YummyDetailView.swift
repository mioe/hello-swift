// by mioe

import SwiftUI

struct YummyDetailView: View {

	@Environment(AppRouter.self) private var router

	var yummy: Yummy

	@State private var selectedSize: YummySize = .md
	@State private var quantity: Int = 1
	@State private var isBookmarked = false

	private var availableSizes: [YummySize] {
		yummy.availableSizes.isEmpty ? YummySize.allCases : yummy.availableSizes
	}

	private var unitPrice: Decimal {
		yummy.price(for: selectedSize)
	}

	private var total: Decimal {
		unitPrice * Decimal(quantity)
	}

	var body: some View {
		VStack(spacing: 0) {
			HeroView()
			DetailsView()
		}
		.ignoresSafeArea(edges: .top)
		.toolbar(.hidden, for: .navigationBar)
		.onAppear {
			if !availableSizes.contains(selectedSize) {
				selectedSize = availableSizes.first ?? .md
			}
		}
	}

	@ViewBuilder
	private func HeroView() -> some View {
		ZStack(alignment: .top) {
			Group {
				if let data = yummy.image?.data,
					let image = Image(data: data)
				{
					image
						.resizable()
						.scaledToFill()
				} else {
					Rectangle()
						.fill(.sAccent.opacity(0.06))
						.overlay {
							Image(systemName: "photo")
								.font(.system(size: 56))
								.foregroundStyle(.sAccent.opacity(0.2))
						}
				}
			}
			.frame(maxWidth: .infinity)
			.frame(height: 320)
			.clipped()

			HeaderOverlay()
		}
	}

	@ViewBuilder
	private func HeaderOverlay() -> some View {
		HStack {
			Button {
				router.pop()
			} label: {
				Image(systemName: "arrow.left")
					.font(.system(size: 18, weight: .bold))
					.foregroundStyle(.white)
					.frame(width: 40, height: 40)
					.contentShape(Circle())  // дает кликабильную зону (если нет background-а)
			}
			.buttonStyle(.plain)

			Spacer()

			Text("Details")
				.lora(18)
				.foregroundStyle(.white)

			Spacer()

			Button {
				print("onTap: bookmark")
			} label: {
				Image(systemName: "bookmark")
					.font(.system(size: 18, weight: .bold))
					.foregroundStyle(.white)
					.frame(width: 40, height: 40)
					.contentShape(Circle())
			}
			.buttonStyle(.plain)
		}
		.padding(.horizontal, 32)
		.padding(.top, 56)
	}

	@ViewBuilder
	private func DetailsView() -> some View {
		VStack(spacing: 24) {
			VStack(spacing: 16) {
				Text(yummy.name)
					.lora(20)
					.foregroundStyle(.sPrimary)
					.multilineTextAlignment(.center)

				Text("\(yummy.info)")
					.iAWritterQuattroS(14)
					.foregroundStyle(.sPrimary.opacity(0.8))
					.multilineTextAlignment(.center)
			}

			SizePickerView()

			HStack {
				PriceTagView()
				Spacer()
				QuantityStepperView()
			}

			Text(
				"*) Dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore"
			)
			.iAWritterQuattroS(11)
			.foregroundStyle(.sPrimary.opacity(0.5))
			.frame(maxWidth: .infinity, alignment: .leading)

			Spacer(minLength: 0)

			PlaceOrderButton()
		}
		.padding(.horizontal, 32)
		.padding(.top, 32)
		.padding(.bottom, 64)
		.frame(maxHeight: .infinity)
	}

	@ViewBuilder
	private func SizePickerView() -> some View {
		HStack(spacing: 12) {
			ForEach(availableSizes, id: \.self) { size in
				Button {
					withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
						selectedSize = size
					}
				} label: {
					Text(size.shortLabel)
						.iAWritterQuattroS(16)
						.foregroundStyle(.sPrimary)
						.frame(width: 56, height: 56)
						.background(
							selectedSize == size ? .sSecondary : .sSecondary.opacity(0.5)
						)
						.clipShape(.rect(cornerRadius: 18))
						
				}
				.buttonStyle(.plain)
			}
		}
	}

	@ViewBuilder
	private func PriceTagView() -> some View {
		HStack(spacing: 10) {
			Image(systemName: "tag")
				.font(.system(size: 22))
				.foregroundStyle(.sPrimary)
			HStack(spacing: 2) {
				Text("$")
					.iAWritterQuattroS(20)
				Text(
					unitPrice,
					format: .number.precision(.fractionLength(0...2)).locale(
						Locale(identifier: "en_US")
					)
				)
				.iAWritterQuattroS(22)
			}
			.foregroundStyle(.sPrimary)
		}
	}

	@ViewBuilder
	private func QuantityStepperView() -> some View {
		HStack(spacing: 16) {
			Button {
				if quantity > 1 { quantity -= 1 }
			} label: {
				Image(systemName: "minus")
					.font(.system(size: 14, weight: .semibold))
					.foregroundStyle(.sPrimary)
					.frame(width: 24, height: 24)
			}
			.buttonStyle(.plain)
			.disabled(quantity <= 1)

			Text("\(quantity)")
				.iAWritterQuattroS(16)
				.foregroundStyle(.sPrimary)
				.frame(minWidth: 16)

			Button {
				quantity += 1
			} label: {
				Image(systemName: "plus")
					.font(.system(size: 14, weight: .semibold))
					.foregroundStyle(.sPrimary)
					.frame(width: 24, height: 24)
			}
			.buttonStyle(.plain)
		}
		.padding(.horizontal, 14)
		.frame(height: 44)
		.overlay(
			RoundedRectangle(cornerRadius: 22)
				.stroke(.sPrimary.opacity(0.15), lineWidth: 1)
		)
	}

	@ViewBuilder
	private func PlaceOrderButton() -> some View {
		Button {
			print("onTap: place order \(quantity) × \(selectedSize.shortLabel)")
		} label: {
			HStack(spacing: 12) {
				Text("PLACE ORDER")
					.iAWritterQuattroS(14)
					.foregroundStyle(.white)
				HStack(spacing: 2) {
					Text("$")
						.iAWritterQuattroS(14)
					Text(
						total,
						format: .number.precision(.fractionLength(0...2)).locale(
							Locale(identifier: "en_US")
						)
					)
					.iAWritterQuattroS(14)
				}
				.foregroundStyle(.white.opacity(0.5))
			}
			.frame(maxWidth: .infinity)
			.frame(height: 56)
			.background(.sAccent)
			.clipShape(Capsule())
		}
		.buttonStyle(.plain)
	}
}
