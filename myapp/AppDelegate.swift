//
//  AppDelegate.swift
//  myapp
//
//  Created by Sagar Chhetri on 1/18/16.
//  Copyright © 2016 Sagar Chhetri. All rights reserved.
//

import UIKit
import Parse
import Bolts


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("4vX8YAqNFjs55cvKLG3NKzAsolUeMCa7kUmCXbPU", clientKey: "jW7onpj0n7oxd0klKCQ1INtX9lxv7Dgnp2TrYqfl")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        
        
       
        let userName:String? = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
        if (userName != nil){
            //Navigate to Protected Page
            
            let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainPage  : MainPageViewController = mainStoryBoard.instantiateViewControllerWithIdentifier(
                "MainPageViewController") as! MainPageViewController
            let mainPageNav = UINavigationController(rootViewController: mainPage)
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = mainPageNav
 
        }
       
        
      
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

