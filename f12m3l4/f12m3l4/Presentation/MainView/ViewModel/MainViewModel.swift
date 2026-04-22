// by mioe

import Foundation
import Combine

class MainViewModel: ObservableObject { // обычный store аля pinia
	@Published var tweets: [TweetModel] = []
	@Published var idle = false
	@Published var cursor = 0
	
	private let networkClient = NetworkManager()
	
	func setup() {
		self.tweets = TweetModel.mock()
		self.cursor = self.tweets.count - 1
	}
	
	func add() {
		
	}
	
	func remove() {
		
	}
	
	func reset() {
		self.setup()
	}
}
