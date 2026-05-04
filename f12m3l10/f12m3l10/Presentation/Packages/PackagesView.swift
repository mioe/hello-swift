// by mioe

import SwiftUI

struct PackagesView: View {

	let onTapCar: () -> Void
	let orders: [Order] = [
		Order(
			status: .transit,
			title: "#ER-ML",
			serial: "550-145-17L",
			from: "London, UK",
			to: "Kaliningrad, RU",
			date: "22.01.2026",
		),
		Order(
			status: .arrived,
			title: "#ER-ML",
			serial: "271-029-33P",
			from: "Tokio, JP",
			to: "Kaliningrad, RU",
			date: "23.01.2026",
		),
	]

	var body: some View {
		ScrollView {
			VStack(spacing: 12) {
				HeaderView()
				HeroView()
				UserInfoView()
				HistoryView()
				FooterView()
			}
		}
		.scrollClipDisabled()
		.scrollIndicators(.hidden)
		.padding(.vertical, 20)
		.padding(.horizontal, 26)
	}

	@ViewBuilder
	private func HeaderButtonView(onTap: @escaping () -> Void, icon: String)
		-> some View
	{
		Button {
			onTap()
		} label: {
			HStack {
				Image(icon)
					.resizable()
					.frame(width: 24, height: 24)
			}
			.frame(width: 44, height: 44)
			.background(.sGrey)
			.clipShape(.circle)
		}
		.buttonStyle(.plain)
	}

	@ViewBuilder
	private func HeaderView() -> some View {
		HStack {
			HeaderButtonView(onTap: { onTapCar() }, icon: "i-car")
			Spacer()
			Text("Packages")
				.poppins(16)
			Spacer()
			HeaderButtonView(onTap: { print("onTap: share") }, icon: "i-share")
		}
		.foregroundStyle(.sPrimary)
	}

	@ViewBuilder
	private func HeroView() -> some View {
		HStack {
			Image(.packageX2)
				.resizable()
				.scaledToFill()
				.clipShape(.rect(cornerRadius: 28))
		}
		.padding(8)
		.frame(height: 228)
		.background(.sAccent.opacity(0.08))
		.clipShape(.rect(cornerRadius: 36))
	}

	@ViewBuilder
	private func UserInfoButtonView(onTap: @escaping () -> Void, icon: String)
		-> some View
	{
		Button {
			onTap()
		} label: {
			HStack {
				Image(icon)
					.resizable()
					.frame(width: 20, height: 20)
					.foregroundStyle(.sAccent)
			}
			.frame(width: 48, height: 48)
			.background(.white)
			.clipShape(.circle)
		}
		.buttonStyle(.plain)
	}

	@ViewBuilder
	private func UserInfoView() -> some View {
		HStack {
			HStack(spacing: 8) {
				Image(.user)
					.resizable()
					.scaledToFill()
					.frame(width: 48, height: 48)
				VStack(alignment: .leading, spacing: 0) {
					Text("(900) 00-000-00")
						.poppins(14, .medium)
						.foregroundStyle(.sSecondary)
					Text("User Name")
						.poppins(16, .medium)
						.foregroundStyle(.sPrimary)
				}
			}

			Spacer()

			HStack(spacing: 8) {
				UserInfoButtonView(
					onTap: { print("onTap: message") },
					icon: "i-message"
				)
				UserInfoButtonView(
					onTap: { print("onTap: calling") },
					icon: "i-calling"
				)
			}
		}
		.padding(12)
		.background(.sGrey)
		.clipShape(.capsule)
	}

	@ViewBuilder
	private func HistoryView() -> some View {
		VStack(spacing: 8) {
			ForEach(orders, id: \.id) { order in
				BoxCardView(order: order)
			}
		}
	}

	@ViewBuilder
	private func FooterView() -> some View {
		GradientButtonView(onTap: { print("onTap: tracking") }) {
			HStack(spacing: 8) {
				Text("Tracking")
					.poppins(16, .medium)
				Image(.iTracking)
					.resizable()
					.frame(width: 24, height: 24)
			}
		}
	}
}
