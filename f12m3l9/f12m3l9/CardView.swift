// by mioe

import SwiftUI

struct Option: Identifiable, Hashable {
	let id = UUID()
	let title: String
	let icon: String
}

let options = [
	Option(title: "USDT", icon: "atom"),
	Option(title: "BNB", icon: "bitcoinsign"),
]

struct CardView: View {
	let color: Color
	@Binding var selected: Option
	@Binding var inputValue: String
	let isTop: Bool
	let balance: String
	let topLabel: String

	var body: some View {
		VStack(alignment: .leading) {
			Text(topLabel)
				.font(.system(size: 12))

			Spacer()

			HStack {
				Menu {
					ForEach(options) { option in
						Button {
							selected = option
						} label: {
							Label(option.title, systemImage: option.icon)
						}
					}
				} label: {
					HStack {
						HStack {
							Image(systemName: selected.icon)
						}
						.frame(width: 40, height: 40)
						.background(.white.opacity(0.25))
						.clipShape(Circle())
						Text(selected.title)
					}
					.frame(width: 120, alignment: .leading)
				}

				Spacer()

				HStack(alignment: .bottom) {
					TextField("", text: $inputValue)
						.multilineTextAlignment(.trailing)
						.font(.system(size: 28, weight: .medium))
						.keyboardType(.decimalPad)
					Text(selected.title)
						.font(.system(size: 12))
						.textCase(.uppercase)
						.foregroundStyle(color.opacity(0.75))
						.padding(.bottom, 4)
				}
			}
			.padding(isTop ? .top : .bottom, 12)
			.padding(.horizontal, 8)

			Spacer()

			Text("Balance \(balance)")
				.font(.system(size: 12))
				.foregroundStyle(color.opacity(0.75))
		}
		.padding(16)
		.foregroundStyle(color)
	}
}
