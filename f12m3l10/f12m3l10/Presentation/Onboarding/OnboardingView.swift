// by mioe

import SwiftUI

struct OnboardingView: View {

	let onSubmit: () -> Void

	var body: some View {
		VStack {
			Text("OnboardingView")

			Spacer()

			GradientButtonView(onTap: { onSubmit() }) {
				HStack(spacing: 8) {
					Text("Check your packages")
						.poppins(16, .medium)
					Image(.arrow)
						.resizable()
						.frame(width: 24, height: 24)
				}
			}
		}
		.padding(.horizontal, 26)
	}
}
