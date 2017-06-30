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
    
    var PlayDRButtonNode:SKSpriteNode!
    var LearnMoreButtonNode:SKSpriteNode!
    var factBar:SKSpriteNode!
    var SettingsButtonNode: SKSpriteNode!
    
    let random = Int(arc4random_uniform(5))
    var sleepFactz = [String]()
    
    let welcomeScene = WelcomeScene()
    
    let namelabel = UILabel(frame: CGRect(x: 6, y: -40, width: 300, height: 100))
    
    override func didMove(to view: SKView) {
        
       // self.backgroundColor = .blue
        sleepFactz = ["Fact1","Fact2","Fact3","Fact4","Fact5"]
        
        let name = String(welcomeScene.getName())
        namelabel.attributedText = NSAttributedString(string: name!, attributes: [NSForegroundColorAttributeName : UIColor.white])
        namelabel.textAlignment = NSTextAlignment.left
        namelabel.font = UIFont(name: "HelveticaNeue", size: 15)
        self.view?.addSubview(namelabel)
        
        PlayDRButtonNode = self.childNode(withName: "PlayDRButton") as! SKSpriteNode
        LearnMoreButtonNode = self.childNode(withName: "LearnMoreButton") as! SKSpriteNode
        SettingsButtonNode = self.childNode(withName: "SettingsNode") as! SKSpriteNode
        SettingsButtonNode.texture = SKTexture(imageNamed: "SettingsButton")
        SettingsButtonNode.color = .clear
        factBar = self.childNode(withName: "factBar") as! SKSpriteNode
        factBar.texture = SKTexture(imageNamed: (String)(sleepFactz[Int(arc4random_uniform(5))]))
        factBar.color = .clear
        
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "PlayDRButton" {
                namelabel.isHidden = true
                let transition = SKTransition.crossFade(withDuration: 0.5)
                let gameScene = StartScene(fileNamed: "InstructionScene1")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
            if nodesArray.first?.name == "LearnMoreButton" {
                namelabel.isHidden = true
                let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 0.5)
                let gameScene = StartScene(fileNamed: "LearnMoreScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
            if nodesArray.first?.name == "SettingsNode" {
                namelabel.isHidden = true
                let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 0.5)
                let gameScene = StartScene(fileNamed: "SettingsScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }


        }
    }
}
