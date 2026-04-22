// by mioe

import SwiftUI

struct TweetHeaderView: View {

	let username: String
	let nickname: String
	let createdAt: Date
	let visualType: TweetVisualType

	private var tintColorPrimary: Color {
		visualType == .card ? .primary : .white
	}

	private var tintColorSecondary: Color {
		visualType == .card ? .secondary : .white
	}

	var body: some View {
		HStack(spacing: 0) {
			HStack(spacing: 8) {
				Text(username)
					.font(.system(size: 12, weight: .medium))
					.foregroundStyle(tintColorPrimary)
				HStack(spacing: 8) {
					Text("@\(nickname)")
					Text(Self.relativeDate(from: createdAt))
				}
				.font(.system(size: 10))
				.foregroundStyle(tintColorSecondary)
			}
			Spacer(minLength: 0)  // ура, понадобился обнуления так как выше spacing: 8
		}
	}

	private static func relativeDate(from date: Date) -> String {
		let seconds = Int(Date().timeIntervalSince(date))
		switch seconds {
		case ..<60: return "\(seconds)s"
		case ..<3600: return "\(seconds / 60)m"
		case ..<86400: return "\(seconds / 3600)h"
		case ..<604800: return "\(seconds / 86400)d"
		case ..<2_592_000: return "\(seconds / 604800)w"
		default: return "\(seconds / 2_592_000)mo"
		}
	}
}
