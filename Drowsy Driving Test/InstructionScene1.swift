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
    
    var InstructionBanner1Node: SKSpriteNode!
    var CarNode: SKSpriteNode!
    var RightArrowBaseNode: SKSpriteNode!
    var RightArrowBottomNode: SKSpriteNode!
    var RightArrowTopNode: SKSpriteNode!
    var LeftArrowBaseNode: SKSpriteNode!
    var LeftArrowBottomNode: SKSpriteNode!
    var LeftArrowTopNode: SKSpriteNode!
    var InstructionBanner2Node: SKSpriteNode!
    var WallNode: SKSpriteNode!
    var ZLeftNode: SKSpriteNode!
    var ZRightNode: SKSpriteNode!
    var ZMiddleNode: SKSpriteNode!
    var ScrollingRightNode: SKSpriteNode!
    var ScrollingMiddleNode: SKSpriteNode!
    var ScrollingLeftNode: SKSpriteNode!
    var PlayButtonNode: SKSpriteNode!
    var InstructionHeaderNode: SKSpriteNode!
    
    let leftshow = SKAction.moveBy(x: -175, y: 0, duration: 1)
    let rightshow = SKAction.moveBy(x: 175, y: 0, duration: 1)
    let left = SKAction.moveBy(x: -750, y: 0, duration: 0.5)
    let right = SKAction.moveBy(x: 750, y: 0, duration: 0.5)
    let pause = SKAction.moveBy(x: 0, y: 0, duration: 0.5)
    
    var Directions: Bool!
    
    func swipeLeft(_ gestureRecognizer: UITapGestureRecognizer){
        if(CarNode.position.x < -750){
            return;
        }
        
        if(CarNode.position.x < 0){
            ScrollingMiddleNode.texture = SKTexture(imageNamed: "ScrollingIcon")
            ScrollingRightNode.texture = SKTexture(imageNamed: "ScrollingIconSelect")
            InstructionHeaderNode.run(left)
        }
        else if(CarNode.position.x == 0){
            ScrollingLeftNode.texture = SKTexture(imageNamed: "ScrollingIcon")
            ScrollingMiddleNode.texture = SKTexture(imageNamed: "ScrollingIconSelect")
        }
        
        InstructionBanner1Node.run(left)
        CarNode.run(left)
        RightArrowBaseNode.run(left)
        RightArrowBottomNode.run(left)
        RightArrowTopNode.run(left)
        LeftArrowBaseNode.run(left)
        LeftArrowBottomNode.run(left)
        LeftArrowTopNode.run(left)
        InstructionBanner2Node.run(left)
        WallNode.run(left)
        ZLeftNode.run(left)
        ZRightNode.run(left)
        ZMiddleNode.run(left)
        PlayButtonNode.run(left)
    }
    func swipeRight(_ gestureRecognizer: UITapGestureRecognizer){
        if(CarNode.position.x == 0){
            return;
        }
        
        if(CarNode.position.x < -750){
            ScrollingRightNode.texture = SKTexture(imageNamed: "ScrollingIcon")
            ScrollingMiddleNode.texture = SKTexture(imageNamed: "ScrollingIconSelect")
            InstructionHeaderNode.run(right)
        }
        else if(CarNode.position.x < 0){
            ScrollingMiddleNode.texture = SKTexture(imageNamed: "ScrollingIcon")
            ScrollingLeftNode.texture = SKTexture(imageNamed: "ScrollingIconSelect")
        }
        
        InstructionBanner1Node.run(right)
        CarNode.run(right)
        RightArrowBaseNode.run(right)
        RightArrowBottomNode.run(right)
        RightArrowTopNode.run(right)
        LeftArrowBaseNode.run(right)
        LeftArrowBottomNode.run(right)
        LeftArrowTopNode.run(right)
        InstructionBanner2Node.run(right)
        WallNode.run(right)
        ZLeftNode.run(right)
        ZRightNode.run(right)
        ZMiddleNode.run(right)
        PlayButtonNode.run(right)
    }

    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        
        let swLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_:)))
        swLeft.direction = .left
        view.addGestureRecognizer(swLeft)
        
        let swRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(_:)))
        swLeft.direction = .left
        view.addGestureRecognizer(swRight)
        
        InstructionBanner1Node = self.childNode(withName: "InstructionBanner1Node") as! SKSpriteNode
        InstructionHeaderNode = self.childNode(withName: "InstructionHeaderNode") as! SKSpriteNode
        CarNode = self.childNode(withName: "CarNode") as! SKSpriteNode
        RightArrowBaseNode = self.childNode(withName: "RightArrowBaseNode") as! SKSpriteNode
        RightArrowBottomNode = self.childNode(withName: "RightArrowBottomNode") as! SKSpriteNode
        RightArrowTopNode = self.childNode(withName: "RightArrowTopNode") as! SKSpriteNode
        LeftArrowBaseNode = self.childNode(withName: "LeftArrowBaseNode") as! SKSpriteNode
        LeftArrowBottomNode = self.childNode(withName: "LeftArrowBottomNode") as! SKSpriteNode
        LeftArrowTopNode = self.childNode(withName: "LeftArrowTopNode") as! SKSpriteNode
        InstructionBanner2Node = self.childNode(withName: "InstructionBanner2Node") as! SKSpriteNode
        WallNode = self.childNode(withName: "WallNode") as! SKSpriteNode
        ZLeftNode = self.childNode(withName: "ZLeftNode") as! SKSpriteNode
        ZRightNode = self.childNode(withName: "ZRightNode") as! SKSpriteNode
        ZMiddleNode = self.childNode(withName: "ZMiddleNode") as! SKSpriteNode
        ScrollingRightNode = self.childNode(withName: "ScrollingRightNode") as! SKSpriteNode
        ScrollingRightNode.texture = SKTexture(imageNamed: "ScrollingIcon")
        ScrollingMiddleNode = self.childNode(withName: "ScrollingMiddleNode") as! SKSpriteNode
        ScrollingMiddleNode.texture = SKTexture(imageNamed: "ScrollingIcon")
        ScrollingLeftNode = self.childNode(withName: "ScrollingLeftNode") as! SKSpriteNode
        ScrollingLeftNode.texture = SKTexture(imageNamed: "ScrollingIconSelect")
        PlayButtonNode = self.childNode(withName: "PlayButtonNode") as! SKSpriteNode
        PlayButtonNode.texture = SKTexture(imageNamed: "PlayButtonNew")
        PlayButtonNode.color = .clear

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "PlayButtonNode" {
                let transition = SKTransition.doorsOpenVertical(withDuration: 1)
                let gameScene = GameScene(fileNamed: "GameScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
        }
    }

}
