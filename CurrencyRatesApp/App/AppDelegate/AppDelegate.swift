//
//  AppDelegate.swift
//  CurrencyRatesApp
//
//  Created by Ilia Nikolaenko on 02.11.19.
//  Copyright © 2019 Ilia Nikolaenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var coordinator: AppCoordinator?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    coordinator = AppCoordinator(window: window!)
    coordinator?.start()
    window?.makeKeyAndVisible()
  
    return true
  }
}

