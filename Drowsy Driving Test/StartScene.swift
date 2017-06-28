//
//  StartScene.swift
//  Drowsy Driving Test
//
//  Created by Quinn Rifkin on 6/20/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class StartScene: SKScene {
    
    let redButton = "redButton1"
    var redButton1Node:SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = .clear
        let particlePath = Bundle.main.path(forResource: "FireFliesEmitter", ofType: "sks")!
        let particle = NSKeyedUnarchiver.unarchiveObject(withFile: particlePath) as! SKEmitterNode
        particle.position = CGPoint.zero
        particle.zPosition = -1
        particle.targetNode = self
        addChild(particle)
        
        redButton1Node = self.childNode(withName: redButton) as! SKSpriteNode
        redButton1Node.zPosition = 1
        redButton1Node.texture = SKTexture(imageNamed: "redButton1")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == redButton {
                let transition = SKTransition.crossFade(withDuration: 0.05)
                let gameScene = GameScene(fileNamed: "GameScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
        }
    }
}
