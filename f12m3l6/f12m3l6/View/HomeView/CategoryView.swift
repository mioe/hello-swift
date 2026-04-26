// by mioe

import SwiftData
import SwiftUI

struct CategoryView: View {

	@Environment(AppRouter.self) private var router
	@Environment(CartObservableStore.self) private var cart

	@Query(sort: \Category.sortOrder)
	private var categories: [Category]

	var category: Category

	private let columns = [
		GridItem(.flexible(), spacing: 16),
		GridItem(.flexible(), spacing: 16),
	]

	@State private var didInitialScroll = false

	var body: some View {
		ScrollViewReader { proxy in
			VStack(alignment: .leading, spacing: 0) {
				VStack(alignment: .leading, spacing: 16) {
					CustomNavigationView(title: "Categories") {
						CustomNavigationItemView(
							icon: "arrow.left",
							onTap: { handleOpenBack() }
						)
					}
					CategoryPickerView { cat in
						withAnimation {
							proxy.scrollTo(cat.id, anchor: .top)
						}
					}
				}
				.zIndex(1)
				.padding(.bottom, 32)
				.background(.background)

				ScrollView {
					LazyVStack(alignment: .leading, spacing: 32) {
						ForEach(categories, id: \.id) { cat in
							VStack(alignment: .leading, spacing: 16) {
								SectionTitleView(title: cat.name)

								LazyVGrid(columns: columns, spacing: 16) {
									ForEach(cat.yummies, id: \.id) { yummy in
										YummyCardView(
											yummy: yummy,
											onTap: { handleOpenYummyDetail(yummy) },
											onTapCart: { handleAddToCart(yummy) }
										)
									}
								}
							}
							.id(cat.id)  // якорь для scrollTo
						}
					}
				}
				.scrollIndicators(.hidden)
				.contentMargins(.bottom, 120, for: .scrollContent)  // откладывает trigger-зону которая удаляет карточки для оптимизации
				.task {  // лучше чем .onAppear - сам отменится при уходе со страницы
					guard !didInitialScroll else { return }
					didInitialScroll = true  // флаг чтобы игнорировать событие, когда возвращаемся из карточки yummy
					try? await Task.sleep(for: .milliseconds(50))
					withAnimation {
						proxy.scrollTo(category.id, anchor: .top)
					}
				}
			}
		}
		.toolbar(.hidden, for: .navigationBar)
		.padding(.horizontal, 32)
		.padding(.top, 20)
	}

	@ViewBuilder
	private func CategoryPickerView(onTap: @escaping (Category) -> Void)
		-> some View
	{
		// @escaping - пробрасывает нажатую категорию
		ScrollView(.horizontal) {
			HStack(spacing: 16) {
				ForEach(categories, id: \.id) { cat in
					Button {
						onTap(cat)
					} label: {
						HStack {
							Image(systemName: getCatIconName(cat.name))
								.font(.system(size: 14))
							Text("\(cat.name)")
								.iAWritterQuattroS(14)
						}
						.foregroundStyle(.sPrimary)
						.padding(.horizontal, 8)
						.padding(.vertical, 4)
						.background(.sSecondary)
						.clipShape(.rect(cornerRadius: 8))
					}
					.buttonStyle(.plain)
				}
			}
		}
		.scrollClipDisabled()
		.scrollIndicators(.hidden)
	}

	private func getCatIconName(_ name: String) -> String {
		switch name {
		case "Beverages": "cup.and.saucer"
		case "Foods": "fork.knife"
		case "Desserts": "birthday.cake"
		default: "square.grid.2x2"
		}
	}

	private func handleOpenYummyDetail(_ yummy: Yummy) {
		router.openYummyDetail(yummy.id)
	}

	private func handleOpenBack() {
		router.pop()
	}
	
	private func handleAddToCart(_ yummy: Yummy) {
		cart.addYummyToCart(yummy: yummy)
	}
}
