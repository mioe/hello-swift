// by mioe

import SwiftData
import SwiftUI

struct FavoritedView: View {

	@Environment(AppRouter.self) private var router
	@Environment(CartObservableStore.self) private var cart

	@Query(filter: #Predicate<Yummy> { $0.isFeatured })
	private var featured: [Yummy]

	private let columns = [
		GridItem(.flexible(), spacing: 16),
		GridItem(.flexible(), spacing: 16),
	]

	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			CustomNavigationView(title: "Favorited") {
				CustomNavigationItemView(
					icon: "arrow.left",
					onTap: { handleOpenBack() }
				)
			}
			.padding(.bottom, 16)
			.background(.background)

			ScrollView {
				LazyVGrid(columns: columns, spacing: 16) {
					ForEach(featured, id: \.id) { fav in
						YummyCardView(
							yummy: fav,
							onTap: { handleOpenYummyDetail(fav) },
							onTapCart: { handleAddToCart(fav) }
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
	
	private func handleAddToCart(_ yummy: Yummy) {
		cart.addYummyToCart(yummy: yummy)
	}
}
