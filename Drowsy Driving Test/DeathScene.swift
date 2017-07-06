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
    var zCountLabel : UILabel!
    
    var sleepFactz = [String]()
    
    var fact : String!
    
    var fact1 : UILabel!
    
    override func didMove(to view: SKView) {
        
        zCountLabel = UILabel(frame: CGRect(x: self.frame.width/6.5, y: self.frame.height/7, width: 200, height: 40))
        
        highscorelabel = UILabel(frame: CGRect(x: self.frame.width/8, y: self.frame.height/6, width: 200, height: 40))
        
        PlayAgainButtonNode = self.childNode(withName: "PlayAgainNode") as! SKSpriteNode
        HomeButtonNode = self.childNode(withName: "HomeNode") as! SKSpriteNode
        
        factBar = self.childNode(withName: "factBar") as! SKSpriteNode
       
        sleepFactz = ["Sleep deprivation can result in obesity and poor diet quality.", "Sleep deprivation causes heart disease.", "Sleep deprivation increases the risk of diabetes.", "Not getting enough sleep can result in rash decision making.", "Drowsy driving can be as dangerous as drunk driving.", "Getting more sleep is proven to increase performance in school.", "Putting your phone away before bed will result in a much better sleep.", "Beauty Sleep is real; Going to bed earlier can improve your physical appearance."]
        
        fact = (String) (sleepFactz[Int(arc4random_uniform(8))])
        
        fact1 = UILabel(frame: CGRect(x: 50 , y: -(factBar.position.y) - 20, width: 270, height: 150))
        
        fact1.text = fact
        fact1.font = UIFont(name: "HelveticaNeue-LightItalic", size: 20)
        fact1.lineBreakMode = NSLineBreakMode.byWordWrapping
        fact1.numberOfLines = 0
        fact1.textColor = .white
        fact1.textAlignment = NSTextAlignment.center
        
        //zCountLabel.frame = CGRect(x: 100, y: 125, width: 200, height: 200)
        zCountLabel.textAlignment = NSTextAlignment.left
        zCountLabel.textColor = .white
        zCountLabel.font = UIFont(name: "HelveticaNeue" , size: 30)
        zCountLabel.text = "Z Count: " + String( gameScene.getFinishZCount())
        
        //highscorelabel.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        highscorelabel.textAlignment = NSTextAlignment.left
        highscorelabel.textColor = .white
        highscorelabel.font = UIFont(name: "HelveticaNeue" , size: 30)
        highscorelabel.text = "Highscore: " + String( gameScene.getHighScore())
        
        let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.view?.addSubview(self.highscorelabel)
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
                highscorelabel.isHidden = true
                let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 0.5)
                let gameScene = DeathScene(fileNamed: "MenuScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
            if nodesArray.first?.name == "PlayAgainNode" {
                zCountLabel.isHidden = true
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
