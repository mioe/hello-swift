// by mioe

import SwiftUI

struct MainView: View {
	@StateObject var viewModel = MainViewModel() // тика let store = useStore() в pinia
	
	var body: some View {
		GeometryReader {
			let safeAreaInsets = $0.safeAreaInsets
			
			NavigationStack {
				PullEffectScrollView(
					dragDistance: 130,
					actionTopPadding: safeAreaInsets.top + 32,
					leadingAction: .init(symbol: "arrow.clockwise", action: {
						print("Add New Tab")
					}),
					centerAction: .init(symbol: "plus", action: {
						print("Refresh")
					}),
					trailingAction: .init(symbol: "minus", action: {
						print("Close Tab")
					})
				) {
					HStack(spacing: 0) {
						VStack {
							Text("Hello world")
						}
						Spacer()
					}
					.padding(.horizontal, 32)
				}
				.navigationBarTitleDisplayMode(.inline)
			}
			.onAppear {
				viewModel.setup()
			}
		}
	}
}
