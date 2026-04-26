// by mioe

import SwiftData
import SwiftUI

struct HomeView: View {

	@Environment(AppRouter.self) private var router
	@Environment(CartObservableStore.self) private var cart

	@Query(filter: #Predicate<Yummy> { $0.isPromoted })
	private var promotions: [Yummy]
	@State private var activePromotionID: UUID?  // костыль чтобы передать цвет внутрь компонента

	@Query(sort: \Category.sortOrder, order: .reverse)
	private var categories: [Category]

	@Query(filter: #Predicate<Yummy> { $0.isFeatured })
	private var featured: [Yummy]

	@Query(filter: #Predicate<Changelog> { $0.isViewed == false })
	private var unviewedChangelogs: [Changelog]

	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 32) {
				HeaderView()
				PromotionView()
				CategoryView()
				FavoriteView()
			}
		}
		.scrollClipDisabled()
		.scrollIndicators(.hidden)
		.padding(.horizontal, 32)
		.padding(.top, 20)
		.padding(.bottom, 64)
	}

	@ViewBuilder
	private func HeaderView() -> some View {
		HStack {
			VStack(alignment: .leading) {
				Text("Good Morning 👋🏻")
					.iAWritterQuattroS(12)
					.foregroundStyle(.sPrimary)
				Text("Misha Gezha")
					.lora(24)
					.foregroundStyle(.sPrimary)
			}
			Spacer()
			Button {
				handleOpenSettingsView()
			} label: {
				ZStack(alignment: .topTrailing) {
					Image(._1775640178368)
						.resizable()
						.scaledToFill()
						.frame(width: 48, height: 48)
						.clipShape(Circle())

					if !unviewedChangelogs.isEmpty {
						Circle()
							.fill(.white)
							.frame(width: 18, height: 18)
							.overlay {
								Circle()
									.fill(.sSecondary)
									.frame(width: 12, height: 12)
							}
					}
				}
			}
			.buttonStyle(.plain)
		}
	}

	@ViewBuilder
	private func PromotionView() -> some View {
		VStack(alignment: .leading, spacing: 16) {
			HStack {
				SectionTitleView(title: "🐥🐥🐣 Promotion")
				Spacer()
				SimpleButtonMoreView(onTap: { handleOpenPromotion() })
			}

			ScrollView(.horizontal) {
				HStack(spacing: 0) {
					ForEach(promotions, id: \.id) { yummy in
						PromotionCardView(
							yummy: yummy,
							onTap: { handleOpenYummyDetail(yummy) },
							color: activePromotionID == yummy.id
								? .sAccent : .sAccentForeground
						)
						.scrollTransition { content, phase in
							content
								.scaleEffect(phase.isIdentity ? 1.0 : 0.85)
						}
					}
				}
				.scrollTargetLayout()
			}
			.scrollClipDisabled()
			.scrollIndicators(.hidden)
			.scrollTargetBehavior(.viewAligned)
			.scrollPosition(id: $activePromotionID)
			.onAppear {
				if activePromotionID == nil {
					activePromotionID = promotions.first?.id
				}
			}
		}
	}

	@ViewBuilder
	private func CategoryView() -> some View {
		VStack(alignment: .leading, spacing: 16) {
			SectionTitleView(title: "Categories")

			ScrollView(.horizontal) {
				HStack(spacing: 16) {
					ForEach(categories, id: \.id) { category in
						CategoryCardView(
							category: category,
							onTap: { handleOpenCategory(category) }
						)
						.containerRelativeFrame(.horizontal, count: 2, spacing: 16)
					}
				}
			}
			.scrollClipDisabled()
			.scrollIndicators(.hidden)
		}
	}

	@ViewBuilder
	private func FavoriteView() -> some View {
		VStack(alignment: .leading, spacing: 16) {
			HStack {
				SectionTitleView(title: "Featured")
				Spacer()
				SimpleButtonMoreView(onTap: { handleOpenFavorited() })
			}

			ScrollView(.horizontal) {
				HStack(alignment: .top, spacing: 16) {
					ForEach(featured, id: \.id) { yummy in
						YummyCardView(
							yummy: yummy,
							onTap: { handleOpenYummyDetail(yummy) },
							onTapCart: { handleAddToCart(yummy) }
						)
						.containerRelativeFrame(.horizontal, count: 2, spacing: 16)
					}
				}
			}
			.scrollClipDisabled()
			.scrollIndicators(.hidden)
		}
	}

	private func handleOpenYummyDetail(_ yummy: Yummy) {
		router.openYummyDetail(yummy.id)
	}

	private func handleOpenCategory(_ category: Category) {
		router.openCategory(category.id)
	}

	private func handleOpenPromotion() {
		router.openPromotion()
	}

	private func handleOpenFavorited() {
		router.openFavorited()
	}

	private func handleOpenSettingsView() {
		router.currentTab = .settings
	}
	
	private func handleAddToCart(_ yummy: Yummy) {
		cart.addYummyToCart(yummy: yummy)
	}
}
