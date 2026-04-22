// by mioe

import SwiftUI

struct UserAvatarView: View {
	
	var avatar: String? = nil
	
	var body: some View {
		ZStack {
			if avatar != nil {
				Image(avatar!)
					.resizable()
					.scaledToFill()
					.clipShape(Circle())
			} else {
				Circle()
					.fill(.blue.opacity(0.8))
					.overlay {
						Text("🐥")
					}
			}
		}
		.frame(width: 48, height: 48)
	}
}
