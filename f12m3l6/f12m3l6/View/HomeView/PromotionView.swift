// by mioe

import SwiftData
import SwiftUI

struct PromotionView: View {

	@Environment(AppRouter.self) private var router

	@Query(filter: #Predicate<Yummy> { $0.isPromoted })
	private var promotions: [Yummy]

	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			CustomNavigationView(title: "Promotion") {
				CustomNavigationItemView(
					icon: "arrow.left",
					onTap: { handleOpenBack() }
				)
			}
			.padding(.bottom, 16)
			.background(.background)

			ScrollView {
				LazyVStack(alignment: .leading, spacing: 24) {
					ForEach(promotions, id: \.id) { promo in
						PromotionCardView(
							yummy: promo,
							onTap: { handleOpenYummyDetail(promo) },
							color: .sAccent
						)
					}
				}
			}
			.scrollIndicators(.hidden)
			.contentMargins(.bottom, 120, for: .scrollContent)
		}
		.toolbar(.hidden, for: .navigationBar)
		.padding(.horizontal, 32)
		.padding(.top, 20)
	}

	private func handleOpenBack() {
		router.pop()
	}

	private func handleOpenYummyDetail(_ yummy: Yummy) {
		router.openYummyDetail(yummy.id)
	}
}
