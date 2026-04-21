// by mioe

import SwiftUI

struct ContentView: View {
	var body: some View {
		ScrollView {
			VStack(alignment: .leading) {
				
			}
		}
		.scrollClipDisabled()
		.scrollIndicators(.hidden)
		.padding(.top, 32)
		.padding(.horizontal, 32)
		.onAppear {
			// вывод списка доступных шрифтов
			for f in UIFont.familyNames.filter({ $0.hasPrefix("iA") || $0.hasPrefix("Lora") }) {
				let v = UIFont.fontNames(forFamilyName: f)
				print("\(f): \(v)")
			}
		}
	}
	
	@ViewBuilder
	private func HeaderView() -> some View {
		HStack {
			
		}
	}
}
