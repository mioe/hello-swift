// by mioe

import SwiftUI

struct ContentView: View {
	@AppStorage("f12m3l10:isShowOnboardingView")
	private var isShowOnboardingView: Bool = true

	var body: some View {
//		ZStack {
//			if isShowOnboardingView == false {
				OnboardingView(onSubmit: {
					isShowOnboardingView.toggle()
				})
//			} else {
//				PackagesView()
//			}
//		}
//		.onAppear {
//			for f in UIFont.familyNames.filter({
//				$0.hasPrefix("Poppins")
//			}) {
//				let v = UIFont.fontNames(forFamilyName: f)
//				print("\(f): \(v)")
//			}
//		}
	}
}
