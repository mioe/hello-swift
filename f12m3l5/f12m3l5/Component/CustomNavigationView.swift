// by mioe

import SwiftUI

struct CustomNavigationItemView: View {

	let icon: String
	let onTap: () -> Void

	var body: some View {
		Button {
			onTap()
		} label: {
			Image(systemName: icon)
				.font(.system(size: 18, weight: .medium))
				.frame(width: 40, height: 40)
				.contentShape(Circle())  // дает кликабильную зону (если нет background-а)
		}
		.buttonStyle(.plain)
	}
}

struct CustomNavigationView<Leading: View, Trailing: View>: View {

	let title: String
	let leading: Leading
	let trailing: Trailing

	init(
		title: String,
		@ViewBuilder leading: () -> Leading,
		@ViewBuilder trailing: () -> Trailing
	) {
		self.title = title
		self.leading = leading()
		self.trailing = trailing()
	}

	var body: some View {
		HStack {
			HStack {
				leading
			}
			.frame(minWidth: 40, minHeight: 40)

			Spacer()

			Text(title)
				.lora(18)

			Spacer()

			HStack {
				trailing
			}
			.frame(minWidth: 40, minHeight: 40)
		}
	}
}

// MARK: - дефолтные слоты

extension CustomNavigationView where Trailing == EmptyView {
	init(
		title: String,
		@ViewBuilder leading: () -> Leading
	) {
		self.init(
			title: title,
			leading: leading,
			trailing: { EmptyView() }
		)
	}
}

extension CustomNavigationView
where Leading == EmptyView, Trailing == EmptyView {
	init(title: String) {
		self.init(
			title: title,
			leading: { EmptyView() },
			trailing: { EmptyView() }
		)
	}
}
