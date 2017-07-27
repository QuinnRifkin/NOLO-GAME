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
    var goHomeLabelNode: SKLabelNode!
    
    let welcomeScene = WelcomeScene()
    let gameViewController = GameViewController()
    let learnMoreViewController = LearnMoreViewController()
    
    let nameLabel = UILabel(frame: CGRect(x: 6, y: -15, width: 150, height: 100))
    
    var timer = Timer()
    
    func checkLabel(){
        if(nameLabel.text != String(welcomeScene.getName())){
            nameLabel.attributedText = NSAttributedString(string: String(welcomeScene.getName()), attributes: [NSForegroundColorAttributeName : UIColor.white])
        }
    }
    
    override func didMove(to view: SKView) {
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.checkLabel), userInfo: nil, repeats: true)
    
        infoLabel = UILabel(frame: CGRect(x: 10, y: 40, width: self.frame.width/2.1, height: 270))
        infoLabel.text = "NOLO is a campaign developed by teens, for teens, that strides to spread awareness and knowledge of the causes and impacts of insufficient sleep. NOLO’s ultimate goal is to make sleep a priority amongst teenagers."
        infoLabel.numberOfLines = 0
        infoLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 20)
        infoLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        infoLabel.textColor = .black
        infoLabel.textAlignment = NSTextAlignment.left
        
        goHomeLabelNode = self.childNode(withName: "GoHomeLabel") as! SKLabelNode
        
        googleButtonNode = self.childNode(withName: "WebsiteNode") as! SKSpriteNode
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
        
        let name = String(welcomeScene.getName())
        if(name!.characters.count >= 25)
        {
            nameLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 10)
        } else if(name!.characters.count >= 20){
            nameLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 12)
        } else if(name!.characters.count >= 15){
            nameLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 14)
        } else if(name!.characters.count >= 10){
            nameLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 16)
        } else {
            nameLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 18)
        }
        
        nameLabel.attributedText = NSAttributedString(string: name!, attributes: [NSForegroundColorAttributeName : UIColor.white])
        nameLabel.textAlignment = NSTextAlignment.left

        self.view?.addSubview(nameLabel)
        self.view?.addSubview(infoLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "WebsiteNode"{
                nameLabel.isHidden = true
                if let website = NSURL(string: "http://nolo716.org"){
                    UIApplication.shared.open(website as URL, options: [:], completionHandler: nil)
                }
            }
            if nodesArray.first?.name == "TwitterNode"{
                nameLabel.isHidden = true
                gameViewController.socialMediaLink(appLink: "twitter://user?screen_name=@NOLO716", webLink: "https://twitter.com/@NOLO716")
            }
            if nodesArray.first?.name == "SnapchatNode"{
                nameLabel.isHidden = true
                gameViewController.socialMediaLink(appLink: "snapchat://add/nolo716", webLink: "itms-apps://itunes.apple.com/app/snapchat/id447188370?mt=8")
            }
            if nodesArray.first?.name == "InstagramNode"{
                nameLabel.isHidden = true
                gameViewController.socialMediaLink(appLink: "Instagram://user?username=NOLO716", webLink: "itms-apps://itunes.apple.com/app/instagram/id389801252?mt=8")
            }
            if nodesArray.first?.name == "FacebookNode"{
                nameLabel.isHidden = true
                gameViewController.socialMediaLink(appLink: "fb://profile/347809602305230", webLink: "https://www.facebook.com/Nightz-Out-Lightz-out-347809602305230/")

            }

        }
    }
}
