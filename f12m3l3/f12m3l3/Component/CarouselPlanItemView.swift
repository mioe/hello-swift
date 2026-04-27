// by mioe

import SwiftUI

struct CarouselPlanItemView: View {
	
	var img: String
	var label: String
	var deadline: Int
	var costMin: Int
	
	var body: some View {
		ZStack(alignment: .top) {
			Image(img)
				.resizable()
				.scaledToFill()
			
			LinearGradient(
				colors: [.clear, .black.opacity(0.6)],
				startPoint: .leading,
				endPoint: .trailing
			)
			
			VStack(alignment: .trailing, spacing: 0) {
				Spacer()
				VStack(alignment: .trailing, spacing: 6) {
					Text(label)
						.lora(.medium, 20)
						.foregroundStyle(.white)
						.multilineTextAlignment(.trailing)
						.padding(.leading, 16)
					VStack(alignment: .trailing, spacing: 3) {
						HStack(spacing: 3) {
							Text("\(deadline) days")
								.iAWritterQuattroS(.regular, 10)
							Image(systemName: "calendar")
								.font(.system(size: 10))
						}
						HStack(spacing: 3) {
							Text("\(costMin) min/day")
								.iAWritterQuattroS(.regular, 10)
							Image(systemName: "timer")
								.font(.system(size: 10))
						}
					}
					.foregroundStyle(.white)
				}
				Spacer()
				Spacer()
				Button {
					print("onTap: start")
				} label: {
					HStack {
						Spacer()
						CropperIconPlayView()
						Text("Start Now")
							.lora(.medium, 12)
							.foregroundStyle(.white)
						Spacer()
					}
					.padding(.vertical, 10)
					.background {
						RoundedRectangle(cornerRadius: 16)
							.glassEffect(in: RoundedRectangle(cornerRadius: 16))
					}
				}
				.buttonStyle(.plain)
			}
			.padding(12)
		}
		.frame(width: 140, height: 200)
		.clipShape(RoundedRectangle(cornerRadius: 22))
	}
}
