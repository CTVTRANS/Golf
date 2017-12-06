//
//  AppDelegate.swift
//  Golf
//
//  Created by le kien on 11/20/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey(apiMap)
        return true
    }
}
//var applicationDocumentsDirectory: URL = {
//    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//    return urls[urls.count-1]
//}()
//
//var managedObjectModel: NSManagedObjectModel = {
//    let modelURL = Bundle.main.url(forResource: "Golf", withExtension: "momd")!
//    return NSManagedObjectModel(contentsOf: modelURL)!
//}()
//
//var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
//    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
//    let url = applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
//    var failureReason = "There was an error creating or loading the application's saved data."
//    do {
//        try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
//    } catch {
//        // Report any error we got.
//        var dict = [String: AnyObject]()
//        dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
//        dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
//
//        dict[NSUnderlyingErrorKey] = error as NSError
//        let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
//        NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
//        abort()
//    }
//
//    return coordinator
//}()
//
//var managedObjectContext: NSManagedObjectContext = {
//    let coordinator = persistentStoreCoordinator
//    var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//    managedObjectContext.persistentStoreCoordinator = coordinator
//    return managedObjectContext
//}()
//
//// MARK: - Core Data Saving support
//
//func saveContext () {
//    if managedObjectContext.hasChanges {
//        do {
//            try managedObjectContext.save()
//        } catch {
//            let nserror = error as NSError
//            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
//            abort()
//        }
//    }
//}

