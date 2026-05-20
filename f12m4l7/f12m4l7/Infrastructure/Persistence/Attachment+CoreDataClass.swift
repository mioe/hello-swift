// by mioe
//

public import CoreData
public import Foundation

public typealias AttachmentCoreDataClassSet = NSSet

@objc(Attachment)
public class Attachment: NSManagedObject {

}

public typealias AttachmentCoreDataPropertiesSet = NSSet

extension Attachment {

	@nonobjc public class func fetchRequest() -> NSFetchRequest<Attachment> {
		return NSFetchRequest<Attachment>(entityName: "Attachment")
	}

	@NSManaged public var createdAt: Date
	@NSManaged public var data: Data?
	@NSManaged public var fileSize: Int64
	@NSManaged public var id: UUID
	@NSManaged public var mimeType: String?
	@NSManaged public var name: String
	@NSManaged public var note: Note?

	public override nonisolated func awakeFromInsert() {
		super.awakeFromInsert()
		/// аналог `= UUID()` и `= Date()` в SwiftData
		setPrimitiveValue(UUID(), forKey: "id")
		setPrimitiveValue(Date(), forKey: "createdAt")
	}
}

extension Attachment: Identifiable {

}
