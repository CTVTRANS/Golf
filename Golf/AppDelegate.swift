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
