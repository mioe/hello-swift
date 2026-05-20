// by mioe
//

public import Foundation
public import CoreData

public typealias NoteCoreDataClassSet = NSSet

@objc(Note)
public class Note: NSManagedObject {

}

public typealias NoteCoreDataPropertiesSet = NSSet

extension Note {
	
	@nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
		return NSFetchRequest<Note>(entityName: "Note")
	}
	
	@NSManaged public var date: Date?
	@NSManaged public var id: UUID
	@NSManaged public var name: String
	@NSManaged public var text: String?
	
}

extension Note : Identifiable {
	
}

//extension Note {
//	func remove() {
//		managedObjectContext?.delete(self)
//		try? managedObjectContext?.save()
//	}
//}
