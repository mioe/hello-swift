// by mioe

import Combine
import CoreData
import Foundation

class MainViewModel: ObservableObject {
	
	private var manager = CoreDataManager()
	@Published var notes: [Note] = []
	
	func getNotes() {
		self.notes = manager.fetchNotes()
	}
}
