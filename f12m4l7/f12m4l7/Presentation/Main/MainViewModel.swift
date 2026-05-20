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

	func createNote(name: String, content: String, imageDatas: [Data]) {
		let note = manager.createNote(
			name: name,
			content: content.isEmpty ? nil : content
		)
		for data in imageDatas {
			manager.createAttachment(
				name: "image",
				data: data,
				mimeType: "image/jpeg",
				fileSize: Int64(data.count),
				note: note
			)
		}
		getNotes()
	}

	func updateNote(
		_ note: Note,
		name: String,
		content: String,
		imageDatas: [Data]
	) {
		let existing = note.attachments.array.compactMap { $0 as? Attachment }
		for attachment in existing {
			manager.deleteAttachment(attachment)
		}
		manager.updateNote(note, name: name, content: content)
		for data in imageDatas {
			manager.createAttachment(
				name: "image",
				data: data,
				mimeType: "image/jpeg",
				fileSize: Int64(data.count),
				note: note
			)
		}
		getNotes()
	}

	func deleteNote(_ note: Note) {
		manager.deleteNote(note)
		getNotes()
	}
}
