//
//  AppDelegate.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 6/16/17.
//  Copyright © 2017 NoLo. All rights reserved. lol
//

import UIKit
import AVFoundation
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    var gameViewController:GameViewController!
    var playViewController:PlayViewController!
    
    var tabBarController: UITabBarController?
    
    var userDefault = UserDefaults.standard
    
    var nightShiftBool = true
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UIApplication.shared.isIdleTimerDisabled = false
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if(granted){
                print("Notifications allowed")
            }else {
                print("Notifications denied")
            }
        }
        
        UNUserNotificationCenter.current().delegate = self

        var nineComponents = DateComponents()
        nineComponents.hour = 9
        nineComponents.minute = 48

        let nightShiftContent = UNMutableNotificationContent()
        nightShiftContent.title = "Hey there"
        nightShiftContent.body = "You should turn on Night Shift"
        let noThanks = UNNotificationAction(identifier: "noThanks", title: "No Thanks", options: .destructive)
        let goToSettings = UNNotificationAction(identifier: "goToSettings", title: "Go to Settings", options: .destructive)
        let nightShiftCategory = UNNotificationCategory(identifier: "nightShiftCategory", actions: [noThanks, goToSettings], intentIdentifiers: [], options: [])
        nightShiftContent.categoryIdentifier = "nightShiftCategory"
        UNUserNotificationCenter.current().setNotificationCategories([nightShiftCategory])
        //let nightShiftTrigger = UNCalendarNotificationTrigger(dateMatching: nineComponents, repeats: true)
        let nightShiftTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let nightShiftRequest = UNNotificationRequest(identifier: "nightShift", content: nightShiftContent, trigger: nightShiftTrigger)
        
        UNUserNotificationCenter.current().add(nightShiftRequest) { (error) in
            print(error ?? "Notification failed")
        }
        
        let learnMore = LearnMoreViewController()
        let play = PlayViewController()
        let settings = SettingsViewController()
        let sleep = SleepViewController()
        
        learnMore.tabBarItem.title = "Learn More"
        learnMore.tabBarItem.image = UIImage(named: "InfoTabItem-2")
        play.tabBarItem.title = "Play"
        play.tabBarItem.image = UIImage(named: "PlayTabItemSmall")
        settings.tabBarItem.title = "Settings"
        settings.tabBarItem.image = UIImage(named: "GearSmall")
        sleep.tabBarItem.title = "Sleep"
        sleep.tabBarItem.image = UIImage(named: "SleepTabIcon-1")
        
        self.tabBarController = UITabBarController()
        
        self.tabBarController!.setViewControllers([play, sleep, settings, learnMore], animated: false)
        window = UIWindow(frame: UIScreen.main.bounds)
        if(checkUserDefault() == 0){
            window?.rootViewController = WelcomeViewController()
        }
        else{
            window?.rootViewController = self.tabBarController
            }
        
        window?.makeKeyAndVisible()
    
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if (response.actionIdentifier == "noThanks"){
            print("No Thanks")
        }else{
            print("Go To Settings")
            UIApplication.shared.open(URL(string:"App-Prefs:root=General")!, options: [:], completionHandler: nil)
        }
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        //self.tabBarController = UITabBarController()
        //self.window?.rootViewController = self.tabBarController
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        //window?.rootViewController = TabBarViewController()
        //window?.rootViewController = TabBarViewController()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        //window?.rootViewController = TabBarViewController()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        self.window?.rootViewController = storyboard.instantiateInitialViewController()
    }
    
    
    func checkUserDefault() -> Int{
        var user : Int
        if(userDefault.value(forKey: "Launch") == nil || userDefault.integer(forKey: "Launch" ) == 0 ){
            user = 0
            userDefault.set(1, forKey: "Launch")
        }
        else{
        user = 1
        }
        return user
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
    
    //let nc = NotificationCenter.default
    //nc.addObserver(forName:Notification.Name(rawValue:"MyNotification"),
    //object:nil, queue:nil,
    //using:catchNotification)

}

