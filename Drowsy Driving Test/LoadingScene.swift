//
//  LoadingScene.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 6/21/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class LoadingScene: SKScene {
    
    override func didMove(to view: SKView) {
        
       // self.backgroundColor = .clear
        
        let particlePath = Bundle.main.path(forResource: "SparkEmitter", ofType: "sks")!
        let particle = NSKeyedUnarchiver.unarchiveObject(withFile: particlePath) as! SKEmitterNode
        particle.position = CGPoint.zero
        particle.targetNode = self
        addChild(particle)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let gameScene = MenuScene(fileNamed: "MenuScene")
        gameScene?.scaleMode = .aspectFill
        self.view?.presentScene(gameScene!, transition: transition)
    }
}
