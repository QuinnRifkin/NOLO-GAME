//
//  LearnMoreScene.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 6/23/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class LearnMoreScene: SKScene {
    
    var HomeButtonNode:SKSpriteNode!
    var GoogleButtonNode: SKSpriteNode!

    let welcomeScene = WelcomeScene()
    
    let namelabel = UILabel(frame: CGRect(x: 6, y: -40, width: 300, height: 100))
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        
        HomeButtonNode = self.childNode(withName: "HomeNode") as! SKSpriteNode
        HomeButtonNode.texture = SKTexture(imageNamed: "HomeLabel")
        HomeButtonNode.color = .clear
        
        GoogleButtonNode = self.childNode(withName: "GoogleNode") as! SKSpriteNode
        
        let name = String(welcomeScene.getName())
        namelabel.attributedText = NSAttributedString(string: name!, attributes: [NSForegroundColorAttributeName : UIColor.white])
        namelabel.textAlignment = NSTextAlignment.left
        namelabel.font = UIFont(name: "HelveticaNeue", size: 15)
        self.view?.addSubview(namelabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "HomeNode" {
                namelabel.isHidden = true
                let transition = SKTransition.crossFade(withDuration: 0.05)
                let gameScene = StartScene(fileNamed: "MenuScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
            if nodesArray.first?.name == "GoogleNode"{
                namelabel.isHidden = true
                if let google = NSURL(string: "http://www.google.com"){
                    UIApplication.shared.open(google as URL, options: [:], completionHandler: nil)
                }
            }
        }
    }
}