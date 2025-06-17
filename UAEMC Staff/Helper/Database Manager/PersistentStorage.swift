import Foundation
import CoreData

final class PersistentStorage {
    
    private init() { }
    static let shared = PersistentStorage()
    
    lazy var context = persistentContainer.viewContext
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UAEMC_Staff")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        #if DEBUG
        if let url = container.persistentStoreCoordinator.persistentStores.first?.url {
            print(url)
        }
        #endif
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
