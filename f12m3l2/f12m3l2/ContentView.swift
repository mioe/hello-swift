// by mioe

import SwiftUI

struct ContentView: View {
	@State var search = ""
	
	var body: some View {
		ZStack(alignment: .top) {
			HeaderView()
				.zIndex(1)
			
			ScrollView {
				VStack {
					SearchView(promt: $search)
				}
			}
			.scrollClipDisabled()
			.scrollIndicators(.hidden)
			.padding(.top, 48 + 32)
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
					.frame(width: 48, height: 48)
					.background(.sGreySoft1)
					.clipShape(Circle())
					.shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
			}
			.buttonStyle(.plain)
			
			Spacer()
			
			Button {
				print("onTap: more")
			} label: {
				Image(systemName: "ellipsis")
					.foregroundStyle(.sF12M3L2Accent)
					.background(.background)
					.frame(width: 40, height: 40)
					.clipShape(RoundedRectangle(cornerRadius: 12))
					.overlay {
						RoundedRectangle(cornerRadius: 12)
							.strokeBorder(.sGreySoft2, lineWidth: 1)
					}
			}
			.buttonStyle(.plain)
		}
	}
	
	@ViewBuilder
	private func SearchView(promt: Binding<String>) -> some View {
		HStack(spacing: 16) {
			Image(systemName: "magnifyingglass")
				.foregroundStyle(.sGreyDark)
			
			TextField("Search House, Apartment, etc", text: promt)
				.textFieldStyle(.plain)
				.frame(maxWidth: .infinity)
			
			Divider()
			
			Button {
				print("onTap: voice")
			} label: {
				Image(systemName: "mic")
					.foregroundStyle(.sGreyBarelyMedium)
			}
			.buttonStyle(.plain)
		}
		.padding(.horizontal, 16)
		.padding(.vertical, 16)
		.frame(height: 70)
		.background(.sGreySoft1)
		.clipShape(RoundedRectangle(cornerRadius: 24))
	}
}
