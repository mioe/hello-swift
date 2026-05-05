// by mioe

import Foundation
import Observation
import SwiftUI

@Observable
@MainActor
final class ThemeStore {
	struct Palette {
		let accent: Color
		let background: Color
		let backgroundForeground: Color
		let primary: Color
		let secondary: Color
	}

	enum Theme: String, CaseIterable, Identifiable {
		case hacker, pornhub, japan, youtube

		var id: String { rawValue }

		var title: String {
			switch self {
			case .hacker: "Hacker"
			case .pornhub: "PornHub"
			case .japan: "Japan"
			case .youtube: "YouTube"
			}
		}

		var colorScheme: ColorScheme {
			switch self {
			case .hacker, .pornhub: .dark
			case .japan, .youtube: .light
			}
		}

		var palette: Palette {
			switch self {
			case .hacker:
				Palette(
					accent: .hackerAccent,
					background: .hackerBackground,
					backgroundForeground: .hackerBackgroundForeground,
					primary: .hackerPrimary,
					secondary: .hackerSecondary,
				)
			case .pornhub:
				Palette(
					accent: .pornhubAccent,
					background: .pornhubBackground,
					backgroundForeground: .pornhubBackgroundForeground,
					primary: .pornhubPrimary,
					secondary: .pornhubSecondary,
				)
			case .japan:
				Palette(
					accent: .japanAccent,
					background: .japanBackground,
					backgroundForeground: .japanBackgroundForeground,
					primary: .japanPrimary,
					secondary: .japanSecondary,
				)
			case .youtube:
				Palette(
					accent: .youtubeAccent,
					background: .youtubeBackground,
					backgroundForeground: .youtubeBackgroundForeground,
					primary: .youtubePrimary,
					secondary: .youtubeSecondary,
				)
			}
		}
	}

	private enum Keys {
		static let theme = "f12m3l11:theme"
	}

	var current: Theme {
		didSet {
			UserDefaults.standard.set(current.rawValue, forKey: Keys.theme)
		}
	}

	var accent: Color { current.palette.accent }
	var background: Color { current.palette.background }
	var backgroundForeground: Color { current.palette.backgroundForeground }
	var primary: Color { current.palette.primary }
	var secondary: Color { current.palette.secondary }
	var colorScheme: ColorScheme { current.colorScheme }

	init() {
		let raw = UserDefaults.standard.string(forKey: Keys.theme)
		self.current = raw.flatMap(Theme.init(rawValue:)) ?? .hacker
	}
}
