// by mioe

import SwiftUI

struct YummyDetailView: View {

	@Environment(AppRouter.self) private var router
	@Environment(CartObservableStore.self) private var cart

	var yummy: Yummy

	@State private var selectedSize: YummySize = .md
	@State private var qty: Int = 1
	@State private var heroImage: Image?  // при смене размера body пересчитывается, но Image уже готовый, без перекодирования JPEG → мерцания нет

	private var withoutImage: Bool {
		yummy.image == nil
	}

	private var availableSizes: [YummySize] {
		yummy.availableSizes.isEmpty ? YummySize.allCases : yummy.availableSizes
	}

	private var unitPrice: Decimal {
		yummy.price(for: selectedSize)
	}

	private var totalPrice: Decimal {
		unitPrice * Decimal(qty)
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
			if heroImage == nil, let data = yummy.image?.data {
				heroImage = Image(data: data)
			}
		}
	}

	@ViewBuilder
	private func HeroView() -> some View {
		ZStack(alignment: .top) {
			Group {
				if let heroImage {
					heroImage
						.resizable()
						.scaledToFill()
				}
			}
			.frame(maxWidth: .infinity)
			.frame(minHeight: 104, maxHeight: withoutImage ? 104 : 320)
			.clipped()

			HeaderOverlay()
		}
	}

	@ViewBuilder
	private func HeaderOverlay() -> some View {
		CustomNavigationView(title: "Details") {  // leading start
			CustomNavigationItemView(
				icon: "arrow.left",
				onTap: { router.pop() }
			)
		} trailing: {
			CustomNavigationItemView(
				icon: "bookmark",
				onTap: { print("onTap: bookmark") }
			)
		}
		.padding(.horizontal, 32)
		.padding(.top, 64)
		.foregroundStyle(withoutImage ? .sPrimary : .white)
	}

	@ViewBuilder
	private func DetailsView() -> some View {
		VStack(spacing: 32) {
			VStack(spacing: 16) {
				Text(yummy.name)
					.lora(20)
					.foregroundStyle(.sPrimary)
					.multilineTextAlignment(.center)
					.fixedSize(horizontal: false, vertical: true)

				Text("\(yummy.info)")
					.iAWritterQuattroS(14)
					.foregroundStyle(.sPrimary.opacity(0.8))
					.multilineTextAlignment(.center)
					.fixedSize(horizontal: false, vertical: true)
			}

			SizePickerView()

			HStack {
				PriceTagView()
				Spacer()
				QuantityStepperView()
			}

			if withoutImage {  // костыль но я хз как сделать одинаковое поведение
				Spacer()
			}

			VStack(spacing: 16) {
				Text(
					"*)Dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore"
				)
				.iAWritterQuattroS(10)
				.foregroundStyle(.sPrimary.opacity(0.8))
				.frame(maxWidth: .infinity, alignment: .leading)
				.fixedSize(horizontal: false, vertical: true)

				PlaceOrderButton()
			}
		}
		.padding(.horizontal, 32)
		.padding(.top, 32)
		.padding(.bottom, 72)
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
					.iAWritterQuattroS(22)
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
				if qty > 1 { qty -= 1 }
			} label: {
				Image(systemName: "minus")
					.font(.system(size: 14, weight: .semibold))
					.foregroundStyle(.sPrimary)
					.frame(width: 24, height: 24)
					.contentShape(Circle())
			}
			.buttonStyle(.plain)
			.disabled(qty <= 1)

			Text("\(qty)")
				.iAWritterQuattroS(16)
				.foregroundStyle(.sPrimary)
				.frame(minWidth: 16)

			Button {
				qty += 1
			} label: {
				Image(systemName: "plus")
					.font(.system(size: 14, weight: .semibold))
					.foregroundStyle(.sPrimary)
					.frame(width: 24, height: 24)
					.contentShape(Circle())
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
			handleAddToCart()
		} label: {
			HStack(spacing: 16) {
				Text("Place order")
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
	
	private func handleAddToCart() {
		cart.addYummyToCart(yummy: yummy, yummySize: selectedSize, qty: qty)
	}
}
