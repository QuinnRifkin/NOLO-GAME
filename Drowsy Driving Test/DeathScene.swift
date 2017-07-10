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
    
    var playAgainButtonNode:SKSpriteNode!
    var homeButtonNode: SKSpriteNode!
    var factBar:SKSpriteNode!
    
    var gameScene = GameScene()
    
    var timeLabel : UILabel!
    var highScoreLabel : UILabel!
    var zCountLabel : UILabel!
    
    var sleepFactz = [String]()
    
    var fact : String!
    
    var fact1 : UILabel!
    
    override func didMove(to view: SKView) {
        
        zCountLabel = UILabel(frame: CGRect(x: self.frame.width/8, y: self.frame.height/6.5, width: 250, height: 40))
        
        highScoreLabel = UILabel(frame: CGRect(x: self.frame.width/13, y: self.frame.height/5.5, width: 300, height: 40))

        
        playAgainButtonNode = self.childNode(withName: "PlayAgainNode") as! SKSpriteNode
        homeButtonNode = self.childNode(withName: "HomeNode") as! SKSpriteNode
        
        factBar = self.childNode(withName: "factBar") as! SKSpriteNode
       
        sleepFactz = ["Sleep deprivation can result in obesity and poor diet quality.", "Sleep deprivation causes heart disease.", "Sleep deprivation increases the risk of diabetes.", "Not getting enough sleep can result in rash decision making.", "Drowsy driving can be as dangerous as drunk driving.", "Getting more sleep is proven to increase performance in school.", "Putting your phone away before bed will result in a much better sleep.", "Beauty Sleep is real; Going to bed earlier can improve your physical appearance.", "An average of 83,000 car crashes occur each year due to drowsy driving.", "Less than 30% of highschool students get sufficient sleep (8-10hrs)", "Humans are the only mammals that delay their sleep on purpose", "Exercising on a regular basis makes it easier to fall asleep", "12% of people dream in black and white", "Sleep deprivation can kill you faster than food deprivaton", "If falling asleep takes less than 10 minutes, chances are you are sleep deprived"]
        
        fact = (String) (sleepFactz[Int(arc4random_uniform(15))])
        
        fact1 = UILabel(frame: CGRect(x: 50 , y: -(factBar.position.y) - 20, width: 270, height: 150))
        
        fact1.text = fact
        fact1.font = UIFont(name: "HelveticaNeue-LightItalic", size: 20)
        fact1.lineBreakMode = NSLineBreakMode.byWordWrapping
        fact1.numberOfLines = 0
        fact1.textColor = .white
        fact1.textAlignment = NSTextAlignment.center
        
        zCountLabel.textAlignment = NSTextAlignment.left
        zCountLabel.textColor = .white
        zCountLabel.font = UIFont(name: "PressStart2P" , size: 20)
        zCountLabel.text = "Z Count: " + String( gameScene.getFinishZCount())
        
        highScoreLabel.textAlignment = NSTextAlignment.left
        highScoreLabel.textColor = .white
        highScoreLabel.font = UIFont(name: "PressStart2P" , size: 20)
        highScoreLabel.text = "Highscore: " + String( gameScene.getHighScore())

        let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.view?.addSubview(self.highScoreLabel)
            self.view?.addSubview(self.zCountLabel)
            self.view?.addSubview(self.fact1)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "HomeNode" {
                zCountLabel.isHidden = true
                fact1.isHidden = true
                highScoreLabel.isHidden = true
                let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 0.5)
                let gameScene = DeathScene(fileNamed: "MenuScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
            if nodesArray.first?.name == "PlayAgainNode" {
                zCountLabel.isHidden = true
                fact1.isHidden = true
                highScoreLabel.isHidden = true
                let transition = SKTransition.push(with: SKTransitionDirection.down, duration: 1)
                let gameScene = DeathScene(fileNamed: "GameScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
        }
    }
}
