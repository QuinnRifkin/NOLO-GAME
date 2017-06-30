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
    var TimeLabelNode: SKSpriteNode!
    var HighScoreLabelNode: SKSpriteNode!
    var factBar:SKSpriteNode!
    
    var gameScene = GameScene()
    
    let timelabel = UILabel(frame: CGRect(x: -90, y: 230, width: 500, height: 100))
    let highscorelabel = UILabel(frame: CGRect(x: 20, y: 230, width: 500, height: 100))
    
    var sleepFactz = [String]()
    
    override func didMove(to view: SKView) {
        //self.backgroundColor = .clear
        
        sleepFactz = ["Fact1","Fact2","Fact3","Fact4","Fact5"]
        
        PlayAgainButtonNode = self.childNode(withName: "PlayAgainNode") as! SKSpriteNode
        PlayAgainButtonNode.texture = SKTexture(imageNamed: "PlayAgainButton")
        PlayAgainButtonNode.color = .clear
        HomeButtonNode = self.childNode(withName: "HomeNode") as! SKSpriteNode
        HomeButtonNode.texture = SKTexture(imageNamed: "HomeLabel")
        HomeButtonNode.color = .clear
        TimeLabelNode = self.childNode(withName: "TimeNode") as! SKSpriteNode
        TimeLabelNode.texture = SKTexture(imageNamed: "TimeLabel")
        TimeLabelNode.color = .clear
        HighScoreLabelNode = self.childNode(withName: "HighScoreNode") as! SKSpriteNode
        HighScoreLabelNode.texture = SKTexture(imageNamed: "HighScoreLabel")
        HighScoreLabelNode.color = .clear
        
        factBar = self.childNode(withName: "factBar") as! SKSpriteNode
        factBar.texture = SKTexture(imageNamed: (String)(sleepFactz[Int(arc4random_uniform(5))]))
        factBar.color = .clear
        
        timelabel.textAlignment = NSTextAlignment.center
        timelabel.textColor = .white
        timelabel.text = String( gameScene.getFinishTime())
        self.view?.addSubview(timelabel)
        
        highscorelabel.textAlignment = NSTextAlignment.center
        highscorelabel.textColor = .white
        highscorelabel.text = String( gameScene.getHighScore())
        self.view?.addSubview(highscorelabel)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "HomeNode" {
                timelabel.isHidden = true
                highscorelabel.isHidden = true
                let transition = SKTransition.crossFade(withDuration: 0.05)
                let gameScene = StartScene(fileNamed: "MenuScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
            if nodesArray.first?.name == "PlayAgainNode" {
                timelabel.isHidden = true
                highscorelabel.isHidden = true
                let transition = SKTransition.crossFade(withDuration: 0.05)
                let gameScene = StartScene(fileNamed: "GameScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
        }
    }
}
