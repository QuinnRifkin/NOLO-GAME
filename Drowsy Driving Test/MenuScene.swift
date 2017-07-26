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
    
    let bouncingText = SKAction.sequence([SKAction.moveBy(x: 0, y: -10, duration: 0.6), SKAction.wait(forDuration: 0.1), SKAction.moveBy(x: 0, y: 10, duration: 0.6), SKAction.wait(forDuration: 0.1)])
    
    var playLabelNode : SKLabelNode!
    var learnLabelNode : SKLabelNode!
    var titleNode : SKSpriteNode!
    
    var date = UserDefaults.standard
    var nightShiftNotified = UserDefaults.standard
    
    let gameViewController = GameViewController()
    let playViewController = PlayViewController()
    
    var playDRButtonNode:SKSpriteNode!
    var learnMoreButtonNode:SKSpriteNode!
    var factBar:SKSpriteNode!
    var settingsButtonNode: SKSpriteNode!
    
    var playButton: SKSpriteNode!
    var howToPlayButton: SKSpriteNode!
    
    let random = Int(arc4random_uniform(5))
    var sleepFactz = [String]()
    
    let welcomeScene = WelcomeScene()
    
    let namelabel = UILabel(frame: CGRect(x: 6, y: -15, width: 150, height: 100))
    
    var fact : String!
    var fact1 : UILabel!
    
    var timeOfDay = Date()
    var calendar = Calendar.current
    
    
    override func didMove(to view: SKView) {
        
        playViewController.tabBarController?.tabBar.isHidden = false
        
        titleNode = self.childNode(withName: "PlayNode") as! SKSpriteNode
        
        //titleNode.run(SKAction.repeatForever(bouncingText))

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

        sleepFactz = ["Sleep deprivation can result in obesity and poor diet quality.", "Sleep deprivation causes heart disease.", "Sleep deprivation increases the risk of diabetes.", "Not getting enough sleep can result in rash decision making.", "Drowsy driving can be as dangerous as drunk driving.", "Getting more sleep is proven to increase performance in school.", "Putting your phone away before bed will result in a much better sleep.", "Beauty Sleep is real; Going to bed earlier can improve your physical appearance.", "An average of 83,000 car crashes occur each year due to drowsy driving.", "Less than 30% of highschool students get sufficient sleep (8-10hrs).", "Humans are the only mammals that delay their sleep on purpose.", "Exercising on a regular basis makes it easier to fall asleep.", "12% of people dream in black and white.", "Sleep deprivation can kill you faster than food deprivaton.", "If falling asleep takes less than 10 minutes, chances are you are sleep deprived."]

        fact = (String) (sleepFactz[Int(arc4random_uniform(15))])
        
        fact1 = UILabel(frame: CGRect(x: 50 , y: -(factBar.position.y) + 30, width: 270, height: 150))
        
        fact1.text = fact
        fact1.font = UIFont(name: "ChalkboardSE-Regular", size: 20)
        fact1.lineBreakMode = NSLineBreakMode.byWordWrapping
        fact1.numberOfLines = 0
        fact1.textColor = .black
        fact1.textAlignment = NSTextAlignment.center
        
        let name = String(welcomeScene.getName())
        if(name!.characters.count >= 25)
        {
            namelabel.font = UIFont(name: "HelveticaNeue", size: 10)
        } else if(name!.characters.count >= 20){
            namelabel.font = UIFont(name: "HelveticaNeue", size: 12)
        } else if(name!.characters.count >= 15){
            namelabel.font = UIFont(name: "HelveticaNeue", size: 14)
        } else if(name!.characters.count >= 10){
            namelabel.font = UIFont(name: "HelveticaNeue", size: 16)
        } else {
            namelabel.font = UIFont(name: "HelveticaNeue", size: 18)
        }
        
        namelabel.attributedText = NSAttributedString(string: name!, attributes: [NSForegroundColorAttributeName : UIColor.white])
        namelabel.textAlignment = NSTextAlignment.left
        self.view?.addSubview(namelabel)
        
        playDRButtonNode = self.childNode(withName: "PlayDRButton") as! SKSpriteNode
        learnMoreButtonNode = self.childNode(withName: "LearnMoreButton") as! SKSpriteNode
        settingsButtonNode = self.childNode(withName: "SettingsNodeImage") as! SKSpriteNode
        settingsButtonNode.texture = SKTexture(imageNamed: "SettingsButton")
        settingsButtonNode.color = .clear
        playLabelNode = self.childNode(withName: "PlayDRLabel") as! SKLabelNode
        learnLabelNode = self.childNode(withName: "LearnMoreLabel") as! SKLabelNode
        
        playButton = self.childNode(withName: "PlayNode") as! SKSpriteNode
        howToPlayButton = self.childNode(withName: "HowToPlayNode") as! SKSpriteNode
        
        

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
                playButton.scale(to: CGSize(width: 200, height: 117))
            }
            if nodesArray.first?.name == "HowToNode" {
                howToPlayButton.scale(to: CGSize(width: 480, height: 117))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "PlayDRButton" {
                playButton.scale(to: CGSize(width: 240, height: 140))
            }
            if nodesArray.first?.name == "HowToNode" {
                howToPlayButton.scale(to: CGSize(width: 576, height: 140))
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "PlayDRButton" {
//                if(Int(playViewController.getDefault()) == 1){
//                    playLabelNode.fontColor = UIColor.lightGray
//                    let when = DispatchTime.now() + 0.1 // change 2 to desired number of seconds
//                    DispatchQueue.main.asyncAfter(deadline: when) {
//                        self.playLabelNode.fontColor = UIColor.init(colorLiteralRed: 0.0, green: 0.980, blue: 0.575, alpha: 1)
//                    }
//                    let transition = SKTransition.crossFade(withDuration: 0.5)
//                    let gameScene = MenuScene(fileNamed: "InstructionScene1")
//                    gameScene?.scaleMode = .aspectFill
//                    let when2 = DispatchTime.now() + 0.15 // change 2 to desired number of seconds
//                    DispatchQueue.main.asyncAfter(deadline: when2) {
//                        self.namelabel.isHidden = true
//                        self.fact1.isHidden = true
//                        self.view?.presentScene(gameScene!, transition: transition)
//                    }
//                }
//                else{
                    playButton.scale(to: CGSize(width: 240, height: 140))
                    playLabelNode.fontColor = UIColor.lightGray
                    let when = DispatchTime.now() + 0.1 // change 2 to desired number of seconds
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        self.playLabelNode.fontColor = UIColor.init(colorLiteralRed: 0.0, green: 0.980, blue: 0.575, alpha: 1)
                    }
                    let transition = SKTransition.doorsOpenVertical(withDuration: 1)
                    let gameScene = GameScene(fileNamed: "GameScene")
                    gameScene?.scaleMode = .aspectFill
                    let when2 = DispatchTime.now() + 0.15 // change 2 to desired number of seconds
                    DispatchQueue.main.asyncAfter(deadline: when2) {
                        self.namelabel.isHidden = true
                        self.fact1.isHidden = true
                        self.view?.presentScene(gameScene!, transition: transition)
                    }
                //}
            }
            if nodesArray.first?.name == "HowToNode" {
                howToPlayButton.scale(to: CGSize(width: 576, height: 140))
                playLabelNode.fontColor = UIColor.lightGray
                let when = DispatchTime.now() + 0.1 // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.playLabelNode.fontColor = UIColor.init(colorLiteralRed: 0.0, green: 0.980, blue: 0.575, alpha: 1)
                }
                let transition = SKTransition.push(with: SKTransitionDirection.left, duration: 0.5)
                let gameScene = GameScene(fileNamed: "InstructionScene1")
                gameScene?.scaleMode = .aspectFill
                let when2 = DispatchTime.now() + 0.15 // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when2) {
                    self.namelabel.isHidden = true
                    self.fact1.isHidden = true
                    self.view?.presentScene(gameScene!, transition: transition)
                }
            }
        }
    }
}
