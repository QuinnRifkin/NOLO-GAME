//
//  DeathScene.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 6/23/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class DeathScene: SKScene {
    
    let bouncingText = SKAction.sequence([SKAction.moveBy(x: 0, y: -10, duration: 0.6), SKAction.wait(forDuration: 0.1), SKAction.moveBy(x: 0, y: 10, duration: 0.6), SKAction.wait(forDuration: 0.1)])
    
    var playAgainButtonNode:SKSpriteNode!
    var homeButtonNode: SKSpriteNode!
    var factBar:SKSpriteNode!
    var screenNode:SKSpriteNode!
    var screenHandleNode:SKSpriteNode!
    var popLabelBar:SKSpriteNode!
    var playAgain:SKSpriteNode!
    
    var playLabelNode: SKLabelNode!
    var homeLabelNode: SKLabelNode!
    var popLabel1:SKLabelNode!
    var popLabel2:SKLabelNode!
    var popLabel3:SKLabelNode!
    var popLabel4:SKLabelNode!
    
    var gameScene = GameScene()
    var gameViewController = GameViewController()
    var playViewController = PlayViewController() //(UIApplication.shared.delegate as! AppDelegate).playViewController!
    
    var timeLabel : UILabel!
    var highScoreLabel : UILabel!
    var zCountLabel : UILabel!
    
    var sleepFactz = [String]()

    var fact : String!
    
    var fact1 : UILabel!
    
    var screenElements : [SKSpriteNode] = []
    var screenLabels : [SKLabelNode] = []
    
    func hideLabels(){
        zCountLabel.isHidden = true
        fact1.isHidden = true
        highScoreLabel.isHidden = true
    }
    
    let screenUp = SKAction.moveBy(x: 0, y: 1334, duration: 0.5)
    let screenDown = SKAction.moveBy(x: 0, y: -1334, duration: 0.5)
    let screenBounce = SKAction.sequence([SKAction.moveBy(x: 0, y: -40, duration: 0.4), SKAction.moveBy(x: 0, y: 40, duration: 0.2), SKAction.moveBy(x: 0, y: -15, duration: 0.2), SKAction.moveBy(x: 0, y: 15, duration: 0.1)])
    
    func screenShow(){
        for elements in screenElements{
            elements.run(screenUp)
        }
        for labels in screenLabels{
            labels.run(screenUp)
        }    }
    
    func swipeDown(_ gestureRecognizer: UITapGestureRecognizer){
        for elements in screenElements{
            elements.run(screenDown)
        }
        for labels in screenLabels{
            labels.run(screenDown)
        }
        let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.showLabels()
        }
    }
    
    func showLabels(){
        view?.addSubview(highScoreLabel)
        view?.addSubview(zCountLabel)
        view?.addSubview(fact1)
        playAgainButtonNode.isHidden = false
    }
    
    func bounceCheck(time: Double){
        let when = DispatchTime.now() + time // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            if(self.screenNode.position.y == 0){
                for elements in self.screenElements{
                    elements.run(self.screenBounce)
                }
                for labels in self.screenLabels{
                    labels.run(self.screenBounce)
                }
            }
        }
    }
    
    override func didMove(to view: SKView) {
        //playViewController.tabBarController?.tabBar.isHidden = false
        
        let swDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown(_:)))
        swDown.direction = .down
        view.addGestureRecognizer(swDown)
        
        zCountLabel = UILabel(frame: CGRect(x: self.frame.width/7.7, y: self.frame.height/7.1, width: 250, height: 40))
        
        highScoreLabel = UILabel(frame: CGRect(x: self.frame.width/7.7, y: self.frame.height/5.6, width: 300, height: 40))

        playAgainButtonNode = self.childNode(withName: "PlayAgainNode") as! SKSpriteNode
        homeButtonNode = self.childNode(withName: "HomeNode") as! SKSpriteNode
        playLabelNode = self.childNode(withName: "PlayAgainLabel") as! SKLabelNode
        homeLabelNode = self.childNode(withName: "HomeLabel") as! SKLabelNode
        screenNode = self.childNode(withName: "ScreenNode") as! SKSpriteNode
        screenHandleNode = self.childNode(withName: "ScreenHandle") as! SKSpriteNode
        popLabelBar = self.childNode(withName: "PopupLabelBar") as! SKSpriteNode
        popLabel1 = self.childNode(withName: "PopupLabel1") as! SKLabelNode
        popLabel2 = self.childNode(withName: "PopupLabel2") as! SKLabelNode
        popLabel3 = self.childNode(withName: "PopupLabel3") as! SKLabelNode
        popLabel4 = self.childNode(withName: "PopupLabel4") as! SKLabelNode
        playAgain = self.childNode(withName: "PlayAgain") as! SKSpriteNode
        
        playAgain.run(SKAction.repeatForever(bouncingText))
        
        factBar = self.childNode(withName: "factBar") as! SKSpriteNode
        
        playAgainButtonNode.isHidden = true
        
        screenNode.position = CGPoint(x: 0, y: -1334)
        screenHandleNode.position = CGPoint(x: 0, y: -730)
        popLabelBar.position = CGPoint(x: 0, y: -1321)
        popLabel1.position = CGPoint(x: 0, y: -1258)
        popLabel2.position = CGPoint(x: 0, y: -1318)
        popLabel3.position = CGPoint(x: 0, y: -1378)
        popLabel4.position = CGPoint(x: 0, y: -1408)
        
        screenElements = [screenNode, screenHandleNode, popLabelBar]
        screenLabels = [popLabel1, popLabel2, popLabel3, popLabel4]
        
        screenShow()
        
        sleepFactz = ["Sleep deprivation can result in obesity and poor diet quality.", "Sleep deprivation causes heart disease.", "Sleep deprivation increases the risk of diabetes.", "Not getting enough sleep can result in rash decision making.", "Drowsy driving can be as dangerous as drunk driving.", "Getting more sleep is proven to increase performance in school.", "Putting your phone away before bed will result in a much better sleep.", "Beauty Sleep is real; Going to bed earlier can improve your physical appearance.", "An average of 83,000 car crashes occur each year due to drowsy driving.", "Less than 30% of highschool students get sufficient sleep (8-10hrs).", "Humans are the only mammals that delay their sleep on purpose.", "Exercising on a regular basis makes it easier to fall asleep.", "12% of people dream in black and white.", "Sleep deprivation can kill you faster than food deprivaton.", "If falling asleep takes less than 10 minutes, chances are you are sleep deprived."]
        
        fact = (String) (sleepFactz[Int(arc4random_uniform(15))])
        
        fact1 = UILabel(frame: CGRect(x: 50 , y: -(factBar.position.y) + 30, width: 270, height: 150))
        
        fact1.text = fact
        fact1.font = UIFont(name: "ChalkboardSE-Regular", size: 20)
        fact1.lineBreakMode = NSLineBreakMode.byWordWrapping
        fact1.numberOfLines = 0
        fact1.textColor = .black
        fact1.textAlignment = NSTextAlignment.center
        
        zCountLabel.textAlignment = NSTextAlignment.left
        zCountLabel.textColor = .white
        zCountLabel.font = UIFont(name: "PressStart2P" , size: 20)
        zCountLabel.text = "        " + String( gameScene.getFinishZCount())
        
        highScoreLabel.textAlignment = NSTextAlignment.left
        highScoreLabel.textColor = .white
        highScoreLabel.font = UIFont(name: "PressStart2P" , size: 20)
        highScoreLabel.text = "        " + String( gameScene.getHighScore())

        bounceCheck(time: 8.0)
        bounceCheck(time: 10.0)
        bounceCheck(time: 12.0)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
//            if nodesArray.first?.name == "HomeNode" {
//                homeLabelNode.fontColor = UIColor.lightGray
//                let when = DispatchTime.now() + 0.1 // change 2 to desired number of seconds
//                DispatchQueue.main.asyncAfter(deadline: when) {
//                    self.homeLabelNode.fontColor = UIColor.init(colorLiteralRed: 0.0, green: 0.980, blue: 0.575, alpha: 1)
//                }
//                let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 0.5)
//                let gameScene = DeathScene(fileNamed: "MenuScene")
//                gameScene?.scaleMode = .aspectFill
//                let when2 = DispatchTime.now() + 0.15 // change 2 to desired number of seconds
//                DispatchQueue.main.asyncAfter(deadline: when2) {
//                    self.zCountLabel.isHidden = true
//                    self.fact1.isHidden = true
//                    self.highScoreLabel.isHidden = true
//                    self.view?.presentScene(gameScene!, transition: transition)
//                }
//            }
            if nodesArray.first?.name == "PlayAgainNode" {
                playViewController.tabBarController?.tabBar.isHidden = true
                gameViewController.labelTransition(label: playLabelNode, color: UIColor.init(colorLiteralRed: 0.0, green: 0.980, blue: 0.575, alpha: 1), scene: self, transitionScene: "GameScene", transitionType: SKTransition.push(with: SKTransitionDirection.down, duration: 1) )
                hideLabels()
            }
        }
    }
}
