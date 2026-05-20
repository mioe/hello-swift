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

	// MARK: - CRUD

	func setNote(name: String, text: String) {
		let note = Note(context: persistentContainer.viewContext)
		note.id = UUID()
		note.name = name
		note.text = text
		note.date = Date()

		saveContext()
	}

	func patchNote(id: UUID, name: String, text: String) {
		let req = Note.fetchRequest()
		req.predicate = NSPredicate(format: "id == %@", id.uuidString)

		if let notes = try? persistentContainer.viewContext.fetch(req),
			let note = notes.first
		{
			note.name = name
			note.text = text
			note.date = Date()

			saveContext()
		}
	}

	func getNote() -> [Note] {
		let req = Note.fetchRequest()
		req.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
		//		request.predicate = NSPredicate(SQL)

		if let notes = try? persistentContainer.viewContext.fetch(req) {
			return notes
		} else {
			return []
		}
	}

	func removeNote(id: UUID) {
		let req = Note.fetchRequest()
		req.predicate = NSPredicate(format: "id == %@", id.uuidString)

		if let notes = try? persistentContainer.viewContext.fetch(req),
			let note = notes.first
		{
			persistentContainer.viewContext.delete(note)

			saveContext()
		}
	}

}
