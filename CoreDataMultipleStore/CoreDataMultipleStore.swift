//
//  CoreDataManager.swift
//  PracticeApp
//
//  Created by Vijay Singh on 05/07/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataMultipleStore{
   
    private let modelName: String
    private let containerName: String
     
    init(modelName: String,containerName: String) {
       self.modelName = modelName
        self.containerName = containerName
         
     }
     
     private lazy var storeContainer: NSPersistentContainer = {
         let container = NSPersistentContainer(name: self.containerName)
         let defaultDirectoryURL = NSPersistentContainer.defaultDirectoryURL()
         let storeUrl = defaultDirectoryURL.appendingPathComponent("\(self.modelName).sqlite")
         let storeDescription = NSPersistentStoreDescription(url: storeUrl)
         storeDescription.configuration = "Default"
         container.persistentStoreDescriptions = [storeDescription]
         container.loadPersistentStores {
         (storeDescription, error) in
         if let error = error as NSError? {
           print("Unresolved error \(error), \(error.userInfo)")
         }
       }
       return container
     }()
    
    lazy var managedContext: NSManagedObjectContext = {
      return self.storeContainer.viewContext
    }()
    
    func saveContext () {
        if managedContext.hasChanges {
          do {
            try managedContext.save()
          } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
        }
      }
}


