// by mioe

import Foundation
import Combine

class MainViewModel: ObservableObject { // обычный store аля pinia
	@Published var tweets: [TweetModel] = []
	@Published var idle = false
	@Published var actionLabel = ""
	@Published var cursor = 0
	
	private let networkClient = NetworkManager()
	
	func setup() {
		self.actionLabel = "Инициализация tweet-ов"
		self.idle = false
		
		// Фейковый Promise - имитация загрузки данных
		Task { @MainActor in
			try? await Task.sleep(for: .seconds(Int.random(in: 1...3)))
			self.tweets = TweetModel.mock()
			self.cursor = self.tweets.count - 1
			self.idle = true
		}
	}
	
	func add() {
		
	}
	
	func remove() {
		
	}
	
	func reset() {
		self.setup()
	}
}
