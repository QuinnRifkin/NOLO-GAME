//
//  MenuScene.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 6/21/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class MenuScene: SKScene {
    
    var date = UserDefaults.standard
    var nightShiftNotified = UserDefaults.standard
    
    let gameViewController = GameViewController()
    
    var playDRButtonNode:SKSpriteNode!
    var learnMoreButtonNode:SKSpriteNode!
    var factBar:SKSpriteNode!
    var settingsButtonNode: SKSpriteNode!
    
    let random = Int(arc4random_uniform(5))
    var sleepFactz = [String]()
    
    let welcomeScene = WelcomeScene()
    
    let namelabel = UILabel(frame: CGRect(x: 6, y: -15, width: 300, height: 100))
    
    var fact : String!
    var fact1 : UILabel!
    
    var timeOfDay = Date()
    var calendar = Calendar.current
    
    override func didMove(to view: SKView) {
        let day = calendar.component(.day, from: timeOfDay)
        let hour = calendar.component(.hour, from: timeOfDay)
        
        if(date.value(forKey: "date") == nil){
            date.set(day, forKey: "date")
        }
        if(nightShiftNotified.value(forKey: "nightshift") == nil){
            nightShiftNotified.set(false, forKey: "nightshift")
        }
        
        if(date.integer(forKey: "date") != day){
            date.set(day, forKey: "date")
            nightShiftNotified.set(false, forKey: "nightshift")
        }

        if(!(nightShiftNotified.bool(forKey: "nightshift")) && hour >= 21){
            nightShiftNotified.set(true, forKey: "nightshift")
            let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.alertShow()
            }
        }
        
        factBar = self.childNode(withName: "factBar") as! SKSpriteNode

        sleepFactz = ["Sleep deprivation can result in obesity and poor diet quality.", "Sleep deprivation causes heart disease.", "Sleep deprivation increases the risk of diabetes.", "Not getting enough sleep can result in rash decision making.", "Drowsy driving can be as dangerous as drunk driving.", "Getting more sleep is proven to increase performance in school.", "Putting your phone away before bed will result in a much better sleep.", "Beauty Sleep is real; Going to bed earlier can improve your physical appearance.", "An average of 83,000 car crashes occur each year due to drowsy driving.", "Less than 30% of highschool students get sufficient sleep (8-10hrs)", "Humans are the only mammals that delay their sleep on purpose", "Exercising on a regular basis makes it easier to fall asleep", "12% of people dream in black and white", "Sleep deprivation can kill you faster than food deprivaton", "If falling asleep takes less than 10 minutes, chances are you are sleep deprived"]

        fact = (String) (sleepFactz[Int(arc4random_uniform(15))])
        
        fact1 = UILabel(frame: CGRect(x: 50 , y: -(factBar.position.y) - 20, width: 270, height: 150))
        
        fact1.text = fact
        fact1.font = UIFont(name: "HelveticaNeue-ThinItalic", size: 20)
        fact1.lineBreakMode = NSLineBreakMode.byWordWrapping
        fact1.numberOfLines = 0
        fact1.textColor = .white
        fact1.textAlignment = NSTextAlignment.center
        
        let name = String(welcomeScene.getName())
        namelabel.attributedText = NSAttributedString(string: name!, attributes: [NSForegroundColorAttributeName : UIColor.white])
        namelabel.textAlignment = NSTextAlignment.left
        namelabel.font = UIFont(name: "HelveticaNeue", size: 20)
        self.view?.addSubview(namelabel)
        
        playDRButtonNode = self.childNode(withName: "PlayDRButton") as! SKSpriteNode
        learnMoreButtonNode = self.childNode(withName: "LearnMoreButton") as! SKSpriteNode
        settingsButtonNode = self.childNode(withName: "SettingsNodeImage") as! SKSpriteNode
        settingsButtonNode.texture = SKTexture(imageNamed: "SettingsButton")
        settingsButtonNode.color = .clear
        
        let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.view?.addSubview(self.fact1)
        }
    }
    
    func alertShow(){
        let alert = UIAlertController(title: "Hey", message: "You should turn on Nightshift", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "I Have it on", style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        if let vc = self.view?.window?.rootViewController {
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "PlayDRButton" {
                if(Int(gameViewController.getDefault()) == 1){
                    namelabel.isHidden = true
                    fact1.isHidden = true
                    let transition = SKTransition.crossFade(withDuration: 0.5)
                    let gameScene = MenuScene(fileNamed: "InstructionScene1")
                    gameScene?.scaleMode = .aspectFill
                    self.view?.presentScene(gameScene!, transition: transition)
                }
                else{
                    namelabel.isHidden = true
                    fact1.isHidden = true
                    let transition = SKTransition.doorsOpenVertical(withDuration: 1)
                    let gameScene = GameScene(fileNamed: "GameScene")
                    gameScene?.scaleMode = .aspectFill
                    self.view?.presentScene(gameScene!, transition: transition)
                }
            }
            if nodesArray.first?.name == "LearnMoreButton" {
                namelabel.isHidden = true
                fact1.isHidden = true
                let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 0.5)
                let gameScene = MenuScene(fileNamed: "LearnMoreScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
            if nodesArray.first?.name == "SettingsNode" {
                namelabel.isHidden = true
                fact1.isHidden = true
                let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 0.5)
                let gameScene = MenuScene(fileNamed: "SettingsScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
        }
    }
}
