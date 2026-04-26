// by mioe

import SwiftUI

struct CarouselCategoryItemView: View {
	let icon: String
	let label: String
	
	var body: some View {
		VStack(spacing: 6) {
			Image(icon)
				.resizable()
				.scaledToFill()
				.padding(2)
				.background(.sAccentForeground)
				.clipShape(RoundedRectangle(cornerRadius: 16))
				
			Text(label)
				.iAWritterQuattroS(.regular, 14)
		}
	}
}
