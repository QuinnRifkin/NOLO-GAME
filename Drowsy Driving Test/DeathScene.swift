//
//  DeathScene.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 6/23/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class DeathScene: SKScene {
    
    let bouncingText = SKAction.sequence([SKAction.moveBy(x: 0, y: -10, duration: 0.6), SKAction.wait(forDuration: 0.1), SKAction.moveBy(x: 0, y: 10, duration: 0.6), SKAction.wait(forDuration: 0.1)])
    
    var playAgainButtonNode:SKSpriteNode!
    var factBar:SKSpriteNode!
    var playAgain:SKSpriteNode!
    
    var popUp = UIView()
    var blur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    var popUpView = UIView()
    var popUpLabel = UILabel()
    var dismissPopUp = UILabel()
    var dismissPopUpNode = UIButton()
    var popUpHandle = UIView()
    
    var gameScene = GameScene()
    var playViewController = (UIApplication.shared.delegate as! AppDelegate).playViewController!
    let welcomeScene = WelcomeScene()
    let namelabel = UILabel(frame: CGRect(x: 6, y: -15, width: 150, height: 100))
    
    var timeLabel : UILabel!
    var highScoreLabel : UILabel!
    var zCountLabel : UILabel!
    
    var sleepFactz = [String]()

    var fact : String!
    
    var fact1 : UILabel!
    
    var screenElements : [SKSpriteNode] = []
    var screenLabels : [SKLabelNode] = []
    
    func hideLabels(){
        zCountLabel.isHidden = true
        fact1.isHidden = true
        highScoreLabel.isHidden = true
    }
    
    let screenUp = SKAction.moveBy(x: 0, y: 1334, duration: 0.5)
    let screenDown = SKAction.moveBy(x: 0, y: -1334, duration: 0.5)
    let screenBounce = SKAction.sequence([SKAction.moveBy(x: 0, y: -40, duration: 0.4), SKAction.moveBy(x: 0, y: 40, duration: 0.2), SKAction.moveBy(x: 0, y: -15, duration: 0.2), SKAction.moveBy(x: 0, y: 15, duration: 0.1)])
    
    func showLabels(){
        view?.addSubview(highScoreLabel)
        view?.addSubview(zCountLabel)
        view?.addSubview(fact1)
        playAgainButtonNode.isHidden = false
    }
    
    func showView(){
        self.view?.addSubview(popUp)
        self.popUp.addSubview(blur)
        self.popUp.addSubview(popUpView)
        self.popUp.addSubview(popUpLabel)
        self.popUp.addSubview(dismissPopUpNode)
        self.popUp.addSubview(popUpHandle)
        
        UIView.animate(withDuration: 0.8, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            self.popUp.frame = CGRect(x: self.popUp.frame.origin.x, y: self.popUp.frame.origin.y + ((self.popUp.frame.height)*2), width: self.popUp.frame.size.width, height: self.popUp.frame.size.height)
        }, completion: { (finished) -> Void in
            print(self.popUp.center)
        })
    }
    
    func dismiss(){
        print("Dismissed")
        
        UIView.animate(withDuration: 0.8, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            self.popUp.frame = CGRect(x: self.popUp.frame.origin.x, y: self.popUp.frame.origin.y - self.popUp.frame.height, width: self.popUp.frame.size.width, height: self.popUp.frame.size.height)
        }, completion: { (finished) -> Void in
            self.popUp.removeFromSuperview()
            self.showLabels()
        })
    }
    
    func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            if(self.popUp.center.y <= 1001){
                let translation = gestureRecognizer.translation(in: self.view)
                self.popUp.center = CGPoint(x: self.popUp.center.x, y: self.popUp.center.y + translation.y)
                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
                print(self.popUp.center)
            }else if(self.popUp.center.y > 1001){
                UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                    self.popUp.center = CGPoint(x: self.popUp.center.x, y: 1000.5)
                }, completion: { (finished) -> Void in
                    print("reset")
                })
                let when = DispatchTime.now() + 0.05 // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
                    UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                        self.popUp.center = CGPoint(x: self.popUp.center.x, y: 1000.5)
                    }, completion: { (finished) -> Void in
                        print("reset2")
                    })
                }
            }
        }
        if(gestureRecognizer.velocity(in: self.view).y <= -1400 || (gestureRecognizer.state == .ended && popUp.center.y <= 675)){
            dismiss()
        }
//        if(gestureRecognizer.state == .ended && popUp.center.y <= 675){
//            dismiss()
//        }
        if(gestureRecognizer.state == .ended && popUp.center.y >= 500){
            UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                self.popUp.center = CGPoint(x: self.popUp.center.x, y: 1000.5 + -45)
            }, completion: { (finished) -> Void in
                print("reset3")
            })
        }
    }

    var gestureRecognizer: UIPanGestureRecognizer!
    
    func addGesture(){
        gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view?.addGestureRecognizer(gestureRecognizer)
    }
    
    func removeGesture(){
        view?.removeGestureRecognizer(gestureRecognizer)
    }
    
    override func didMove(to view: SKView) {
        
        self.addGesture()

        popUp.frame = (self.view?.bounds)!
        popUp.center = CGPoint(x: ((self.view?.center.x)!), y: ((self.view?.center.y)! - (self.popUp.frame.height)) - (45))
        
        popUpView.layer.cornerRadius = 20
        popUpView.bounds = CGRect(x: 0, y: 0, width: 300, height: 180)
        popUpView.center = CGPoint(x: ((self.popUp.center.x)), y: (self.popUp.center.y) + (45))
        popUpView.backgroundColor = UIColor.red
        popUpView.layer.opacity = 0.6
        
        popUpHandle.layer.cornerRadius = 5
        popUpHandle.bounds = CGRect(x: 0, y: 0, width: 70, height: 5)
        popUpHandle.center = CGPoint(x: ((self.popUp.center.x)), y: (self.popUp.center.y) + (350))
        popUpHandle.backgroundColor = UIColor.black
        popUpHandle.layer.opacity = 0.6
        
        blur.frame = (self.popUp.bounds)
        blur.center = CGPoint(x: ((self.popUp.center.x)), y: (self.popUp.center.y) + (45))
        
        dismissPopUpNode.bounds = CGRect(x: 0, y: 0, width: 170, height: 20)
        dismissPopUpNode.center = CGPoint(x: ((self.popUp.center.x)), y: (self.popUp.center.y) + (95))
        dismissPopUpNode.setTitle("Swipe Up To Dismiss", for: .normal)
        //dismissPopUpNode.addTarget(self, action: #selector(self.tempDismiss(_:)), for: UIControlEvents.touchUpInside)
        dismissPopUpNode.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        dismissPopUpNode.setTitleColor(UIColor.black, for: UIControlState.normal)
    
        popUpLabel.text = "This is just a game, but the message is far from it. Drowsy driving is actually quite dangerous. Keep yourself from making this mistake and catch some more Zs!"
        popUpLabel.textAlignment = .center
        popUpLabel.textColor = .white
        popUpLabel.numberOfLines = 0
        popUpLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 15)
        popUpLabel.bounds = CGRect(x: 0, y: 0, width: 275, height: 150)
        popUpLabel.center = CGPoint(x: ((self.popUp.center.x)), y: (self.popUp.center.y) + (15))

        zCountLabel = UILabel(frame: CGRect(x: self.frame.width/7.7, y: self.frame.height/7.1, width: 250, height: 40))
        
        highScoreLabel = UILabel(frame: CGRect(x: self.frame.width/7.7, y: self.frame.height/5.6, width: 300, height: 40))

        playAgainButtonNode = self.childNode(withName: "PlayAgainNode") as! SKSpriteNode
        playAgain = self.childNode(withName: "PlayAgain") as! SKSpriteNode
        
        factBar = self.childNode(withName: "factBar") as! SKSpriteNode
        
        playAgainButtonNode.isHidden = true
        
        sleepFactz = ["Sleep deprivation can result in obesity and poor diet quality.", "Sleep deprivation causes heart disease.", "Sleep deprivation increases the risk of diabetes.", "Not getting enough sleep can result in rash decision making.", "Drowsy driving can be as dangerous as drunk driving.", "Getting more sleep is proven to increase performance in school.", "Putting your phone away before bed will result in a much better sleep.", "Beauty Sleep is real; Going to bed earlier can improve your physical appearance.", "An average of 83,000 car crashes occur each year due to drowsy driving.", "Less than 30% of highschool students get sufficient sleep (8-10hrs).", "Humans are the only mammals that delay their sleep on purpose.", "Exercising on a regular basis makes it easier to fall asleep.", "12% of people dream in black and white.", "Sleep deprivation can kill you faster than food deprivaton.", "If falling asleep takes less than 10 minutes, chances are you are sleep deprived."]
        
        fact = (String) (sleepFactz[Int(arc4random_uniform(15))])
        
        fact1 = UILabel(frame: CGRect(x: 50 , y: -(factBar.position.y) + 30, width: 270, height: 150))
        
        fact1.text = fact
        fact1.font = UIFont(name: "ChalkboardSE-Regular", size: 20)
        fact1.lineBreakMode = NSLineBreakMode.byWordWrapping
        fact1.numberOfLines = 0
        fact1.textColor = .black
        fact1.textAlignment = NSTextAlignment.center
        
        zCountLabel.textAlignment = NSTextAlignment.left
        zCountLabel.textColor = .white
        zCountLabel.font = UIFont(name: "PressStart2P" , size: 20)
        zCountLabel.text = "        " + String( gameScene.getFinishZCount())
        
        highScoreLabel.textAlignment = NSTextAlignment.left
        highScoreLabel.textColor = .white
        highScoreLabel.font = UIFont(name: "PressStart2P" , size: 20)
        highScoreLabel.text = "        " + String( gameScene.getHighScore())

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
        self.view?.addSubview(namelabel)
        
        let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.showView()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        playViewController.checkNameLabel(namelabel : namelabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "PlayAgainNode" {
                playAgain.scale(to: CGSize(width: 400, height: 117))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "PlayAgainNode" {
                playAgain.scale(to: CGSize(width: 480, height: 140))
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "PlayAgainNode" {
                //self.view?.removeGestureRecognizer(gestureRecognizer)
                self.removeGesture()
                playAgain.scale(to: CGSize(width: 480, height: 140))
                namelabel.isHidden = true
                playViewController.tabBarController?.tabBar.isHidden = true
                hideLabels()
                let when = DispatchTime.now() + 0.15 // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.playViewController.sceneTransition(scene: self, transitionScene: "GameScene", transitionType: SKTransition.push(with: .down, duration: 1.0))
                }
            }
        }
    }
}
