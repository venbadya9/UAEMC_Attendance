import Foundation
import CoreData


extension CheckIn {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CheckIn> {
        return NSFetchRequest<CheckIn>(entityName: "CheckIn")
    }

    @NSManaged public var checkInDate: Date?
    @NSManaged public var checkInStatus: String?
    @NSManaged public var elapsedTime: Int64
    @NSManaged public var firstIn: String?
    @NSManaged public var lastout: String?
    @NSManaged public var location: String?
    @NSManaged public var workMode: String?

}

extension CheckIn : Identifiable {

}
