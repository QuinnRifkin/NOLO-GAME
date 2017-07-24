//
//  CountDownScene.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 7/20/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import UIKit
import SpriteKit

class CountDownScene: SKScene {
    var threeLabel:SKLabelNode!
    var twoLabel:SKLabelNode!
    var oneLabel:SKLabelNode!
    var goLabel:SKLabelNode!
    
    var playViewController = PlayViewController()

    var fadeOut = SKAction.scale(by: 0.9, duration: 0.5)
    
    func fadeOutComplete(label: SKLabelNode, labelNum: Double){
        let when = DispatchTime.now() + (labelNum + 0.5) // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            label.isHidden = false
        }
        let when2 = DispatchTime.now() + (labelNum + 1) // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when2) {
            for _ in 0...50 {
                label.run(self.fadeOut)
            }
        }
        let when3 = DispatchTime.now() + (labelNum + 2) // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when3) {
            label.isHidden = true
        }
    }
    
    func labelSetup(label: SKLabelNode){
        label.isHidden = true
        label.position = CGPoint(x: 0, y: -100)
        label.fontSize = 200
    }

    override func didMove(to view: SKView) {
        threeLabel = self.childNode(withName: "3Label") as! SKLabelNode
        twoLabel = self.childNode(withName: "2Label") as! SKLabelNode
        oneLabel = self.childNode(withName: "1Label") as! SKLabelNode
        goLabel = self.childNode(withName: "GoLabel") as! SKLabelNode
        
        labelSetup(label: threeLabel)
        labelSetup(label: twoLabel)
        labelSetup(label: oneLabel)
        labelSetup(label: goLabel)

        fadeOutComplete(label: threeLabel, labelNum: 0.0)
        fadeOutComplete(label: twoLabel, labelNum: 1.0)
        fadeOutComplete(label: oneLabel, labelNum: 2.0)
        
        let when = DispatchTime.now() + 3.5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.goLabel.isHidden = false
        }
        
        let when2 = DispatchTime.now() + 4 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when2) {
            self.playViewController.sceneTransition(scene: self, transitionScene: "GameScene", transitionType: SKTransition.doorsOpenVertical(withDuration: 1))
        }
    }
}
