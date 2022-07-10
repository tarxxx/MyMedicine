//
//  StorageManager.swift
//  MyMedicine
//
//  Created by Kirill Tarasko on 08.07.2022.
//

import Foundation
import CoreData

class StorageManager {
    static let shared = StorageManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
      
       let container = NSPersistentContainer(name: "MyMedicine")
       container.loadPersistentStores(completionHandler: { (storeDescription, error) in
           if let error = error as NSError? {
             
               fatalError("Unresolved error \(error), \(error.userInfo)")
           }
       })
       return container
    }()
    
    
    lazy var context = persistentContainer.viewContext
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
    
    func fetchUser() -> [User]
    {
        
        var user = [User]()
        let fetchRequest = User.fetchRequest() as NSFetchRequest<User>
        
        do {
            user = try context.fetch(fetchRequest)
        }
        catch {
            print("Some error occured when fetching the products")
        }
        return user
    }
}
