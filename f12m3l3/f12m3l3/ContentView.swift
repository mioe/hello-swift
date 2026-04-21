// by mioe

import SwiftUI

struct ContentView: View {

	let categories: [(id: String, icon: String, label: String)] = [
		(id: UUID().uuidString, icon: "icon-1", label: "Strength"),
		(id: UUID().uuidString, icon: "icon-2", label: "Flexible"),
		(id: UUID().uuidString ,icon: "icon-3", label: "Cardio"),
		(id: UUID().uuidString, icon: "icon-4", label: "Balance"),
	]
	
	let plans: [(id: String, img: String, label: String, deadline: Int, costMin: Int)] = [
		(id: UUID().uuidString, img: "img-1", label: "Simple Home Workout", deadline: 30, costMin: 15),
		(id: UUID().uuidString, img: "img-2", label: "Upper Body Builder", deadline: 15, costMin: 20),
		(id: UUID().uuidString, img: "img-3", label: "Healing Yoga Session", deadline: 15, costMin: 60),
	]

	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 24) {
				HeaderView()
				MainCardView()
				CarouselCategoryView()
				PopularView()
			}
		}
		.scrollClipDisabled()
		.scrollIndicators(.hidden)
		.padding(.top, 32)
		.padding(.horizontal, 32)
		.onAppear {
			// вывод списка доступных шрифтов
			for f in UIFont.familyNames.filter({
				$0.hasPrefix("iA") || $0.hasPrefix("Lora")
			}) {
				let v = UIFont.fontNames(forFamilyName: f)
				print("\(f): \(v)")
			}
		}
	}

	@ViewBuilder
	private func HeaderView() -> some View {
		HStack {
			VStack(alignment: .leading) {
				Text("Welcome Back 👋🏻")
					.iAWritterQuattroS(.regular, 12)
					.foregroundStyle(.sSecondary)
				Text("Willy Draw")
					.lora(.medium, 24)
					.foregroundStyle(.sAccent)
			}

			Spacer()

			Button {
				print("onTap: bell")
			} label: {
				VStack {
					Image(systemName: "bell.fill")
						.font(.system(size: 18))
						.foregroundStyle(.white)
				}
				.frame(width: 48, height: 48)
				.background(.black)
				.clipShape(RoundedRectangle(cornerRadius: 16))
			}
			.buttonStyle(.plain)
		}
	}

	@ViewBuilder
	private func MainCardView() -> some View {
		VStack(alignment: .leading, spacing: 16) {
			HStack {
				Text("Daily \nChallange")
					.lora(.medium, 28)
					.foregroundStyle(.white)
				Spacer()
			}

			Text("Don't let today's \nchallenge slip away!")
				.iAWritterQuattroS(.regular, 14)
				.foregroundStyle(.white)

			Button {
				print("onTap: take the challanges")
			} label: {
				HStack {
					VStack(alignment: .leading, spacing: 4) {
						Text("Take the Challanges")
							.lora(.medium, 14)
							.foregroundStyle(.white)

						HStack(spacing: 12) {
							HStack(spacing: 4) {
								Image(systemName: "timer")
									.font(.system(size: 12))
								Text("20 min")
									.iAWritterQuattroS(.regular, 12)
							}
							HStack(spacing: 4) {
								Image(systemName: "star.rectangle")
									.font(.system(size: 12))
								Text("100 points")
									.iAWritterQuattroS(.regular, 12)
							}
						}
						.foregroundStyle(.white.opacity(0.8))
					}

					Spacer()

					CropperIconPlayView(size: .md)
				}
				.padding(12)
				.background {
					RoundedRectangle(cornerRadius: 16)
						.fill(Color.sAccent.mix(with: .white, by: 0.2))
						.glassEffect(in: RoundedRectangle(cornerRadius: 16))
				}
			}
			.buttonStyle(.plain)
		}
		.padding(24)
		.background(.sAccent)
		.clipShape(RoundedRectangle(cornerRadius: 32))
	}

	@ViewBuilder
	private func CarouselCategoryView() -> some View {
		HStack(spacing: 16) {
			ForEach(categories, id: \.id) { cat in
				Button {
					print("onTap: \(cat.label)")
				} label: {
					CarouselCategoryItemView(
						icon: cat.icon,
						label: cat.label
					)
				}
				.buttonStyle(.plain)
			}
		}
	}
	
	@ViewBuilder
	private func PopularView() -> some View {
		VStack(spacing: 16) {
			HStack {
				Text("Popular Workout Plans")
					.lora(.medium, 16)
				Spacer()
				Button {
					print("onTap: see all")
				} label: {
					Text("See All")
						.iAWritterQuattroS(.regular, 14)
						.foregroundStyle(.sSecondary)
				}
				.buttonStyle(.plain)
			}
			
			ScrollView([.horizontal]) {
				HStack(spacing: 16) {
					ForEach(plans, id: \.id) { pln in
						CarouselPlanItemView(
							img: pln.img,
							label: pln.label,
							deadline: pln.deadline,
							costMin: pln.costMin,
						)
					}
				}
			}
			.scrollClipDisabled()
			.scrollIndicators(.hidden)
		}
	}
}
