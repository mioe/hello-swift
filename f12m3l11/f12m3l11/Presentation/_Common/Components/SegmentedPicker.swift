// by mioe

import SwiftUI

struct SegmentedPicker<Option: Hashable & CustomStringConvertible>: View {
	let options: [Option]
	@Binding var selection: Option
	@Namespace private var namespace

	@Environment(ThemeStore.self) private var theme

	private var bgPicker: Color {
		switch theme.current {
		case .hacker: .hackerBackground
		case .pornhub: .pornhubBackground
		case .japan: .japanBackground
		case .youtube: .youtubeSecondary.opacity(0.15)
		}
	}
	
	private var accentPicker: Color {
		switch theme.current {
		case .hacker: .hackerAccent
		case .pornhub: .pornhubAccent
		case .japan: .white
		case .youtube: .white
		}
	}
	
	private var thumbPicker: Color {
		switch theme.current {
		case .hacker: .hackerAccent.opacity(0.15)
		case .pornhub: .pornhubAccent.opacity(0.15)
		case .japan: .japanAccent
		case .youtube: .youtubeAccent
		}
	}
	
	private var secondaryPicker: Color {
		switch theme.current {
		case .hacker: .hackerSecondary
		case .pornhub: .pornhubSecondary
		case .japan: .japanSecondary
		case .youtube: .youtubeSecondary
		}
	}

	var body: some View {
		HStack(spacing: 0) {
			ForEach(options, id: \.self) { option in
				segment(for: option)
			}
		}
		.padding(3)
		.background(bgPicker)
		.clipShape(.capsule)
	}

	private func segment(for option: Option) -> some View {
		let isSelected = selection == option

		return Button {
			withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
				selection = option
			}
		} label: {
			Text(option.description)
				.textCase(option.description == "All" ? .none : .uppercase)
				.font(.system(size: 14, weight: .medium))
				.foregroundStyle(isSelected ? accentPicker : secondaryPicker)
				.frame(maxWidth: .infinity)
				.padding(.vertical, 3)
				.contentShape(Capsule())
				.background {
					if isSelected {
						Capsule()
							.fill(thumbPicker)
							.matchedGeometryEffect(id: "pill", in: namespace)
					}
				}
		}
		.buttonStyle(.plain)
	}
}
