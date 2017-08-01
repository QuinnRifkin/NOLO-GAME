//
//  WelcomeViewController.swift
//  Drowsy Driving Test
//
//  Created by Quinn Rifkin on 7/31/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = SKView()
        if let scene = SKScene(fileNamed: "WelcomeScene") {
                scene.scaleMode = .aspectFill
                let view = self.view as! SKView?
                    view?.presentScene(scene)
                    view?.ignoresSiblingOrder = true
                    view?.showsFPS = true
                    view?.showsNodeCount = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
