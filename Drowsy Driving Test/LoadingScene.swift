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
import AVFoundation

class LoadingScene: SKScene {
    var gameViewController = GameViewController()
    
    var touchLabel = SKLabelNode(fontNamed: "Helvetica")
    var animateLabel = SKAction.sequence([SKAction.fadeIn(withDuration: 0.8), SKAction.wait(forDuration: 0.5), SKAction.fadeOut(withDuration: 0.8)])
    
    override func didMove(to view: SKView) {
        let particlePath = Bundle.main.path(forResource: "SparkEmitter", ofType: "sks")!
        let particle = NSKeyedUnarchiver.unarchiveObject(withFile: particlePath) as! SKEmitterNode
        particle.position = CGPoint.zero
        particle.targetNode = self
        addChild(particle)
        
        touchLabel.text = "Tap anywhere to begin"
        touchLabel.position = CGPoint(x: 0, y: 300)

        let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.addChild(self.touchLabel)
            self.touchLabel.run(SKAction.fadeOut(withDuration: 0))
            self.touchLabel.run(SKAction.repeatForever(self.animateLabel))
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let gameScene = MenuScene(fileNamed: "MenuScene")
        gameScene?.scaleMode = .aspectFill
        self.view?.presentScene(gameScene!, transition: transition)
    }
}
