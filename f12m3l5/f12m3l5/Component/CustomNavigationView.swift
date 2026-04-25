// by mioe

import SwiftUI

struct CustomNavigationView: View {
	
	let title: String
	
	var body: some View {
		HStack {
			Button {
				
			} label: {
				Image(systemName: "arrow.left")
					.font(.system(size: 18, weight: .medium))
					.frame(width: 40, height: 40)
					.contentShape(Circle())  // дает кликабильную зону (если нет background-а)
			}
			.buttonStyle(.plain)
			
			Spacer()
			
			Text(title)
				.lora(18)
			
			Spacer()
			
			Button {
				print("onTap: bookmark")
			} label: {
				Image(systemName: "bookmark")
					.font(.system(size: 18, weight: .medium))
					.frame(width: 40, height: 40)
					.contentShape(Circle())
			}
			.buttonStyle(.plain)
		}
	}
}
