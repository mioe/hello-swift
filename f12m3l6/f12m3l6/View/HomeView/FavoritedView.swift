// by mioe

import SwiftUI

struct FavoritedView: View {
	
	@Environment(AppRouter.self) private var router
		
	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 32) {
				CustomNavigationView(title: "Favorited") {
					CustomNavigationItemView(
						icon: "arrow.left",
						onTap: { handleOpenBack() }
					)
				}
			}
		}
		.scrollClipDisabled()
		.scrollIndicators(.hidden)
		.toolbar(.hidden, for: .navigationBar)
		.padding(.horizontal, 32)
		.padding(.top, 20)
		.padding(.bottom, 64)
	}
	
	private func handleOpenBack() {
		router.pop()
	}
}
