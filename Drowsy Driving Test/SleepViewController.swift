//
//  SleepViewController.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 7/18/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import UIKit
import HealthKit
import SpriteKit

class SleepViewController: UIViewController {
    
    var gameViewController = GameViewController()
    
    var longestDurationDefault = UserDefaults.standard
    var longestStartDefault = UserDefaults.standard
    var longestEndDefault = UserDefaults.standard
    var currentStartDefault = UserDefaults.standard
    var currentEndDefault = UserDefaults.standard
    
    var longestInHours = UserDefaults.standard
    var longestInMinutes = UserDefaults.standard
    
    var longestDuration : Int = 0 // in seconds
    var longestStart : Date!
    var longestEnd: Date!
    
    var currentDuration : TimeInterval = 0 // in seconds
    var currentStart : Date!
    var currentEnd : Date!
    
    var startTime : Date!
    var endTime : Date!

    let healthStore = HKHealthStore()
    let calendar = Calendar.current
    
    let hoursSleptLabel = UILabel(frame: CGRect(x: 70, y: 200, width: 250, height: 100))
    let cloudImage = UIImage(named: "AppCloud")
    
    var now = Date()
    
    func getLongestDuration() -> Int{
        return longestInHours.integer(forKey: "Hours")
    }
    
    func getLongestDurationMin() -> Int{
        return longestInMinutes.integer(forKey: "Hours")
    }
    
//    func setLongestStart(date: Date){
//        
//    }
//    
//    func setLongestEnd(date: Date){
//        
//    }
//    
//    func setCurrentStart(date: Date){
//        
//    }
//    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view = SKView()
        //self.view?.backgroundColor = UIColor.blue
        
        var timeSlept : Int = 0
        var hoursSlept : Int = 0
        var minutesSlept : Int = 0
    
        let hours = calendar.component(.hour, from: now)
        
        if(hours >= 10 && hours <= 19){
            longestStartDefault.set(nil, forKey: "LongestStart")
            longestEndDefault.set(nil, forKey: "LongestEnd")
            currentStartDefault.set(nil, forKey: "Start")
            currentEndDefault.set(nil, forKey: "End")
            currentStart = nil
            currentDuration = 0
        }
        currentStartDefault.setValue(nil, forKey: "Start")   //(nil, forKey: "Start")
        
        if(hours >= 20 || hours <= 9){
            if(currentStartDefault.value(forKey: "Start") == nil){
                longestDurationDefault.set(0, forKey: "Longest")
                currentStart = Date(timeIntervalSinceNow: 0)
                currentStartDefault.set(currentStart, forKey: "Start")
            } else {
                currentStart = (currentStartDefault.value(forKey: "Start") as! Date)
                currentEnd = Date(timeIntervalSinceNow: 0)
                currentDuration = (Date().timeIntervalSince(currentStart))
                if(currentDuration > longestDurationDefault.double(forKey: "Longest") || longestDurationDefault.value(forKey: "Longest") == nil){
                    longestDurationDefault.set(currentDuration, forKey: "Longest")
                    longestStartDefault.set(currentStart, forKey: "LongestStart")
                    longestEndDefault.set(currentEnd, forKey: "LongestEnd")
                }
                currentStartDefault.set(currentEnd, forKey: "Start")
            }
        }
    
        print(longestDurationDefault.value(forKey: "Longest") ?? "tight")
        print(longestStartDefault.value(forKey: "LongestStart") ?? "tight")
        print(longestEndDefault.value(forKey: "LongestEnd") ?? "tight")
        print(currentStart)
        print(currentStartDefault.value(forKey: "Start") ?? "tight")
        print(currentDuration)
        
        timeSlept = Int(longestDurationDefault.double(forKey: "Longest"))
        while(timeSlept >= 3600){
            hoursSlept += 1
            timeSlept -= 3600
        }
        while(timeSlept >= 60){
            minutesSlept += 1
            timeSlept -= 60
        }
        
        longestInHours.set(hoursSlept, forKey: "Hours")
        longestInMinutes.set(minutesSlept, forKey: "Minutes")
        
        gameViewController.viewControllerScene(scene: "SleepScene", viewController: self)
        
//        hoursSleptLabel.text = "You Slept " + String(hoursSlept) + " hours and " + String(minutesSlept) + " minutes last night."
//        hoursSleptLabel.textColor = UIColor.orange
//        hoursSleptLabel.numberOfLines = 0
//        hoursSleptLabel.textAlignment = .center
//
//        
//        print(hoursSleptLabel.text ?? "you boofed it")
//        
//        let cloudImageView = UIImageView(image: cloudImage)
//        cloudImageView.frame = CGRect(x: 30, y: 100, width: cloudImageView.frame.width, height: cloudImageView.frame.height)
//        self.view?.addSubview(cloudImageView)
//        self.view?.addSubview(hoursSleptLabel)
        
        let typesToRead : Set<HKObjectType> = [HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!]
        
        let typesToShare : Set<HKSampleType> = [HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!]
        
        self.healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
            if success == false{
                print("Display not allowed")
            } else {
                print("Display Allowed")
            }
        }
//        if(healthStore.authorizationStatus(for: HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!) == HKAuthorizationStatus.sharingAuthorized){
//            
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func saveSleepAnalysis() {
        
        // alarmTime and endTime are NSDate objects
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
            
            // we create our new object we want to push in Health app
            let object = HKCategorySample(type:sleepType, value: HKCategoryValueSleepAnalysis.inBed.rawValue, start: self.startTime, end: self.endTime)
            
            // at the end, we save it
            healthStore.save(object, withCompletion: { (success, error) -> Void in
                
                if error != nil {
                    // something happened
                    return
                }
                
                if success {
                    print("My new data was saved in HealthKit")
                    
                } else {
                    // something happened again
                }
                
            })
            
            
            let object2 = HKCategorySample(type:sleepType, value: HKCategoryValueSleepAnalysis.asleep.rawValue, start: self.startTime, end: self.endTime)
            
            healthStore.save(object2, withCompletion: { (success, error) -> Void in
                if error != nil {
                    // something happened
                    return
                }
                
                if success {
                    print("My new data (2) was saved in HealthKit")
                } else {
                    // something happened again
                }
            })
        }
        
    }
    func retrieveSleepAnalysis() {
        
        // first, we define the object type we want
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
            
            // Use a sortDescriptor to get the recent data first
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            
            // we create our query with a block completion to execute
            let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: 90, sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
                
                if error != nil {
                    
                    // something happened
                    return
                    
                }
                
                if let result = tmpResult {
                    
                    // do something with my data
                    for item in result {
                        if let sample = item as? HKCategorySample {
                            let value = (sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue) ? "InBed" : "Asleep"
                            print("Healthkit sleep: \(sample.startDate) \(sample.endDate) - value: \(value)")
                        }
                    }
                }
            }
            
            // finally, we execute our query
            healthStore.execute(query)
        }
    }
}