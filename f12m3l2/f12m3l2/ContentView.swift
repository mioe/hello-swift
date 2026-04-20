// by mioe

import SwiftUI

struct ContentView: View {
	var body: some View {
		ZStack(alignment: .top) {
			HeaderView()
			
			ScrollView {
				
			}
			.scrollClipDisabled()
			.scrollIndicators(.hidden)
		}
		.padding(.top, 32)
		.padding(.horizontal, 32)
	}
	
	@ViewBuilder
	private func HeaderView() -> some View {
		HStack {
			Button {
				print("onTap: back")
			} label: {
				Image(systemName: "chevron.backward")
					.foregroundStyle(.sGreyDark)
			}
			.buttonStyle(.plain)
			.frame(width: 48, height: 48)
			.background(.sGreySoft1)
			.clipShape(Circle())
			.shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
			
			Spacer()
			
			Button {
				print("onTap: more")
			} label: {
				Image(systemName: "ellipsis")
					.foregroundStyle(.sGreyDark)
			}
			.buttonStyle(.plain)
			.frame(width: 40, height: 40)
			.background(.background)
			.clipShape(RoundedRectangle(cornerRadius: 12))
			.overlay {
				RoundedRectangle(cornerRadius: 12)
					.strokeBorder(.sGreySoft2, lineWidth: 1)
			}
		}
	}
}
