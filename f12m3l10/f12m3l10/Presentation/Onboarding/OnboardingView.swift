// by mioe

import SwiftUI

struct OnboardingView: View {

	let onSubmit: () -> Void

	var body: some View {
		VStack(spacing: 28) {
			VStack(spacing: 4) {
				HStack(spacing: 8) {
					Image(.iBox)
						.resizable()
						.frame(width: 20, height: 20)
					Text("3000+ Successful Delivery")
						.poppins(16, .medium)
				}
				.foregroundStyle(.sAccent)
				
				VStack(spacing: 0) {
					Text("Your Ultimate")
						.poppins(28)
						.foregroundStyle(.sPrimary)
					Text("Shipping Company")
						.poppins(28, .semiBold)
						.foregroundStyle(
							LinearGradient(
								colors: [.sOrange, .sAccent],
								startPoint: .leading,
								endPoint: .trailing
							)
						)
				}
			}
			
			VStack(spacing: 16) {
				HStack {
					Image(.onboardingX2)
						.resizable()
						.scaledToFill()
				}
				.frame(height: 331)
				
				HStack(spacing: 4) {
					Text("2 active packages")
						.poppins(12, .medium)
						.foregroundStyle(.sPrimary)
					
					HStack(spacing: -4) {
						Circle()
							.fill(.sGreen)
							.frame(width: 10, height: 10)
						Circle()
							.fill(.sAccent)
							.frame(width: 10, height: 10)
					}
				}
				.padding(.vertical, 4)
				.padding(.horizontal, 12)
				.background(.sGrey)
				.clipShape(Capsule())
			}

			Spacer()

			GradientButtonView(onTap: { onSubmit() }) {
				HStack(spacing: 8) {
					Text("Check your packages")
						.poppins(16, .medium)
					Image(.iArrow)
						.resizable()
						.frame(width: 24, height: 24)
				}
			}
		}
		.padding(.top, 80)
		.padding(.horizontal, 26)
	}
}
