// by mioe

import Combine
import CoreData
import Foundation

class ContentViewModel: ObservableObject {

	private var manager = CoreDataManager()
	@Published var notes: [Note] = []

	func setNote() {
		manager.setNote(name: "name", text: "text")
		self.getNote()
	}

	func getNote() {
		self.notes = manager.getNote()
	}

	func removeNote(id: UUID) {
		manager.removeNote(id: id)
		self.getNote()
	}

	func patchNote(id: UUID, name: String, text: String) {
		manager.patchNote(id: id, name: name, text: text)
		self.getNote()
	}
}
