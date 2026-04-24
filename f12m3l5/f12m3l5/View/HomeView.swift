// by mioe

import SwiftData
import SwiftUI

struct HomeView: View {

	@Query(filter: #Predicate<Yummy> { $0.isPromoted })
	private var promotions: [Yummy]

	@State private var activePromotionID: UUID?

	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 32) {
				HeaderView()
				PromotionView()
			}
		}
		.scrollClipDisabled()
		.scrollIndicators(.hidden)
		.padding(.top, 32)
		.padding(.horizontal, 32)
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
					.foregroundStyle(.sAccent)
			}
			Spacer()
			Button {
				print("onTap: avatar")
			} label: {
				ZStack(alignment: .topTrailing) {
					Image(._1775640178368)
						.resizable()
						.scaledToFill()
						.frame(width: 48, height: 48)
						.clipShape(Circle())
					
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
			.buttonStyle(.plain)
		}
	}
	
	@ViewBuilder
	private func PromotionView() -> some View {
		VStack(alignment: .leading, spacing: 16) {
			HStack {
				SectionTitleView(title: "✨ Promotion")
				Spacer()
				SimpleButtonMoreView(onTap: { print("onTap: more") })
			}

			ScrollView(.horizontal) {
				HStack(spacing: 4) {
					ForEach(promotions, id: \.id) { yummy in
						PromotionCardView(
							yummy: yummy,
							isActive: activePromotionID == yummy.id
						)
					}
				}
				.scrollTargetLayout()
			}
			.scrollTargetBehavior(.viewAligned)
			.scrollClipDisabled()
			.scrollIndicators(.hidden)
			.scrollPosition(id: $activePromotionID)
			.onAppear {
				if activePromotionID == nil {
					activePromotionID = promotions.first?.id
				}
			}
		}
	}
}
