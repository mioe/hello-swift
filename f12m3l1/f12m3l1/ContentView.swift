// by mioe

import SwiftUI

struct ContentView: View {
	private let headerHeight: CGFloat = 48
	private let topLocationsButtonHeight: CGFloat = 56

	var body: some View {
		VStack(alignment: .leading, spacing: 32) {
			HeaderView()
			WelcomeView()
			TopLocationsView()
		}
		.padding(.horizontal, 32)
	}

	@ViewBuilder
	private func HeaderView() -> some View {
		HStack {
			Button {
				print("onTap: location")
			} label: {
				HStack(spacing: 8) {
					Image(systemName: "mappin.and.ellipse")
						.font(.system(size: 14))
						.foregroundStyle(.red)
					Text("Rostov-on-Don, Russia")
						.font(.system(size: 10))
						.foregroundStyle(.sGreyDark)
				}
				.frame(height: headerHeight)
				.padding(.horizontal, 20)
				.background(.background)
				.clipShape(Capsule())
				.overlay {
					Capsule()
						.strokeBorder(.sGreySoft2, lineWidth: 1)
				}
				.shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
			}
			.buttonStyle(.plain)

			Spacer()

			HStack {
				Button {
					print("onTap: bell")
				} label: {
					Image(systemName: "bell")
						.foregroundStyle(.sGreyDark)
				}
				.buttonStyle(.plain)
				.frame(width: headerHeight, height: headerHeight)
				.background(.sGreySoft1)
				.clipShape(Circle())
				.shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)

				Button {
					print("onTap: avatar")
				} label: {
					Image(._1775640178368)
						.resizable()
						.scaledToFill()
						.frame(width: headerHeight - 8, height: headerHeight - 8)
						.clipShape(Circle())
				}
				.buttonStyle(.plain)
				.frame(width: headerHeight, height: headerHeight)
				.background(.sGreySoft1)
				.clipShape(Circle())
				.shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)

			}
		}
	}

	@ViewBuilder
	private func WelcomeView() -> some View {
		VStack(alignment: .leading, spacing: 24) {
			Text("Hey, **Misha**")
				.font(.system(size: 20))
			HStack {
				WelcomeButtonView("building.2", "Building")
				WelcomeButtonView("house.lodge", "House")
				WelcomeButtonView("bed.double", "Bed")
			}
		}
	}

	@ViewBuilder
	private func WelcomeButtonView(_ icon: String, _ label: String) -> some View {
		Button {
			print("onTap: \(label)")
		} label: {
			HStack(spacing: 6) {
				Image(systemName: icon)
					.font(.system(size: 14))
					.foregroundStyle(.indigo)
				Text(label)
					.font(.system(size: 10, weight: .medium))
					.foregroundStyle(.secondary)
			}
			.frame(height: 40)
			.padding(.horizontal, 16)
			.background(.background)
			.clipShape(RoundedRectangle(cornerRadius: 12))
			.overlay {
				RoundedRectangle(cornerRadius: 12)
					.strokeBorder(.sGreySoft2, lineWidth: 1)
			}
		}
		.buttonStyle(.plain)
	}
	
	@ViewBuilder
	private func TitleForSectionView(_ title: String) -> some View {
		Text(title)
			.font(.system(size: 18, weight: .medium))
	}
	
	@ViewBuilder
	private func TopLocationsView() -> some View {
		VStack(alignment: .leading, spacing: 16) {
			HStack {
				TitleForSectionView("Top Locations")
				Spacer()
				Button {
					print("onTap: explore")
				} label: {
					Text("explore")
						.font(.system(size: 10, weight: .medium))
				}.buttonStyle(.plain)
			}
			ScrollView([.horizontal]) {
				HStack(spacing: 12) {
					TopLocationsButtonView("img-1", "Bali")
					TopLocationsButtonView("img-2", "Jakarta")
					TopLocationsButtonView("img-3", "Yogyakarta")
					TopLocationsButtonView("img-4", "Semarang")
				}
			}
			.scrollClipDisabled()
			.scrollIndicators(.hidden)
		}
	}
	
	@ViewBuilder
	private func TopLocationsButtonView(_ image: String, _ label: String) -> some View {
		Button {
			print("onTap: \(label)")
		} label: {
			HStack(spacing: 8) {
				Image(image)
					.resizable()
					.scaledToFill()
					.frame(width: 40, height: 40)
					.font(.system(size: 14))
					.clipShape(Circle())
				Text(label)
					.font(.system(size: 10, weight: .medium))
					.foregroundStyle(.sGreyDark)
			}
			.frame(height: topLocationsButtonHeight)
			.padding(.leading, 8)
			.padding(.trailing, 16)
			.background(.sGreySoft1)
			.clipShape(Capsule())
		}
		.buttonStyle(.plain)
	}
}
