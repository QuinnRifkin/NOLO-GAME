//
//  SleepScene.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 7/18/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class SleepScene: SKScene, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var welcomeScene = WelcomeScene()
    var sleepViewController = SleepViewController()
    var playViewController = (UIApplication.shared.delegate as! AppDelegate).playViewController!
    
    let barGraph = BarGraph()
    
    var goodBad = UserDefaults.standard
    
    var isPlaying = false
    var isRecordingSleep: Bool = false
    
    var adultLabel: SKSpriteNode!
    var teenLabel: SKSpriteNode!
    var goodSleep: SKSpriteNode!
    var badSleep: SKSpriteNode!
    var manualSleepEntry : SKSpriteNode!
    var manualSleepEntryNode : SKSpriteNode!
    var manualSleepLabel : SKSpriteNode!
    var startRecordingButton : SKSpriteNode!
    var startRecordingNode : SKSpriteNode!
    var stopRecordingButton : SKSpriteNode!
    var stopRecordingNode : SKSpriteNode!
    
    var startDateComponents = DateComponents()
    var endDateComponents = DateComponents()
    var startDate = Date()
    var endDate = Date()
    var now = Date()
    var calendar = Calendar.current
    var namelabel : UILabel!

    var year : String!
    var birthYear : Int!
    var thisYear : Int!
    
    var sleepLabel: UILabel!
    
    var startHour = "10"
    var startMin = "00"
    var startAmPm = "PM"
    var endHour = "10"
    var endMin = "00"
    var endAmPm = "AM"
    
    var sleepInputScreen = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    var sleepInputView = UIView()
    var sleepInputLabel = UILabel()
    var startTimeInput = UITextField()
    var endTimeInput = UITextField()
    var sleepInputKeyboardStart = UIPickerView()
    var sleepInputKeyboardEnd = UIPickerView()
    var submit = UIButton()
    var cancel = UIButton()
    let toolbarHours = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    let toolbarMinutes = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    
    var timeDatabase = [["1","2","3","4","5","6","7","8","9","10","11","12"],[":"],["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"],["AM","PM"]]
    
    var arrayHours = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"]
    var arrayMinutes = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
    var amPm = ["AM","PM"]
    
    func quickActionStart(){
        if(isRecordingSleep){
            monitoringAlertS(title: "Oops", message: "You are already recording!", okTitle: "Ok")
        }
        else{
            monitoringAlert(title: "Hey", message: "Do you want to start recording your sleep?", cancelTitle: "No", okTitle: "Yes")
        }
    }
    
    func quickActionStop(){
        if(isRecordingSleep){
            monitoringAlert(title: "Hey", message: "Do you want to stop recording your sleep?" , cancelTitle: "No", okTitle: "Yes")
        }
        else{
            monitoringAlertS(title: "Oops", message: "You are not currently recording", okTitle: "Ok")
        }
    }
    
    func showView(){
        self.view?.addSubview(sleepInputScreen)
        self.view?.addSubview(sleepInputView)
        self.view?.addSubview(sleepInputLabel)
        self.view?.addSubview(startTimeInput)
        self.view?.addSubview(endTimeInput)
        self.view?.addSubview(submit)
        self.view?.addSubview(cancel)
        
        UIView.animate(withDuration: 0.8, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            
            self.sleepInputScreen.frame = CGRect(x: self.sleepInputScreen.frame.origin.x, y: self.sleepInputScreen.frame.origin.y + 1000, width: self.sleepInputScreen.frame.size.width, height: self.sleepInputScreen.frame.size.height)
            
            self.sleepInputView.frame = CGRect(x: self.sleepInputView.frame.origin.x, y: self.sleepInputView.frame.origin.y + 1000, width: self.sleepInputView.frame.size.width, height: self.sleepInputView.frame.size.height)
            
            self.sleepInputLabel.frame = CGRect(x: self.sleepInputLabel.frame.origin.x, y: self.sleepInputLabel.frame.origin.y + 1000, width: self.sleepInputLabel.frame.size.width, height: self.sleepInputLabel.frame.size.height)
            
            self.startTimeInput.frame = CGRect(x: self.startTimeInput.frame.origin.x, y: self.startTimeInput.frame.origin.y + 1000, width: self.startTimeInput.frame.size.width, height: self.startTimeInput.frame.size.height)
            
            self.endTimeInput.frame = CGRect(x: self.endTimeInput.frame.origin.x, y: self.endTimeInput.frame.origin.y + 1000, width: self.endTimeInput.frame.size.width, height: self.endTimeInput.frame.size.height)
            
            self.submit.frame = CGRect(x: self.submit.frame.origin.x, y: self.submit.frame.origin.y + 1000, width: self.submit.frame.size.width, height: self.submit.frame.size.height)
            
            self.cancel.frame = CGRect(x: self.cancel.frame.origin.x, y: self.cancel.frame.origin.y + 1000, width: self.cancel.frame.size.width, height: self.cancel.frame.size.height)
            
        }, completion: { (finished) -> Void in})
    }
    
    func dismissView(_ Button: UIButton){
        UIView.animate(withDuration: 0.8, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            
            self.sleepInputScreen.frame = CGRect(x: self.sleepInputScreen.frame.origin.x, y: self.sleepInputScreen.frame.origin.y - 1000, width: self.sleepInputScreen.frame.size.width, height: self.sleepInputScreen.frame.size.height)
            
            self.sleepInputView.frame = CGRect(x: self.sleepInputView.frame.origin.x, y: self.sleepInputView.frame.origin.y - 1000, width: self.sleepInputView.frame.size.width, height: self.sleepInputView.frame.size.height)
            
            self.sleepInputLabel.frame = CGRect(x: self.sleepInputLabel.frame.origin.x, y: self.sleepInputLabel.frame.origin.y - 1000, width: self.sleepInputLabel.frame.size.width, height: self.sleepInputLabel.frame.size.height)
            
            self.startTimeInput.frame = CGRect(x: self.startTimeInput.frame.origin.x, y: self.startTimeInput.frame.origin.y - 1000, width: self.startTimeInput.frame.size.width, height: self.startTimeInput.frame.size.height)
            
            self.endTimeInput.frame = CGRect(x: self.endTimeInput.frame.origin.x, y: self.endTimeInput.frame.origin.y - 1000, width: self.endTimeInput.frame.size.width, height: self.endTimeInput.frame.size.height)
            
            self.submit.frame = CGRect(x: self.submit.frame.origin.x, y: self.submit.frame.origin.y - 1000, width: self.submit.frame.size.width, height: self.submit.frame.size.height)
            
            self.cancel.frame = CGRect(x: self.cancel.frame.origin.x, y: self.cancel.frame.origin.y - 1000, width: self.cancel.frame.size.width, height: self.cancel.frame.size.height)
            
        }, completion: { (finished) -> Void in
            self.sleepInputScreen.removeFromSuperview()
            self.sleepInputView.removeFromSuperview()
            self.sleepInputLabel.removeFromSuperview()
            self.startTimeInput.removeFromSuperview()
            self.endTimeInput.removeFromSuperview()
            self.submit.removeFromSuperview()
            self.cancel.removeFromSuperview()
            self.manualSleepEntryNode.isHidden = false
            self.sleepLabel.isHidden = false
        })
    }
    
    func finalSubmission(_ Button: UIButton){
        let alert = UIAlertController(title: "Just making sure", message: "Are you sure you want to make this entry? This will be added to your sleep data in the health app. \n\nStart time: " + startHour + ":" + startMin + " " + startAmPm + "\nEnd time: " + endHour + ":" + endMin + " " + endAmPm, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.destructive, handler: { action in
            self.preSaveCleaning()
            print("submitted :)")}))
        
        if let vc = self.view?.window?.rootViewController {
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    func monitoringAlert(title: String, message: String, cancelTitle: String, okTitle: String){
        let alert = UIAlertController(title: title , message: message,  preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: cancelTitle, style: UIAlertActionStyle.destructive, handler: { action in
           print("do nothing")}))
        alert.addAction(UIAlertAction(title: okTitle, style: UIAlertActionStyle.default, handler: { action in
            if(self.isRecordingSleep){
                self.resetTimer()
            }
            self.isRecordingSleep = !self.isRecordingSleep;
            if(self.isRecordingSleep){
                self.sleepTimer()
            }
        }))
        if let vc = self.view?.window?.rootViewController {
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    func monitoringAlertS(title: String, message: String, okTitle: String){
        
        let alert = UIAlertController(title: title , message: message,  preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: okTitle, style: UIAlertActionStyle.default, handler: { action in print("do nothing")}))
        
        if let vc = self.view?.window?.rootViewController {
            vc.present(alert, animated: true, completion: nil)
        }
    }

    func preSaveCleaning(){
        if(startAmPm == "PM"){
            startDateComponents.hour = Int(startHour)! + 12
        }else if(startAmPm == "AM"){
            startDateComponents.hour = Int(startHour)!
            startDateComponents.day! += 1
        }
        startDateComponents.minute = Int(startMin)
        if(endAmPm == "PM"){
            endDateComponents.hour = Int(endHour)! + 12
        }else{
            endDateComponents.hour = Int(endHour)!
        }
        endDateComponents.minute = Int(endMin)
        startDate = calendar.date(from: startDateComponents)!
        endDate = calendar.date(from: endDateComponents)!
        switch(startDateComponents.weekday){
        case 1?:
            barGraph.sundayStart = startDate
            barGraph.sundayEnd = endDate
        case 2?:
            barGraph.mondayStart = startDate
            barGraph.mondayEnd = endDate
        case 3?:
            barGraph.tuesdayStart = startDate
            barGraph.tuesdayEnd = endDate
        case 4?:
            barGraph.wednesdayStart = startDate
            barGraph.wednesdayEnd = endDate
        case 5?:
            barGraph.thursdayStart = startDate
            barGraph.thursdayEnd = endDate
        case 6?:
            barGraph.fridayStart = startDate
            barGraph.fridayEnd = endDate
        case 7?:
            barGraph.saturdayStart = startDate
            barGraph.saturdayEnd = endDate
        default:
            print("graph entry failed")
        }
        barGraph.reLoad()
        sleepViewController.saveSleepAnalysis(startDate: startDate, endDate: endDate)
        goodBadSleepDisplay()
        startDate = Date()
        endDate = Date()
        dismissView(self.cancel)
    }
    
    func goodBadSleepDisplay(){
        let difference = Calendar.current.dateComponents([.hour], from: startDate, to: endDate)
        let hours = (difference.hour)!
        if(adultLabel.isHidden){
            if(hours >= 8){
                goodSleep.isHidden = false
                badSleep.isHidden = true
                goodBad.set(true, forKey: "Good")
            }else{
                goodSleep.isHidden = true
                badSleep.isHidden = false
                goodBad.set(false, forKey: "Good")
            }
        }else if(teenLabel.isHidden){
            if(hours >= 6){
                goodSleep.isHidden = false
                badSleep.isHidden = true
                goodBad.set(true, forKey: "Good")
            }else{
                goodSleep.isHidden = true
                badSleep.isHidden = false
                goodBad.set(false, forKey: "Good")
            }
        }
    }

    override func didMove(to view: SKView) {
        
        let currentComponents = calendar.dateComponents([.year, .month, .day, .weekday], from: now)
        
        let currentYear = currentComponents.year!
        let currentMonth = currentComponents.month!
        let currentDay = currentComponents.day!
        let currentWeekDay = currentComponents.weekday!
        
        startDateComponents.weekday = currentWeekDay
        startDateComponents.year = currentYear
        if(currentDay == 1){
            startDateComponents.month = currentMonth - 1
            switch(currentMonth){
            case 1, 3, 5, 7, 8, 10, 12:
                startDateComponents.day = 31
            case 4, 6, 9, 11:
                startDateComponents.day = 30
            case 2:
                if(currentYear%100 == 0 && currentYear%400 == 0){
                    startDateComponents.day = 29
                }else{
                startDateComponents.day = 28
                }
            default: startDateComponents.day = 1
            }
        }else{
            startDateComponents.month = currentMonth
            startDateComponents.day = currentDay - 1
        }
        
        endDateComponents.year = currentYear
        endDateComponents.month = currentMonth
        endDateComponents.day = currentDay
        
        print(currentYear)
        print(currentMonth)
        print(currentDay)
        
        self.view?.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        //barGraph.centerFrame = CGPoint(x: 180, y: 330)
        print((self.view?.center)!)
        self.view?.addSubview(barGraph)
        
        if(UIScreen.main.bounds.height == 480){
            namelabel = UILabel(frame: CGRect(x: 30, y: 2, width: 150, height: 50))
            
            sleepInputScreen.frame = (self.view?.bounds)!
            sleepInputScreen.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - (1000))
            
            sleepInputView.bounds = CGRect(x: 0, y: 0, width: 300, height: 250)
            
            sleepInputView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - (1000))
            
            sleepInputLabel.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - (1090))
            
            submit.center = CGPoint(x: UIScreen.main.bounds.width/2 + 50, y: UIScreen.main.bounds.height/2 - (920))
            
            cancel.center = CGPoint(x: UIScreen.main.bounds.width/2 - 50, y: UIScreen.main.bounds.height/2 - (920))
            
            startTimeInput.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - (1030))
            
            endTimeInput.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - (975))
        }else if(UIScreen.main.bounds.height == 568){
            namelabel = UILabel(frame: CGRect(x: 10, y: 10, width: 150, height: 50))
            
            sleepInputScreen.frame = (self.view?.bounds)!
            sleepInputScreen.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - (1000))
            
            sleepInputView.bounds = CGRect(x: 0, y: 0, width: 300, height: 250)
            
            sleepInputView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - (1000))
            
            sleepInputLabel.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - (1090))
            
            submit.center = CGPoint(x: UIScreen.main.bounds.width/2 + 50, y: UIScreen.main.bounds.height/2 - (920))
            
            cancel.center = CGPoint(x: UIScreen.main.bounds.width/2 - 50, y: UIScreen.main.bounds.height/2 - (920))
            
            startTimeInput.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - (1030))
            
            endTimeInput.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - (975))
        }else if(UIScreen.main.bounds.height == 736){
            namelabel = UILabel(frame: CGRect(x: 6, y: -15, width: 150, height: 100))
            
            sleepInputScreen.frame = UIScreen.main.bounds//(self.view?.bounds)!
            
            sleepInputScreen.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - (1000))
            
            sleepInputView.bounds = CGRect(x: 0, y: 0, width: 300, height: 250)
            
            sleepInputView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - (1000))
            
            sleepInputLabel.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - (1090))
            
            submit.center = CGPoint(x: UIScreen.main.bounds.width/2 + 50, y: UIScreen.main.bounds.height/2 - (920))
            
            cancel.center = CGPoint(x: UIScreen.main.bounds.width/2 - 50, y: UIScreen.main.bounds.height/2 - (920))
            
            startTimeInput.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - (1030))
            
            endTimeInput.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - (975))
        }else{
            namelabel = UILabel(frame: CGRect(x: 6, y: -15, width: 150, height: 100))
            
            sleepInputScreen.frame = (self.view?.bounds)!
            sleepInputScreen.center = CGPoint(x: ((self.view?.center.x)!), y: (self.view?.center.y)! - (1000))
            
            sleepInputView.bounds = CGRect(x: 0, y: 0, width: 300, height: 250)
            
            sleepInputView.center = CGPoint(x: ((self.view?.center.x)!), y: (self.view?.center.y)! - (1000))
            
            sleepInputLabel.center = CGPoint(x: ((self.view?.center.x)!), y: (self.view?.center.y)! - (1090))
            
            submit.center = CGPoint(x: ((self.view?.center.x)! + (50)), y: (self.view?.center.y)! - (920))
            
            cancel.center = CGPoint(x: ((self.view?.center.x)! - (50)), y: (self.view?.center.y)! - (920))
            
            startTimeInput.center = CGPoint(x: ((self.view?.center.x)! - (0)), y: ((self.view?.center.y)! - (1030)))
            
            endTimeInput.center = CGPoint(x: ((self.view?.center.x)! - (0)), y: ((self.view?.center.y)! - (975)))
        }
        
        sleepInputView.layer.cornerRadius = 20
        sleepInputView.backgroundColor = UIColor.red
        sleepInputView.layer.opacity = 0.6
        
        startTimeInput.bounds = CGRect(x: 0, y: 0, width: 180, height: 40)
        startTimeInput.attributedPlaceholder = NSAttributedString(string: "Start", attributes: [NSForegroundColorAttributeName : UIColor.black])
        startTimeInput.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        startTimeInput.borderStyle = UITextBorderStyle.roundedRect
        startTimeInput.autocorrectionType = UITextAutocorrectionType.no
        startTimeInput.keyboardType = UIKeyboardType.default
        startTimeInput.returnKeyType = UIReturnKeyType.continue
        startTimeInput.clearButtonMode = UITextFieldViewMode.never
        startTimeInput.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        startTimeInput.textAlignment = NSTextAlignment.center
        startTimeInput.delegate = self as UITextFieldDelegate
        startTimeInput.backgroundColor = .white
        startTimeInput.inputView = sleepInputKeyboardStart
        sleepInputKeyboardStart.delegate = self
        sleepInputKeyboardStart.dataSource = self
        sleepInputKeyboardStart.selectRow(33, inComponent: 0, animated: false)
        sleepInputKeyboardStart.selectRow(180, inComponent: 2, animated: false)
        sleepInputKeyboardStart.selectRow(1, inComponent: 3, animated: false)
        
        endTimeInput.bounds = CGRect(x: 0, y: 0, width: 180, height: 40)
        endTimeInput.attributedPlaceholder = NSAttributedString(string: "End", attributes: [NSForegroundColorAttributeName : UIColor.black])
        endTimeInput.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        endTimeInput.borderStyle = UITextBorderStyle.roundedRect
        endTimeInput.autocorrectionType = UITextAutocorrectionType.no
        endTimeInput.keyboardType = UIKeyboardType.default
        endTimeInput.returnKeyType = UIReturnKeyType.continue
        endTimeInput.clearButtonMode = UITextFieldViewMode.never
        endTimeInput.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        endTimeInput.textAlignment = NSTextAlignment.center
        endTimeInput.delegate = self as UITextFieldDelegate
        endTimeInput.backgroundColor = .white
        endTimeInput.inputView = sleepInputKeyboardEnd
        sleepInputKeyboardEnd.delegate = self
        sleepInputKeyboardEnd.dataSource = self
        sleepInputKeyboardEnd.selectRow(33, inComponent: 0, animated: false)
        sleepInputKeyboardEnd.selectRow(180, inComponent: 2, animated: false)
        
        submit.bounds = CGRect(x: 0, y: 0, width: 70, height: 20)
        submit.setTitle("Submit", for: .normal)
        submit.addTarget(self, action: #selector(self.finalSubmission(_:)), for: UIControlEvents.touchUpInside)
        submit.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        submit.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        cancel.bounds = CGRect(x: 0, y: 0, width: 70, height: 20)
        cancel.setTitle("Cancel", for: .normal)
        cancel.addTarget(self, action: #selector(self.dismissView(_:)), for: UIControlEvents.touchUpInside)
        cancel.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        cancel.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        sleepInputLabel.text = "Enter when you went to bed and when you woke up:"
        sleepInputLabel.textColor = .white
        sleepInputLabel.textAlignment = .center
        sleepInputLabel.numberOfLines = 0
        sleepInputLabel.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        sleepInputLabel.bounds = CGRect(x: 0, y: 0, width: 275, height: 150)

        manualSleepEntry = self.childNode(withName: "ManualSleepButton") as! SKSpriteNode
        manualSleepEntryNode = self.childNode(withName: "ManualSleep") as! SKSpriteNode
        manualSleepLabel = self.childNode(withName: "ManualLabel") as! SKSpriteNode
        startRecordingButton = self.childNode(withName: "StartRecordingLabel") as! SKSpriteNode
        startRecordingNode = self.childNode(withName: "StartRecording") as! SKSpriteNode
        stopRecordingButton = self.childNode(withName: "StopRecordingLabel") as! SKSpriteNode
        stopRecordingNode = self.childNode(withName: "StopRecording") as! SKSpriteNode
        
        adultLabel = self.childNode(withName: "68Hours") as! SKSpriteNode
        teenLabel = self.childNode(withName: "810Hours") as! SKSpriteNode
        goodSleep = self.childNode(withName: "GoodSleep") as! SKSpriteNode
        badSleep = self.childNode(withName: "BadSleep") as! SKSpriteNode
        
        if(goodBad.value(forKey: "Good") == nil){
            goodSleep.isHidden = true
            badSleep.isHidden = true
        }else if(goodBad.bool(forKey: "Good")){
            goodSleep.isHidden = false
            badSleep.isHidden = true
        }else if(!goodBad.bool(forKey: "Good")){
            goodSleep.isHidden = true
            badSleep.isHidden = false
        }
        
        let todaySleepHours = sleepViewController.getLongestDuration()
        let todaySleepMinutes = sleepViewController.getLongestDurationMin()
        
        sleepLabel = UILabel(frame: CGRect(x: self.frame.width/9, y: self.frame.height/10, width: 200, height: 200 ))
        
        sleepLabel.textColor = UIColor.black
        sleepLabel.textAlignment = .center
        sleepLabel.numberOfLines = 0
        sleepLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 20)
        sleepLabel.text = "You got " + String(todaySleepHours) + " hours and " + String(todaySleepMinutes) + " minutes of sleep last night."

        year = welcomeScene.getBirthYear()
        birthYear = Int(year)!
        thisYear = calendar.component(.year, from: now)
        
        if(thisYear - birthYear >= 19){
            adultLabel.isHidden = false
            teenLabel.isHidden = true
            barGraph.isAdult = true
        }else{
            teenLabel.isHidden = false
            adultLabel.isHidden = true
            barGraph.isAdult = false
        }
        
        let name = String(welcomeScene.getName())
        if(name!.characters.count >= 25)
        {
            namelabel.font = UIFont(name: "ChalkboardSE-Regular", size: 10)
        } else if(name!.characters.count >= 20){
            namelabel.font = UIFont(name: "ChalkboardSE-Regular", size: 12)
        } else if(name!.characters.count >= 15){
            namelabel.font = UIFont(name: "ChalkboardSE-Regular", size: 14)
        } else if(name!.characters.count >= 10){
            namelabel.font = UIFont(name: "ChalkboardSE-Regular", size: 16)
        } else {
            namelabel.font = UIFont(name: "ChalkboardSE-Regular", size: 18)
        }
        
        namelabel.attributedText = NSAttributedString(string: name!, attributes: [NSForegroundColorAttributeName : UIColor.white])
        namelabel.textAlignment = NSTextAlignment.left
        self.view?.addSubview(namelabel)
        
        sleepInputKeyboardStart.tag = 1
        sleepInputKeyboardEnd.tag = 2
        
        let cancelButtonHour = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(self.cancelHourPressed(sender:)))
        let doneButtonHour = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneHourPressed(sender:)))
        let cancelButtonMin = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(self.cancelMinPressed(sender:)))
        let doneButtonMin = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneMinPressed(sender:)))
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        toolbarHours.barStyle = UIBarStyle.default
        toolbarHours.tintColor = UIColor.blue
        toolbarHours.setItems([cancelButtonHour, flexButton, doneButtonHour], animated: true)
        startTimeInput.inputAccessoryView = toolbarHours
        
        toolbarMinutes.barStyle = UIBarStyle.default
        toolbarMinutes.tintColor = UIColor.blue
        toolbarMinutes.setItems([cancelButtonMin, flexButton, doneButtonMin], animated: true)
        endTimeInput.inputAccessoryView = toolbarMinutes
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return timeDatabase.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 1){
            return 1
        }else if(component == 3){
            return timeDatabase[component].count
        }else{
            return (timeDatabase[component].count)*5
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timeDatabase[component][row%timeDatabase[component].count]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont(name: "HelveticaNeue", size: 40)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        
        pickerLabel?.text = timeDatabase[component][row%timeDatabase[component].count]
        
        return pickerLabel!;
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if(component == 1){
            return 10.0
        } else if (component == 3){
            return 80.0
        }else{return 50.0}
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == sleepInputKeyboardStart){
            switch(component){
                case 0:
                    startHour = timeDatabase[component][pickerView.selectedRow(inComponent: 0)%timeDatabase[component].count]
                case 2:
                    startMin = timeDatabase[component][pickerView.selectedRow(inComponent: 2)%timeDatabase[component].count]
                case 3:
                    startAmPm = timeDatabase[component][pickerView.selectedRow(inComponent: 3)%timeDatabase[component].count]
                default: break
            }
            //inputHours = arrayHours[pickerView.selectedRow(inComponent: 0)]
        } else if(pickerView == sleepInputKeyboardEnd){
            switch(component){
            case 0:
                endHour = timeDatabase[component][pickerView.selectedRow(inComponent: 0)%timeDatabase[component].count]
            case 2:
                endMin = timeDatabase[component][pickerView.selectedRow(inComponent: 2)%timeDatabase[component].count]
            case 3:
                endAmPm = timeDatabase[component][pickerView.selectedRow(inComponent: 3)%timeDatabase[component].count]
            default: break
            }
        }
        startTimeInput.textAlignment = NSTextAlignment.center
        startTimeInput.text = startHour + ":" + startMin + " " + startAmPm
        endTimeInput.textAlignment = NSTextAlignment.center
        endTimeInput.text = endHour + ":" + endMin + " " + endAmPm
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField: startTimeInput, moveDistace: -30, up: true)
        moveTextField(textField: endTimeInput, moveDistace: -30, up: true)
        if(textField == startTimeInput){
            startTimeInput.textAlignment = NSTextAlignment.center
            startTimeInput.text = startHour + ":" + startMin + " " + startAmPm
        }else if(textField == endTimeInput){
            endTimeInput.textAlignment = NSTextAlignment.center
            endTimeInput.text = endHour + ":" + endMin + " " + endAmPm
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField: startTimeInput, moveDistace: -30, up: false)
        moveTextField(textField: endTimeInput, moveDistace: -30, up: false)
        if(textField == startTimeInput){
            startTimeInput.textAlignment = NSTextAlignment.center
            startTimeInput.text = startHour + ":" + startMin + " " + startAmPm
        }else if(textField == endTimeInput){
            endTimeInput.textAlignment = NSTextAlignment.center
            endTimeInput.text = endHour + ":" + endMin + " " + endAmPm
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == startTimeInput){
            //inputHours = startTimeInput.text!
            sleepInputKeyboardStart.resignFirstResponder()
            endTimeInput.becomeFirstResponder()
            sleepInputKeyboardEnd.becomeFirstResponder()
        }
        else{
            //inputMinutes = endTimeInput.text!
            sleepInputKeyboardEnd.resignFirstResponder()
            endTimeInput.resignFirstResponder()
        }
        return true
    }
    
    func moveTextField(textField: UITextField, moveDistace: Int, up: Bool){
        let duration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistace : -moveDistace)
        
        UIView.beginAnimations("TextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(duration)
        self.view?.frame = (self.view?.frame)!.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func doneHourPressed(sender: UIBarButtonItem){
        //.resignFirstResponder()
        endTimeInput.becomeFirstResponder()
        sleepInputKeyboardEnd.becomeFirstResponder()
        //inputHours = startTimeInput.text!
        //self.view?.endEditing(true)
    }
    
    func doneMinPressed(sender: UIBarButtonItem){
        endTimeInput.resignFirstResponder()
        //inputMinutes = endTimeInput.text!
        self.view?.endEditing(true)
    }
    
    func cancelHourPressed(sender: UIBarButtonItem){
        startTimeInput.resignFirstResponder()
        //setName(name: nameInput.text!)
        self.view?.endEditing(true)
    }
    
    func cancelMinPressed(sender: UIBarButtonItem){
        endTimeInput.resignFirstResponder()
        //setName(name: nameInput.text!)
        self.view?.endEditing(true)
    }
    
    override func update(_ currentTime: TimeInterval) {
        year = welcomeScene.getBirthYear()
        birthYear = Int(year)!
        if(thisYear - birthYear >= 19){
            adultLabel.isHidden = false
            teenLabel.isHidden = true
            barGraph.isAdult = true
        }else{
            teenLabel.isHidden = false
            adultLabel.isHidden = true
            barGraph.isAdult = false
        }
        barGraph.updateTarget()
        playViewController.checkNameLabel(namelabel: namelabel)
    }
    
    func resetTimer(){
        endDate = Date()
        let format = DateFormatter()
        format.timeStyle = .short
        print(format.string(from: endDate))
        print(format.string(from: startDate))
        print(endDate)
        isPlaying = false
        let weekdayComponents = calendar.dateComponents([.weekday], from: startDate)
        let alert = UIAlertController(title: "Just making sure", message: "Are you sure you want to make this entry? This will be added to your sleep data in the health app. \n\nStart time: " + format.string(from: startDate) + "\nEnd time: " + format.string(from: endDate), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.destructive, handler: { action in
            do{
                self.sleepViewController.saveSleepAnalysis(startDate: self.startDate, endDate: self.endDate)
            } catch {
                print("Submission Failed")
            }
            print("submitted :)")
            self.goodBadSleepDisplay()
            switch(weekdayComponents.weekday){
            case 1?:
                self.barGraph.sundayStart = self.startDate
                self.barGraph.sundayEnd = self.endDate
            case 2?:
                self.barGraph.mondayStart = self.startDate
                self.barGraph.mondayEnd = self.endDate
            case 3?:
                self.barGraph.tuesdayStart = self.startDate
                self.barGraph.tuesdayEnd = self.endDate
            case 4?:
                self.barGraph.wednesdayStart = self.startDate
                self.barGraph.wednesdayEnd = self.endDate
            case 5?:
                self.barGraph.thursdayStart = self.startDate
                self.barGraph.thursdayEnd = self.endDate
            case 6?:
                self.barGraph.fridayStart = self.startDate
                self.barGraph.fridayEnd = self.endDate
            case 7?:
                self.barGraph.saturdayStart = self.startDate
                self.barGraph.saturdayEnd = self.endDate
            default:
                print("graph entry failed")
            }
            self.barGraph.reLoad()
        }))
        
        if let vc = self.view?.window?.rootViewController {
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    func sleepTimer(){
        startDate = Date()
        print(startDate)
        isPlaying = true
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "ManualSleep"{
                manualSleepEntry.scale(to: CGSize(width: 538.2, height: 61.2))
                manualSleepLabel.scale(to: CGSize(width: 460, height: 66))
            }
            
            if nodesArray.first?.name == "StartRecordingButton"{
                startRecordingButton.scale(to: CGSize(width: 280, height: 131))
                startRecordingNode.scale(to: CGSize(width: 334 * 9/10 , height: 161 * 9/10))
            }
            
            if nodesArray.first?.name == "StopRecordingButton"{
                stopRecordingButton.scale(to: CGSize(width: 280, height: 131))
                stopRecordingNode.scale(to: CGSize(width: 300, height: 145))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "ManualSleep"{
                manualSleepEntry.scale(to: CGSize(width: 598, height: 68))
                manualSleepLabel.scale(to: CGSize(width: 511, height: 73))
            }
            
            if nodesArray.first?.name == "StartRecordingButton"{
                startRecordingButton.scale(to: CGSize(width: 311.5, height: 146))
                startRecordingNode.scale(to: CGSize(width: 334, height: 161))
            }
            
            if nodesArray.first?.name == "StopRecordingButton"{
                stopRecordingButton.scale(to: CGSize(width: 311.5, height: 146))
                stopRecordingNode.scale(to: CGSize(width: 334, height: 161))
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "ManualSleep"{
                manualSleepEntry.scale(to: CGSize(width: 598, height: 68))
                manualSleepLabel.scale(to: CGSize(width: 511, height: 73))
                manualSleepEntryNode.isHidden = true
                showView()
                sleepLabel.isHidden = true
            }
            
            if nodesArray.first?.name == "StartRecordingButton"{
                startRecordingButton.scale(to: CGSize(width: 311.5, height: 146))
                startRecordingNode.scale(to: CGSize(width: 334, height: 161))
                if(isRecordingSleep){
                    monitoringAlertS(title: "Oops", message: "You are already recording!", okTitle: "Ok")
                }
                else{
                    monitoringAlert(title: "Hey", message: "Do you want to start recording your sleep?", cancelTitle: "No", okTitle: "Yes")
                }
            }
            
            if nodesArray.first?.name == "StopRecordingButton"{
                stopRecordingButton.scale(to: CGSize(width: 311.5, height: 146))
                stopRecordingNode.scale(to: CGSize(width: 334, height: 161))
                if(isRecordingSleep){
                    monitoringAlert(title: "Hey", message: "Do you want to stop recording your sleep?" , cancelTitle: "No", okTitle: "Yes")
                }
                else{
                    monitoringAlertS(title: "Oops", message: "You are not currently recording", okTitle: "Ok")
                }
            }
        }
    }
}
