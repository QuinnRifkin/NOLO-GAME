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
    
    var instructionBanner1Node: SKSpriteNode!
    var carNode: SKSpriteNode!
    var rightArrowBaseNode: SKSpriteNode!
    var rightArrowBottomNode: SKSpriteNode!
    var rightArrowTopNode: SKSpriteNode!
    var leftArrowBaseNode: SKSpriteNode!
    var leftArrowBottomNode: SKSpriteNode!
    var leftArrowTopNode: SKSpriteNode!
    var instructionBanner2Node: SKSpriteNode!
    var wallNode: SKSpriteNode!
    var zLeftNode: SKSpriteNode!
    var zRightNode: SKSpriteNode!
    var zMiddleNode: SKSpriteNode!
    var scrollingRightNode: SKSpriteNode!
    var scrollingMiddleNode: SKSpriteNode!
    var scrollingLeftNode: SKSpriteNode!
    var playButtonNode: SKSpriteNode!
    var instructionHeaderNode: SKSpriteNode!
    
    let leftShow = SKAction.moveBy(x: -175, y: 0, duration: 1)
    let rightShow = SKAction.moveBy(x: 175, y: 0, duration: 1)
    let left = SKAction.moveBy(x: -750, y: 0, duration: 0.5)
    let right = SKAction.moveBy(x: 750, y: 0, duration: 0.5)
    let pause = SKAction.moveBy(x: 0, y: 0, duration: 0.5)
    
    var Directions: Bool!
    
    func swipeLeft(_ gestureRecognizer: UITapGestureRecognizer){
        if(carNode.position.x < -750){
            return;
        }
        
        if(carNode.position.x < 0){
            scrollingMiddleNode.texture = SKTexture(imageNamed: "ScrollingIcon")
            scrollingRightNode.texture = SKTexture(imageNamed: "ScrollingIconSelect")
            instructionHeaderNode.run(left)
        }
        else if(carNode.position.x == 0){
            scrollingLeftNode.texture = SKTexture(imageNamed: "ScrollingIcon")
            scrollingMiddleNode.texture = SKTexture(imageNamed: "ScrollingIconSelect")
        }
        
        instructionBanner1Node.run(left)
        carNode.run(left)
        rightArrowBaseNode.run(left)
        rightArrowBottomNode.run(left)
        rightArrowTopNode.run(left)
        leftArrowBaseNode.run(left)
        leftArrowBottomNode.run(left)
        leftArrowTopNode.run(left)
        instructionBanner2Node.run(left)
        wallNode.run(left)
        zLeftNode.run(left)
        zRightNode.run(left)
        zMiddleNode.run(left)
        playButtonNode.run(left)
    }
    func swipeRight(_ gestureRecognizer: UITapGestureRecognizer){
        if(carNode.position.x == 0){
            return;
        }
        
        if(carNode.position.x < -750){
            scrollingRightNode.texture = SKTexture(imageNamed: "ScrollingIcon")
            scrollingMiddleNode.texture = SKTexture(imageNamed: "ScrollingIconSelect")
            instructionHeaderNode.run(right)
        }
        else if(carNode.position.x < 0){
            scrollingMiddleNode.texture = SKTexture(imageNamed: "ScrollingIcon")
            scrollingLeftNode.texture = SKTexture(imageNamed: "ScrollingIconSelect")
        }
        
        instructionBanner1Node.run(right)
        carNode.run(right)
        rightArrowBaseNode.run(right)
        rightArrowBottomNode.run(right)
        rightArrowTopNode.run(right)
        leftArrowBaseNode.run(right)
        leftArrowBottomNode.run(right)
        leftArrowTopNode.run(right)
        instructionBanner2Node.run(right)
        wallNode.run(right)
        zLeftNode.run(right)
        zRightNode.run(right)
        zMiddleNode.run(right)
        playButtonNode.run(right)
    }

    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        
        let swLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_:)))
        swLeft.direction = .left
        view.addGestureRecognizer(swLeft)
        
        let swRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(_:)))
        swLeft.direction = .left
        view.addGestureRecognizer(swRight)
        
        instructionBanner1Node = self.childNode(withName: "InstructionBanner1Node") as! SKSpriteNode
        instructionHeaderNode = self.childNode(withName: "InstructionHeaderNode") as! SKSpriteNode
        carNode = self.childNode(withName: "CarNode") as! SKSpriteNode
        rightArrowBaseNode = self.childNode(withName: "RightArrowBaseNode") as! SKSpriteNode
        rightArrowBottomNode = self.childNode(withName: "RightArrowBottomNode") as! SKSpriteNode
        rightArrowTopNode = self.childNode(withName: "RightArrowTopNode") as! SKSpriteNode
        leftArrowBaseNode = self.childNode(withName: "LeftArrowBaseNode") as! SKSpriteNode
        leftArrowBottomNode = self.childNode(withName: "LeftArrowBottomNode") as! SKSpriteNode
        leftArrowTopNode = self.childNode(withName: "LeftArrowTopNode") as! SKSpriteNode
        instructionBanner2Node = self.childNode(withName: "InstructionBanner2Node") as! SKSpriteNode
        wallNode = self.childNode(withName: "WallNode") as! SKSpriteNode
        zLeftNode = self.childNode(withName: "ZLeftNode") as! SKSpriteNode
        zRightNode = self.childNode(withName: "ZRightNode") as! SKSpriteNode
        zMiddleNode = self.childNode(withName: "ZMiddleNode") as! SKSpriteNode
        scrollingRightNode = self.childNode(withName: "ScrollingRightNode") as! SKSpriteNode
        scrollingRightNode.texture = SKTexture(imageNamed: "ScrollingIcon")
        scrollingMiddleNode = self.childNode(withName: "ScrollingMiddleNode") as! SKSpriteNode
        scrollingMiddleNode.texture = SKTexture(imageNamed: "ScrollingIcon")
        scrollingLeftNode = self.childNode(withName: "ScrollingLeftNode") as! SKSpriteNode
        scrollingLeftNode.texture = SKTexture(imageNamed: "ScrollingIconSelect")
        playButtonNode = self.childNode(withName: "PlayButtonNode") as! SKSpriteNode
        playButtonNode.texture = SKTexture(imageNamed: "PlayButtonNew")
        playButtonNode.color = .clear

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
