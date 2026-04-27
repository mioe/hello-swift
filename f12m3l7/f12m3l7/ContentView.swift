// by mioe

import SwiftUI

struct ContentView: View {
	var body: some View {
		VStack(spacing: 32) {
			VStack {
				UIImageRepresentable()
					.frame(width: 48, height: 48)
				Text("Misha Gezha")
			}

			UIButtonRepresentable(
				title: "Subscribe",
				action: { print("onTap: subscribe") }
			)
			.frame(height: 48)
		}
		.padding(32)
	}
}

struct UIImageRepresentable: UIViewRepresentable {

	func makeUIView(context: Context) -> some UIImageView {
		{
			$0.image = ._1775640178368
			// не работает, в SwiftUI размером UIViewRepresentable управляет layout-движок SwiftUI, а не внутренние констрейнты UIView. SwiftUI спрашивает у обёрнутой view её intrinsicContentSize (а у UIImageView это просто размер самой картинки) и предлагает ей это пространство.
			//			$0.widthAnchor.constraint(equalToConstant: 48).isActive = true
			//			$0.heightAnchor.constraint(equalToConstant: 48).isActive = true

			$0.layer.cornerRadius = 24
			$0.clipsToBounds = true

			// > https://stackoverflow.com/a/59745779 - $0.contentMode = .scaleAspectFill
			$0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
			$0.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
			return $0
		}(UIImageView())
	}

	func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct UIButtonRepresentable: UIViewRepresentable {
	typealias UIViewType = UIButton
	var title: String
	var action: () -> Void

	func makeUIView(context: Context) -> UIButton {
		let btn = UIButton()
		btn.setTitle(title, for: .normal)
		btn.addAction(
			UIAction(handler: { _ in
				action()
			}),
			for: .touchUpInside
		)
		btn.backgroundColor = .systemOrange
		btn.setTitleColor(.white, for: .normal)
		btn.layer.cornerRadius = 16
		btn.clipsToBounds = true
		return btn
	}

	func updateUIView(_ uiView: UIViewType, context: Context) {}
}
