// by mioe

import SwiftUI

struct CategoryCardView: View {

	let category: Category

	private var iconName: String {
		switch category.name {
		case "Beverages": "cup.and.saucer"
		case "Foods": "fork.knife"
		case "Desserts": "birthday.cake"
		default: "square.grid.2x2"
		}
	}

	var body: some View {
		ZStack(alignment: .bottomLeading) {
			Image(systemName: iconName)
				.font(.system(size: 80))
				.foregroundStyle(.white.opacity(0.1))
				.frame(
					maxWidth: .infinity,
					maxHeight: .infinity,
					alignment: .bottomTrailing
				)
				.offset(x: 22, y: 14)

			VStack(alignment: .leading, spacing: 16) {
				VStack {
					Image(systemName: iconName)
						.font(.system(size: 40))
						.foregroundStyle(.white)
				}
				.frame(width: 48, height: 48)

				VStack(alignment: .leading, spacing: 4) {
					Text(category.name)
						.lora(18)
						.foregroundStyle(.white)

					Text("\(category.menusCount) Menus")
						.iAWritterQuattroS(14)
						.foregroundStyle(.sSecondary)
				}

				Spacer()
			}

		}
		.padding(.top, 20)
		.padding(.leading, 18)
		.frame(width: 148, height: 156)
		.background(.sAccent)
		.clipShape(.rect(cornerRadius: 24))
		.shadow(color: .black.opacity(0.14), radius: 22, x: 0, y: 11)
	}
}
