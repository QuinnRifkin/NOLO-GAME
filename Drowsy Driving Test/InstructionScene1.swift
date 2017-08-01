//
//  InstructionScene1.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 6/23/17.
//  Copyright © 2017 NoLo. All rights reserved.
//


import SpriteKit
import GameplayKit
import UIKit

class InstructionScene1: SKScene {
    
    var playViewController = (UIApplication.shared.delegate as! AppDelegate).playViewController!
    var gameViewController = GameViewController()
    var welcomeScene = WelcomeScene()
    let namelabel = UILabel(frame: CGRect(x: 6, y: -15, width: 150, height: 100))
    
    var carNode: SKSpriteNode!
    var backLabel: SKSpriteNode!
    
    let left = SKAction.moveBy(x: -120, y: 0, duration: 0.2)
    let right = SKAction.moveBy(x: 120, y: 0, duration: 0.2)
    func swipeLeft(_ gestureRecognizer: UITapGestureRecognizer){
        carNode.run(left)
    }
    func swipeRight(_ gestureRecognizer: UITapGestureRecognizer){
        carNode.run(right)
    }

    override func didMove(to view: SKView) {
        
        let swLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_:)))
        swLeft.direction = .left
        view.addGestureRecognizer(swLeft)
        
        let swRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(_:)))
        swLeft.direction = .left
        view.addGestureRecognizer(swRight)
    
        carNode = self.childNode(withName: "CarNode") as! SKSpriteNode
        backLabel = self.childNode(withName: "BackLabel") as! SKSpriteNode
        
        
        let name = String(welcomeScene.getName())
        if(name!.characters.count >= 25)
        {
            namelabel.font = UIFont(name: "ChalkboardSE-Regular", size: 10)
        } else if(name!.characters.count >= 20){
            namelabel.font = UIFont(name: "ChalkboardSE-Regular", size: 12)
        } else if(name!.characters.count >= 15){
            namelabel.font = UIFont(name: "ChalkboardSE-Regular", size: 14)
        } else if(name!.characters.count >= 10){
            namelabel.font = UIFont(name: "ChalkboardSE-Regular", size: 16)
        } else {
            namelabel.font = UIFont(name: "ChalkboardSE-Regular", size: 18)
        }
        
        namelabel.attributedText = NSAttributedString(string: name!, attributes: [NSForegroundColorAttributeName : UIColor.white])
        namelabel.textAlignment = NSTextAlignment.left
        
        let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.view?.addSubview(self.namelabel)
        }

    }
    override func update(_ currentTime: TimeInterval) {
        playViewController.checkNameLabel(namelabel : namelabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "BackNode" {
                backLabel.scale(to: CGSize(width: 267, height: 100))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "BackNode" {
                backLabel.scale(to: CGSize(width: 320, height: 122))
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "BackNode" {
                backLabel.scale(to: CGSize(width: 320, height: 122))
                namelabel.isHidden = true
                let when = DispatchTime.now() + 0.15 // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.playViewController.sceneTransition(scene: self, transitionScene: "MenuScene", transitionType: SKTransition.push(with: SKTransitionDirection.right, duration: 0.5))
                }
            }
        }
    }
}
