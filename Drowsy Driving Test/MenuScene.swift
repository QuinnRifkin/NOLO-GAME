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
    
    let gameViewController = GameViewController()
    
    var PlayDRButtonNode:SKSpriteNode!
    var LearnMoreButtonNode:SKSpriteNode!
    var factBar:SKSpriteNode!
    var SettingsButtonNode: SKSpriteNode!
    
    let random = Int(arc4random_uniform(5))
    var sleepFactz = [String]()
    
    let welcomeScene = WelcomeScene()
    
    let namelabel = UILabel(frame: CGRect(x: 6, y: -20, width: 300, height: 100))
    
    var fact : String!
    
    var fact1 : UILabel!
    
    override func didMove(to view: SKView) {
        
        factBar = self.childNode(withName: "factBar") as! SKSpriteNode

        sleepFactz = ["Sleep deprivation can result in obesity and poor diet quality.", "Sleep deprivation causes heart disease.", "Sleep deprivation increases the risk of diabetes.", "Not getting enough sleep can result in rash decision making.", "Drowsy driving can be as dangerous as drunk driving.", "Getting more sleep is proven to increase performance in school.", "Putting your phone away before bed will result in a much better sleep.", "Beauty Sleep is real; Going to bed earlier can improve your physical appearance."]

        fact = (String) (sleepFactz[Int(arc4random_uniform(8))])
        
        fact1 = UILabel(frame: CGRect(x: 50 , y: -(factBar.position.y) - 20, width: 270, height: 150))
        
        fact1.text = fact
        fact1.font = UIFont(name: "HelveticaNeue-LightItalic", size: 20)
        fact1.lineBreakMode = NSLineBreakMode.byWordWrapping
        fact1.numberOfLines = 0
        fact1.textColor = .white
        fact1.textAlignment = NSTextAlignment.center
        
        let name = String(welcomeScene.getName())
        namelabel.attributedText = NSAttributedString(string: name!, attributes: [NSForegroundColorAttributeName : UIColor.white])
        namelabel.textAlignment = NSTextAlignment.left
        namelabel.font = UIFont(name: "HelveticaNeue", size: 15)
        self.view?.addSubview(namelabel)
        
        PlayDRButtonNode = self.childNode(withName: "PlayDRButton") as! SKSpriteNode
        LearnMoreButtonNode = self.childNode(withName: "LearnMoreButton") as! SKSpriteNode
        SettingsButtonNode = self.childNode(withName: "SettingsNodeImage") as! SKSpriteNode
        SettingsButtonNode.texture = SKTexture(imageNamed: "SettingsButton")
        SettingsButtonNode.color = .clear
        
        let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.view?.addSubview(self.fact1)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "PlayDRButton" {
                if(Int(gameViewController.getDefault()) == 1){
                    namelabel.isHidden = true
                    fact1.isHidden = true
                    let transition = SKTransition.crossFade(withDuration: 0.5)
                    let gameScene = MenuScene(fileNamed: "InstructionScene1")
                    gameScene?.scaleMode = .aspectFill
                    self.view?.presentScene(gameScene!, transition: transition)
                }
                else{
                    namelabel.isHidden = true
                    fact1.isHidden = true
                    let transition = SKTransition.doorsOpenVertical(withDuration: 1)
                    let gameScene = GameScene(fileNamed: "GameScene")
                    gameScene?.scaleMode = .aspectFill
                    self.view?.presentScene(gameScene!, transition: transition)
                }
            }
            if nodesArray.first?.name == "LearnMoreButton" {
                namelabel.isHidden = true
                fact1.isHidden = true
                let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 0.5)
                let gameScene = MenuScene(fileNamed: "LearnMoreScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
            if nodesArray.first?.name == "SettingsNode" {
                namelabel.isHidden = true
                fact1.isHidden = true
                let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 0.5)
                let gameScene = MenuScene(fileNamed: "SettingsScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
        }
    }
}
