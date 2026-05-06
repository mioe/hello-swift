// by mioe

import Combine
import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
	@Published var tweets: [Tweet] = []
	@Published var idle = false
	@Published var actionLabel = ""
	@Published var errorMessage: String?

	private let networkClient = NetworkManager()
	private let initialPageSize = 3

	func setup() {
		actionLabel = "Инициализация tweet-ов"
		idle = false
		errorMessage = nil

		Task {
			do {
				let fetched = try await networkClient.getMockF12m4l1(
					page: 1,
					limit: initialPageSize,
					createdAt: .desc
				)
				tweets = fetched
			} catch {
				errorMessage = "Не удалось загрузить: \(error.localizedDescription)"
			}
			idle = true
		}
	}

	func add() {
		actionLabel = "Подгрузка tweet-а"
		idle = false
		errorMessage = nil

		let nextPage = tweets.count + 1

		Task {
			do {
				let fetched = try await networkClient.getMockF12m4l1(
					page: nextPage,
					limit: 1,
					createdAt: .desc
				)
				tweets.append(contentsOf: fetched)
			} catch {
				errorMessage = "Не удалось подгрузить: \(error.localizedDescription)"
			}
			idle = true
		}
	}

	func remove() {
		actionLabel = "Удаление последнего tweet-а"
		idle = false

		if !tweets.isEmpty {
			tweets.removeLast()
		}
		idle = true
	}

	func reset() {
		tweets = []
		setup()
	}
}
