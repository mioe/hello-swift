// by mioe

import SwiftUI

struct MainView: View {
	
	@StateObject var viewModel = MainViewModel()
	
	var body: some View {
		VStack(spacing: 0) {
			ScrollView {
				Text("MainView")
			}
			.padding(32)
			.scrollClipDisabled()
			.scrollIndicators(.hidden)
			
			VStack(spacing: 16) {
				Divider()
				NoteFormView()
			}
			.frame(maxWidth: .infinity)
			.frame(alignment: .bottom)
			.background(.background)
		}
		.frame(maxWidth: .infinity)
		.onAppear {
			viewModel.getNotes()
		}
	}
}
