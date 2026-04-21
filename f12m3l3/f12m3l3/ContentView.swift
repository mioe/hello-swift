// by mioe

import SwiftUI

struct ContentView: View {
	var body: some View {
		ScrollView {
			VStack(alignment: .leading) {
				HeaderView()
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
			VStack(alignment: .leading) {
				Text("Welcome Back 👋🏻")
					.iAWritterQuattroS(.regular, 12)
					.foregroundStyle(.sSecondary)
				Text("Willy Draw")
					.lora(.medium, 24)
					.foregroundStyle(.sAccent)
			}
			
			Spacer()
			
			Button {
				print("onTap: bell")
			} label: {
				VStack {
					Image(systemName: "bell.fill")
						.font(.system(size: 18))
						.foregroundStyle(.white)
				}
				.frame(width: 48, height: 48)
				.background(.black)
				.clipShape(RoundedRectangle(cornerRadius: 16))
			}
			.buttonStyle(.plain)
		}
	}
}
