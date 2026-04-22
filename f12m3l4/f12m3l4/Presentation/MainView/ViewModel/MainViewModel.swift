// by mioe

import Foundation
import Combine

class MainViewModel: ObservableObject { // обычный store аля pinia
	@Published var tweets: [TweetModel] = []
	@Published var idle = false
	@Published var actionLabel = ""
	
	private let networkClient = NetworkManager()
	
	func setup() {
		self.actionLabel = "Инициализация tweet-ов"
		self.idle = false
		
		// Фейковый Promise - имитация загрузки данных
		Task { @MainActor in
			try? await Task.sleep(for: .seconds(Int.random(in: 1...3)))
			self.tweets = networkClient.getTweetsApi(count: 0, chunk: 3)
			self.idle = true
		}
	}
	
	func add() {
		self.actionLabel = "Подгрузка tweet-а"
		self.idle = false
		
		Task { @MainActor in
			try? await Task.sleep(for: .seconds(Int.random(in: 1...2)))
			self.tweets.append(contentsOf: networkClient.getTweetsApi(count: tweets.count, chunk: 1))
			self.idle = true
		}
	}
	
	func remove() {
		self.actionLabel = "Удаления последнего tweet-а"
		self.idle = false
		
		Task { @MainActor in
			try? await Task.sleep(for: .seconds(Int.random(in: 1...2)))
			if tweets.count > 0 {
				self.tweets.removeLast()
			}
			self.idle = true
		}
	}
	
	func reset() {
		self.setup()
	}
}
