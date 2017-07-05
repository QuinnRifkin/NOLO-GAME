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
    
    var PlayAgainButtonNode:SKSpriteNode!
    var HomeButtonNode: SKSpriteNode!
    var factBar:SKSpriteNode!
    
    var gameScene = GameScene()
    
    var timelabel : UILabel!
    var highscorelabel : UILabel!
    
    var sleepFactz = [String]()
    
    var fact : String!
    
    var fact1 : UILabel!
    
    override func didMove(to view: SKView) {
        
        timelabel = UILabel(frame: CGRect(x: self.frame.width/8, y: self.frame.height/5, width: 150, height: 20))
        highscorelabel = UILabel(frame: CGRect(x: self.frame.width/4, y: self.frame.height/5, width: 150, height: 20))
        
        PlayAgainButtonNode = self.childNode(withName: "PlayAgainNode") as! SKSpriteNode
        HomeButtonNode = self.childNode(withName: "HomeNode") as! SKSpriteNode
        
        factBar = self.childNode(withName: "factBar") as! SKSpriteNode
       
        sleepFactz = ["Sleep deprivation can result in obesity and poor diet quality.", "Sleep deprivation causes heart disease.", "Sleep deprivation increases the risk of diabetes.", "Not getting enough sleep can result in rash decision making.", "Drowsy driving can be as dangerous as drunk driving.", "Getting more sleep is proven to increase performance in school.", "Putting your phone away before bed will result in a much better sleep.", "Beauty Sleep is real; Going to bed earlier can improve your physical appearance."]
        
        fact = (String) (sleepFactz[Int(arc4random_uniform(8))])
        
        fact1 = UILabel(frame: CGRect(x: 50 , y: -(factBar.position.y) - 20, width: 270, height: 150))
        
        fact1.text = fact
        fact1.font = UIFont(name: "HelveticaNeue-Light", size: 19)
        fact1.lineBreakMode = NSLineBreakMode.byWordWrapping
        fact1.numberOfLines = 0
        fact1.textColor = .white
        fact1.textAlignment = NSTextAlignment.center
        
        timelabel.textAlignment = NSTextAlignment.left
        timelabel.textColor = .white
        timelabel.text = "Time: " + String( gameScene.getFinishTime())
        
        highscorelabel.textAlignment = NSTextAlignment.left
        highscorelabel.textColor = .white
        highscorelabel.text = "Highscore: " + String( gameScene.getHighScore())
        
        let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.view?.addSubview(self.timelabel)
            self.view?.addSubview(self.highscorelabel)
            self.view?.addSubview(self.fact1)
        }

        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "HomeNode" {
                timelabel.isHidden = true
                fact1.isHidden = true
                highscorelabel.isHidden = true
                let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 0.5)
                let gameScene = DeathScene(fileNamed: "MenuScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
            if nodesArray.first?.name == "PlayAgainNode" {
                timelabel.isHidden = true
                fact1.isHidden = true
                highscorelabel.isHidden = true
                let transition = SKTransition.push(with: SKTransitionDirection.down, duration: 1)
                let gameScene = DeathScene(fileNamed: "GameScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
        }
    }
}
