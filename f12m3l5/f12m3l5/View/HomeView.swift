// by mioe

import SwiftData
import SwiftUI

struct HomeView: View {
	var body: some View {
		ScrollView {
			VStack {
				HeaderView()
			}
		}
		.scrollClipDisabled()
		.scrollIndicators(.hidden)
		.padding(.top, 32)
		.padding(.horizontal, 32)
	}
	
	@ViewBuilder
	private func HeaderView() -> some View {
		HStack {
			VStack(alignment: .leading) {
				Text("Good Morning 👋🏻")
					.iAWritterQuattroS(12)
					.foregroundStyle(.sPrimary)
				Text("Misha Gezha")
					.lora(24)
					.foregroundStyle(.sAccent)
			}
			Spacer()
			ZStack(alignment: .topTrailing) {
				Image(._1775640178368)
					.resizable()
					.scaledToFill()
					.frame(width: 48, height: 48)
					.clipShape(Circle())

				Circle()
					.fill(.white)
					.frame(width: 18, height: 18)
					.overlay {
						Circle()
							.fill(.sSecondary)
							.frame(width: 12, height: 12)
					}
			}
		}
	}
}
