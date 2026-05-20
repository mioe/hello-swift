// by mioe
//

public import CoreData
public import Foundation

public typealias NoteCoreDataClassSet = NSSet

@objc(Note)
public class Note: NSManagedObject {

}

public typealias NoteCoreDataPropertiesSet = NSSet

extension Note {

	@nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
		return NSFetchRequest<Note>(entityName: "Note")
	}

	@NSManaged public var content: String?
	@NSManaged public var createdAt: Date
	@NSManaged public var id: UUID
	@NSManaged public var name: String
	@NSManaged public var updatedAt: Date
	@NSManaged public var attachments: NSOrderedSet

	public override nonisolated func awakeFromInsert() {
		super.awakeFromInsert()
		setPrimitiveValue(UUID(), forKey: "id")
		setPrimitiveValue(Date(), forKey: "createdAt")
		setPrimitiveValue(Date(), forKey: "updatedAt")
	}
}

// MARK: Generated accessors for attachments
extension Note {

	@objc(addAttachmentsObject:)
	@NSManaged public func addToAttachments(_ value: Attachment)

	@objc(removeAttachmentsObject:)
	@NSManaged public func removeFromAttachments(_ value: Attachment)

	@objc(addAttachments:)
	@NSManaged public func addToAttachments(_ values: NSSet)

	@objc(removeAttachments:)
	@NSManaged public func removeFromAttachments(_ values: NSSet)

}

extension Note: Identifiable {

}
