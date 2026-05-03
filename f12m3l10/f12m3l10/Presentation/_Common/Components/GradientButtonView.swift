// by mioe

import SwiftUI

struct GradientButtonView<Label: View>: View {
	let onTap: () -> Void
	@ViewBuilder let label: () -> Label

	var body: some View {
		Button {
			onTap()
		} label: {
			label()
				.foregroundStyle(.white)
				.frame(height: 56)
				.frame(maxWidth: .infinity)
				.background {
					LinearGradient(
						colors: [.sOrange, .sAccent],
						startPoint: .leading,
						endPoint: .trailing
					)
				}
				.clipShape(Capsule())
		}
		.buttonStyle(.plain)
	}
}
