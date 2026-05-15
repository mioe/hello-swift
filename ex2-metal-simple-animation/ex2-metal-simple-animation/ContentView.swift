// by mioe

import SwiftUI

struct ContentView: View {

	var body: some View {
		ZStack {
			RingSceneView()
				.ignoresSafeArea()

			Button {} label: {
				VStack {
					Text("🐥🐥🐣")
				}
				.padding(.vertical, 8)
				.padding(.horizontal, 16)
			}
			.buttonStyle(.glass)
		}
	}
}

// MARK: - RingSceneView

private struct RingSceneView: View {

	var body: some View {
		GeometryReader { proxy in
			let size = proxy.size
			TimelineView(.animation) { context in
				let time = Float(
					context.date.timeIntervalSinceReferenceDate
						.truncatingRemainder(dividingBy: 1000)
				)
				Rectangle()
					.colorEffect(ShaderLibrary.ringScene(
						.float(time),
						.float2(Float(size.width / 2), Float(size.height / 2))
					))
			}
		}
	}
}
