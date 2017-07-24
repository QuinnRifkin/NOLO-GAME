//
//  AppDelegate.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 6/16/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var gameViewController:GameViewController!
    var playViewController:PlayViewController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window?.rootViewController = TabBarViewController()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        //this is where personal info (SS Numbers, credit card info, etc.) is taken from user device (and sold on black market)(this is how we pay for ad-free)
//        =
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.window?.rootViewController = storyboard.instantiateInitialViewController()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        window?.rootViewController = TabBarViewController()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        //window?.rootViewController = TabBarViewController()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
//    func registerforDeviceLockNotification() {
//        //Screen lock notifications
//        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),     //center
//            Unmanaged.passUnretained(self).toOpaque(),     // observer
//            displayStatusChangedCallback,     // callback
//            "com.apple.springboard.lockcomplete" as CFString,     // event name
//            nil,     // object
//            .deliverImmediately)
//        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),     //center
//            Unmanaged.passUnretained(self).toOpaque(),     // observer
//            displayStatusChangedCallback,     // callback
//            "com.apple.springboard.lockstate" as CFString,    // event name
//            nil,     // object
//            .deliverImmediately)
//    }
//    
//    private let displayStatusChangedCallback: CFNotificationCallback = { _, cfObserver, cfName, _, _ in
//        guard let lockState = cfName?.rawValue as String? else {
//            return
//        }
//        
//        let catcher = Unmanaged<AppDelegate>.fromOpaque(UnsafeRawPointer(OpaquePointer(cfObserver)!)).takeUnretainedValue()
//        catcher.displayStatusChanged(lockState)
//    }
//    
//    private func displayStatusChanged(_ lockState: String) {
//        // the "com.apple.springboard.lockcomplete" notification will always come after the "com.apple.springboard.lockstate" notification
//        print("Darwin notification NAME = \(lockState)")
//        if (lockState == "com.apple.springboard.lockcomplete") {
//            print("DEVICE LOCKED")
//        } else {
//            print("LOCK STATUS CHANGED")
//        }
//    }

}

