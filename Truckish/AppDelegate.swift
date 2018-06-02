//
//  AppDelegate.swift
//  Truckish
//
//  Created by SUBRAT on 5/30/18.
//  Copyright © 2018 subratpadhi007. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import IQKeyboardManagerSwift
import DropDown

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().barTintColor = UIColor.bdefaultColor
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes =  [NSAttributedStringKey.backgroundColor: UIColor.bdefaultColor]
        
        IQKeyboardManager.sharedManager().enable = true
        DropDown.startListeningToKeyboard()
        
        FirebaseApp.configure()
        GMSServices.provideAPIKey("AIzaSyBpUS2dl7euD1iSbv4KsgURzepKek6pre8")
        
        self.showSplashScreen()
        
        return true
    }
    
    func showSplashScreen(){
        let storyboard =  UIStoryboard.init(name: "Main", bundle: nil)
        let tutorialcontroller = storyboard.instantiateViewController(withIdentifier: "SplashScreenViewController")
        self.window?.rootViewController = tutorialcontroller
    }
    
    func showLoginScreen(){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let navController =  storyBoard.instantiateViewController(withIdentifier: "LoginNAV")
        if let appdelegate =  UIApplication.shared.delegate as? AppDelegate {
            appdelegate.window?.rootViewController = navController
        }
    }
    
    func showHomeScreen(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let loginNavController = UINavigationController(rootViewController: loginViewController)
        self.window?.rootViewController = loginNavController
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

