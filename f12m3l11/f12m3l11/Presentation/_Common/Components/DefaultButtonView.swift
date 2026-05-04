// by mioe

import SwiftUI

struct DefaultButtonView<Label: View>: View {
	let onTap: () -> Void
	let bgColor: Color
	@ViewBuilder let label: () -> Label
	
	var body: some View {
		Button {
			onTap()
		} label: {
			label()
				.frame(height: 48)
				.frame(maxWidth: .infinity)
				.background(bgColor)
				.clipShape(.rect(cornerRadius: 16))
		}
		.buttonStyle(.plain)
	}
}
