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

class SleepScene: SKScene {

    var welcomeScene = WelcomeScene()
    var sleepViewController = SleepViewController()
    var playViewController = (UIApplication.shared.delegate as! AppDelegate).playViewController!
    
    var adultLabel: SKSpriteNode!
    var teenLabel: SKSpriteNode!
    var goodSleep: SKSpriteNode!
    var badSleep: SKSpriteNode!
    
    var now = Date()
    var calendar = Calendar.current
    let namelabel = UILabel(frame: CGRect(x: 6, y: -15, width: 150, height: 100))

    var year : String!
    var birthYear : Int!
    var thisYear : Int!
    
    override func didMove(to view: SKView) {
        
        adultLabel = self.childNode(withName: "68Hours") as! SKSpriteNode
        teenLabel = self.childNode(withName: "810Hours") as! SKSpriteNode
        goodSleep = self.childNode(withName: "GoodSleep") as! SKSpriteNode
        badSleep = self.childNode(withName: "BadSleep") as! SKSpriteNode
        
        let todaySleepHours = sleepViewController.getLongestDuration()
        let todaySleepMinutes = sleepViewController.getLongestDurationMin()
        
        let sleepLabel = UILabel(frame: CGRect(x: self.frame.width/9, y: self.frame.height/7.2, width: 200, height: 200 ))
        
        sleepLabel.textColor = UIColor.black
        sleepLabel.textAlignment = .center
        sleepLabel.numberOfLines = 0
        sleepLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 20)
        sleepLabel.text = "You got " + String(todaySleepHours) + " hours and " + String(todaySleepMinutes) + " minutes of sleep last night."
        self.view?.addSubview(sleepLabel)

        year = welcomeScene.getBirthYear()
        birthYear = Int(year)!
        thisYear = calendar.component(.year, from: now)
        
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
        
        if(thisYear - birthYear >= 19){
            adultLabel.isHidden = false
            teenLabel.isHidden = true
            if(todaySleepHours >= 6){
                goodSleep.isHidden = false
                badSleep.isHidden = true
            }else{
                badSleep.isHidden = false
                goodSleep.isHidden = true
            }
        }else{
            teenLabel.isHidden = false
            adultLabel.isHidden = true
            if(todaySleepHours >= 8){
                goodSleep.isHidden = false
                badSleep.isHidden = true
            }else{
                badSleep.isHidden = false
                goodSleep.isHidden = true
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        year = welcomeScene.getBirthYear()
        birthYear = Int(year)!
        if(thisYear - birthYear >= 19){
            adultLabel.isHidden = false
            teenLabel.isHidden = true
        }else{
            teenLabel.isHidden = false
            adultLabel.isHidden = true
        }
        playViewController.checkNameLabel(namelabel: namelabel)
    }
}
