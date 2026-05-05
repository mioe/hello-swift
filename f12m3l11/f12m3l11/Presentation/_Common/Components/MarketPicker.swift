// by mioe

import SwiftUI

struct MarketPicker<Option: Hashable & CustomStringConvertible>: View {

	@Environment(ThemeStore.self) private var theme

	let options: [Option]
	@Binding var selection: Option
	@Namespace private var namespace

	var body: some View {
		HStack(spacing: 0) {
			ForEach(Array(options.enumerated()), id: \.offset) { idx, option in
				segment(for: option)
				if idx < options.count - 1 {
					Spacer()
				}
			}
		}
	}

	private func segment(for option: Option) -> some View {
		let isSelected = selection == option

		return Button {
			selection = option
		} label: {
			HStack(spacing: 2) {
				Text(option.description)
					.font(.system(size: 14, weight: .medium))
				Image(.iSort)
					.resizable()
					.frame(width: 20, height: 20)
			}
			.foregroundStyle(
				isSelected
					? theme.current == .youtube
						? .white
						: theme.accent
					: theme.secondary
			)
			.padding(.vertical, 4)
			.padding(.leading, 8)
			.padding(.trailing, 4)
			.contentShape(.rect(cornerRadius: 12))
			.background {
				if isSelected {
					RoundedRectangle(cornerRadius: 12)
						.fill(
							theme.current == .youtube
								? theme.accent
								: theme.backgroundForeground
						)
				}
			}
		}
		.buttonStyle(.plain)
	}
}
