// by mioe

import SwiftUI

struct TweetBodyView: View {
	let text: String
	let media: [String]
	let visualType: TweetVisualType

	private var tintColor: Color {
		visualType == .card ? .primary : .white
	}

	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(text)
				.font(.system(size: 14))
				.foregroundStyle(tintColor)

			if !media.isEmpty {
				mediaStack
					.clipShape(RoundedRectangle(cornerRadius: 8))
			}
		}
	}

	// AnyLayout позволяет менять контейнер динамически (iOS 16+)
	@ViewBuilder
	private var mediaStack: some View {
		let layout: AnyLayout =
			visualType == .card
			? AnyLayout(HStackLayout(spacing: 4))
			: AnyLayout(VStackLayout(spacing: 4))

		layout {
			ForEach(media, id: \.self) { name in
				Image(name)
					.resizable()
					.aspectRatio(contentMode: .fit)
			}
		}
		.frame(maxWidth: .infinity)
	}
}

#Preview {
	TweetBodyView(
		text:
			"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
		media: ["img-1", "img-2"],
		visualType: .card
	)
}
