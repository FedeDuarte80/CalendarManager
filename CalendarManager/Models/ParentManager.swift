import Foundation
import CoreData

@MainActor
class ParentManager: ObservableObject {
    @Published var parents: [ParentEntity] = []
    @Published var deleteParent: Date?

    private let persistentContainer: NSPersistentContainer
    private let moc: NSManagedObjectContext

    init() {
        persistentContainer = NSPersistentContainer(name: "Manager")
        moc = persistentContainer.viewContext
        
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        fetchParents()
    }

    func fetchParents() {
        let request = NSFetchRequest<ParentEntity>(entityName: "ParentEntity")
        do {
            parents = try moc.fetch(request)
            print("fetchParents")
        } catch {
            print("Error fetching data \(error.localizedDescription)")
        }
    }
        
    func saveChanges() {
        do {
            try moc.save()
            print("saveChanges")
        } catch {
            print("Error saving changes \(error.localizedDescription)")
        }
    }
    
    func addParent(name: String, date: Date) {
        let p = ParentEntity(context: moc)
        p.name = name
        p.fullday = date
        do {
            try moc.save()
            parents.append(p)
        } catch {
            print("Failed to save \(p)")
        }
    }
    
    func delete(_ parent: ParentEntity) {
        if let index = parents.firstIndex(where: { $0.id == parent.id }) {
            deleteParent = parents[index].parentDay
            moc.delete(parents[index])
            saveChanges()
            objectWillChange.send()
            print("deleted \(index) from \(parent)")
        }
    }
}
/* Working persistentContainer + moc
 @MainActor
 class ParentManager: ObservableObject {
     @Published var parents: [ParentEntity] = []
     @Published var deleteParent: Date?

     private let persistentContainer: NSPersistentContainer
     private let moc: NSManagedObjectContext

     init() {
         persistentContainer = NSPersistentContainer(name: "Manager")
         moc = persistentContainer.viewContext
         
         persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
             if let error = error as NSError? {
                 fatalError("Unresolved error \(error), \(error.userInfo)")
             }
         })
         persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
         persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
         fetchParents()
     }

     func fetchParents() {
         let request = NSFetchRequest<ParentEntity>(entityName: "ParentEntity")
         do {
             parents = try moc.fetch(request)
         } catch {
             print("Error fetching data \(error.localizedDescription)")
         }
     }
         
     func saveChanges() {
         do {
             try moc.save()
             print("saveChanges")
         } catch {
             print("Error saving changes \(error.localizedDescription)")
         }
     }
     
     func addParent(name: String, date: Date) {
         let p = ParentEntity(context: moc)
         p.name = name
         p.fullday = date
         do {
             try moc.save()
             parents.append(p)
         } catch {
             print("Failed to save \(p)")
         }
     }
     
     func delete(_ parent: ParentEntity) {
         if let index = parents.firstIndex(where: { $0.id == parent.id }) {
             deleteParent = parents[index].parentDay
             moc.delete(parents[index])
             saveChanges()
             print("deleted \(index) from \(parent)")
         }
     }
 }
 */


/* Working
 @MainActor
 class ParentManager: ObservableObject {
     @Published var parents: [ParentEntity] = []
     @Published var deleteParent: Date?
     
     let persistentContainer: NSPersistentContainer
     
     init() {
         persistentContainer = NSPersistentContainer(name: "Manager")
         persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
             if let error = error as NSError? {
                 fatalError("Unresolver error \(error), \(error.userInfo)")
             }
         })
         persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
         persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
         fetchParents()
     }
     
     func fetchParents() {
         let request = NSFetchRequest<ParentEntity>(entityName: "ParentEntity")
         do {
             parents = try persistentContainer.viewContext.fetch(request)
         } catch {
             print("Error fetching data \(error.localizedDescription)")
         }
     }
     
     func addParent(name: String, date: Date) {
         let p = ParentEntity()
     }
     
     func delete(_ parent: ParentEntity) {
         if let index = parents.firstIndex(where: { $0.id == parent.id }) {
             deleteParent = parents[index].parentDay
             persistentContainer.viewContext.delete(parents[index])
             try? persistentContainer.viewContext.save()
             print("deleted")
         }
     }
 }
 */
