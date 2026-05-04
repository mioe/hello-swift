// by mioe

import SwiftUI

struct ArticleCardView: View {
	
	let article: Article
	let accentColor: Color
	
	var body: some View {
		Button {} label: {
			ZStack(alignment: .bottom) {
				
					HStack {
						Image(article.img)
							.resizable()
							.scaledToFill()
							.frame(width: 92, height: 92)
							.clipShape(.rect(cornerRadius: 20))
					}
					.frame(width: 100, height: 100)
					.background(accentColor.opacity(0.3))
			
					Text(article.text)
						.font(.system(size: 12, weight: .semibold))
						.foregroundStyle(.white)
						.multilineTextAlignment(.leading)
						.padding(10)
						.frame(alignment: .leading)
				
			}
			.frame(width: 100, height: 100)
			.clipShape(.rect(cornerRadius: 24))
			.overlay {
				RoundedRectangle(cornerRadius: 24)
					.strokeBorder(accentColor, style: StrokeStyle(lineWidth: 2))
			}
		}
	}
}
