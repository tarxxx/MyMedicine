//
//  StorageManager.swift
//  MyMedicine
//
//  Created by Kirill Tarasko on 08.07.2022.
//

import Foundation
import CoreData

struct StorageManager {
    static let shared = StorageManager()
    private init() {}
    
    var persistentContainer: NSPersistentContainer = {
      
       let container = NSPersistentContainer(name: "MyMedicine")
       container.loadPersistentStores(completionHandler: { (storeDescription, error) in
           if let error = error as NSError? {
             
               fatalError("Unresolved error \(error), \(error.userInfo)")
           }
       })
       return container
    }()
    
    func saveContext () {
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
}
