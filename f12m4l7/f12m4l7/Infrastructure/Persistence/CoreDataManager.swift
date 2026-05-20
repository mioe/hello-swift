// by mioe

import CoreData
import Foundation

class CoreDataManager {

	// MARK: - Core Data stack

	lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "db")
		container.loadPersistentStores(completionHandler: {
			(storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()

	// MARK: - Core Data Saving support

	func saveContext() {
		let context = persistentContainer.viewContext
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}

	// MARK: - Short alias

	var viewContext: NSManagedObjectContext {
		persistentContainer.viewContext
	}

	// MARK: - Note CRUD

	@discardableResult
	func createNote(name: String, content: String? = nil) -> Note {
		let note = Note(context: viewContext)
		note.name = name
		note.content = content
		saveContext()
		return note
	}

	func fetchNotes(
		sortedBy keyPath: String = "createdAt",
		ascending: Bool = false
	) -> [Note] {
		let request = Note.fetchRequest()
		request.sortDescriptors = [
			NSSortDescriptor(key: keyPath, ascending: ascending)
		]
		do {
			return try viewContext.fetch(request)
		} catch {
			print("Failed to fetch notes: \(error)")
			return []
		}
	}

	func fetchNote(by id: UUID) -> Note? {
		let request = Note.fetchRequest()
		request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
		request.fetchLimit = 1
		return (try? viewContext.fetch(request))?.first
	}

	func updateNote(_ note: Note, name: String? = nil, content: String? = nil) {
		if let name { note.name = name }
		if let content { note.content = content }
		note.updatedAt = Date()
		saveContext()
	}

	func deleteNote(_ note: Note) {
		viewContext.delete(note)
		saveContext()
	}

	// MARK: - Attachment CRUD

	@discardableResult
	func createAttachment(
		name: String,
		data: Data? = nil,
		mimeType: String? = nil,
		fileSize: Int64 = 0,
		note: Note? = nil
	) -> Attachment {
		let attachment = Attachment(context: viewContext)
		attachment.name = name
		attachment.data = data
		attachment.mimeType = mimeType
		attachment.fileSize = fileSize
		if let note {
			attachment.note = note
			note.updatedAt = Date()
		}
		saveContext()
		return attachment
	}

	func fetchAttachments(
		for note: Note? = nil,
		sortedBy keyPath: String = "createdAt",
		ascending: Bool = false
	) -> [Attachment] {
		let request = Attachment.fetchRequest()
		if let note {
			request.predicate = NSPredicate(format: "note == %@", note)
		}
		request.sortDescriptors = [
			NSSortDescriptor(key: keyPath, ascending: ascending)
		]
		do {
			return try viewContext.fetch(request)
		} catch {
			print("Failed to fetch attachments: \(error)")
			return []
		}
	}

	func fetchAttachment(by id: UUID) -> Attachment? {
		let request = Attachment.fetchRequest()
		request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
		request.fetchLimit = 1
		return (try? viewContext.fetch(request))?.first
	}

	func updateAttachment(
		_ attachment: Attachment,
		name: String? = nil,
		data: Data? = nil,
		mimeType: String? = nil,
		fileSize: Int64? = nil
	) {
		if let name { attachment.name = name }
		if let data { attachment.data = data }
		if let mimeType { attachment.mimeType = mimeType }
		if let fileSize { attachment.fileSize = fileSize }
		attachment.note?.updatedAt = Date()
		saveContext()
	}

	func deleteAttachment(_ attachment: Attachment) {
		attachment.note?.updatedAt = Date()
		viewContext.delete(attachment)
		saveContext()
	}
}
