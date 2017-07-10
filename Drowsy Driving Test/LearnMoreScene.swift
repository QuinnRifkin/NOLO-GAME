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
    
    var infoLabel : UILabel!
    var homeButtonNode:SKSpriteNode!
    var googleButtonNode: SKSpriteNode!
    var twitterButtonNode: SKSpriteNode!
    var snapchatButtonNode: SKSpriteNode!
    var instagramButtonNode: SKSpriteNode!
    var facebookButtonNode: SKSpriteNode!
    
    var backButtonNode: SKSpriteNode!

    let welcomeScene = WelcomeScene()
    
    let nameLabel = UILabel(frame: CGRect(x: 6, y: -20, width: 300, height: 100))
    
    override func didMove(to view: SKView) {
        
        infoLabel = UILabel(frame: CGRect(x: 10, y: 40, width: self.frame.width/2, height: 270))
        infoLabel.text = "NOLO is a non-for-profit organization striding to spread awareness and knowledge of the causes and impact of insufficient sleep. NOLO’s ultimate goal is to make sleep a priority amongst teenagers."
        infoLabel.numberOfLines = 0
        infoLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        infoLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        infoLabel.textColor = .white
        infoLabel.textAlignment = NSTextAlignment.left
        
        homeButtonNode = self.childNode(withName: "HomeNodeImage") as! SKSpriteNode
        homeButtonNode.texture = SKTexture(imageNamed: "HomeIcon")
        homeButtonNode.color = .clear
        
        googleButtonNode = self.childNode(withName: "GoogleNode") as! SKSpriteNode
        googleButtonNode.texture = SKTexture(imageNamed: "GoogleIcon")
        googleButtonNode.color = .clear
        
        twitterButtonNode = self.childNode(withName: "TwitterNode") as! SKSpriteNode
        twitterButtonNode.texture = SKTexture(imageNamed: "TwitterIcon")
        twitterButtonNode.color = .clear
        
        snapchatButtonNode = self.childNode(withName: "SnapchatNode") as! SKSpriteNode
        snapchatButtonNode.texture = SKTexture(imageNamed: "SnapchatIcon")
        snapchatButtonNode.color = .clear
        
        instagramButtonNode = self.childNode(withName: "InstagramNode") as! SKSpriteNode
        instagramButtonNode.texture = SKTexture(imageNamed: "InstagramIcon")
        instagramButtonNode.color = .clear
        
        facebookButtonNode = self.childNode(withName: "FacebookNode") as! SKSpriteNode
        facebookButtonNode.texture = SKTexture(imageNamed: "FacebookIcon")
        facebookButtonNode.color = .clear
        
        backButtonNode = self.childNode(withName: "BackNode") as! SKSpriteNode
        
        
        let name = String(welcomeScene.getName())
        nameLabel.attributedText = NSAttributedString(string: name!, attributes: [NSForegroundColorAttributeName : UIColor.white])
        nameLabel.textAlignment = NSTextAlignment.left
        nameLabel.font = UIFont(name: "HelveticaNeue", size: 15)
        self.view?.addSubview(nameLabel)
        
        let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.view?.addSubview(self.infoLabel)
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "HomeNode" {
                infoLabel.isHidden = true
                nameLabel.isHidden = true
                let transition = SKTransition.reveal(with: SKTransitionDirection.right, duration: 0.5)
                let gameScene = MenuScene(fileNamed: "MenuScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
            if nodesArray.first?.name == "BackNode" {
                infoLabel.isHidden = true
                nameLabel.isHidden = true
                let transition = SKTransition.reveal(with: SKTransitionDirection.right, duration: 0.5)
                let gameScene = MenuScene(fileNamed: "MenuScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }

            if nodesArray.first?.name == "GoogleNode"{
                nameLabel.isHidden = true
                if let google = NSURL(string: "http://www.google.com"){
                    UIApplication.shared.open(google as URL, options: [:], completionHandler: nil)
                }
            }
            if nodesArray.first?.name == "TwitterNode"{
                nameLabel.isHidden = true
                    let screenName =  "@NOLO716"
                    let appURL = NSURL(string: "twitter://user?screen_name=\(screenName)")!
                    let webURL = NSURL(string: "https://twitter.com/\(screenName)")!
                
                    let application = UIApplication.shared
                    if application.openURL(appURL as URL) {
                    }
                    else {
                        application.openURL(webURL as URL)
                    }
            }
            if nodesArray.first?.name == "SnapchatNode"{
                nameLabel.isHidden = true
                let appURL = NSURL(string: "snapchat://add/nolo716")!
                let webURL = NSURL(string: "itms-apps://itunes.apple.com/app/snapchat/id447188370?mt=8")!
                
                let application = UIApplication.shared
                if application.openURL(appURL as URL) {
                }
                else {
                    application.openURL(webURL as URL)
                }
            }
            if nodesArray.first?.name == "InstagramNode"{
                nameLabel.isHidden = true
                let screenName =  "NOLO716"
                let appURL = NSURL(string: "Instagram://user?username=\(screenName)")!
                let webURL = NSURL(string: "itms-apps://itunes.apple.com/app/instagram/id389801252?mt=8")!
                
                let application = UIApplication.shared
                if application.openURL(appURL as URL) {
                }
                else {
                    application.openURL(webURL as URL)
                }
            }
            if nodesArray.first?.name == "FacebookNode"{
                nameLabel.isHidden = true
                let screenName =  "347809602305230"
                let appURL = NSURL(string: "fb://profile/\(screenName)")!
                let webURL = NSURL(string: "https://www.facebook.com/Nights-Out-Lightz-out-347809602305230/")!
                
                let application = UIApplication.shared
                if application.openURL(appURL as URL) {
                }
                else {
                    application.openURL(webURL as URL)
                }
            }

        }
    }
}
