import Foundation
import CoreData

//MARK: Singleton

class DatabaseHelper {
    
    private init() { }
    static let shared = DatabaseHelper()
    
    //MARK: Methods
    
    func createCheckinDetails(details: CheckInModel) {
        let checkIn = CheckIn(context: PersistentStorage.shared.context)
        checkIn.checkInStatus = details.checkInStatus.rawValue
        checkIn.elapsedTime = Int64(details.elapsedTime)
        checkIn.firstIn = details.checkInTime
        checkIn.workMode = details.workMode
        checkIn.location = details.location
        checkIn.lastout = details.checkOutTime
        checkIn.checkInDate = details.checkInDate
        PersistentStorage.shared.saveContext()
    }
    
    func fetchCheckInDetails() -> CheckInModel? {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(CheckIn.fetchRequest()) as? [CheckIn] else { return nil }
            return CheckInModel(
                checkInStatus: result.first?.checkInStatus == "In" ? .checkedIn : result.first?.checkInStatus == "Out" ? .checkedOut : .unknown,
                elapsedTime: Int(result.first?.elapsedTime ?? 0),
                checkInTime: result.first?.firstIn,
                checkOutTime: result.first?.lastout,
                workMode: result.first?.workMode,
                location: result.first?.location,
                checkInDate: result.first?.checkInDate
            )
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    
    func updateCheckInDetails(details: CheckInModel) {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(CheckIn.fetchRequest()) as? [CheckIn] else { return }
            result.first?.checkInStatus = details.checkInStatus.rawValue
            result.first?.elapsedTime = Int64(details.elapsedTime)
            result.first?.firstIn = details.checkInTime
            result.first?.workMode = details.workMode
            result.first?.location = details.location
            result.first?.lastout = details.checkOutTime
            result.first?.checkInDate = details.checkInDate
            
            PersistentStorage.shared.saveContext()
        } catch let error {
            debugPrint(error)
        }
    }
    
    func deleteCheckInDetails() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CheckIn")
        if  let result = try?  PersistentStorage.shared.context.fetch(fetchRequest){
            for object in result {
                PersistentStorage.shared.context.delete(object as! NSManagedObject)
            }
        }
        do{
            try PersistentStorage.shared.context.save()
        } catch let error as NSError {
            debugPrint(error)
        }
    }
}
