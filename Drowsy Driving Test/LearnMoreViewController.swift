//
//  LearnMoreViewController.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 7/17/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class LearnMoreViewController: UIViewController {
    
    let gameViewController = GameViewController()
    
    override func viewDidLoad() {

        self.tabBarController?.tabBar.isHidden = false
        
        super.viewDidLoad()
        self.view = SKView()
        gameViewController.viewControllerScene(scene: "LearnMoreScene", viewController: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
