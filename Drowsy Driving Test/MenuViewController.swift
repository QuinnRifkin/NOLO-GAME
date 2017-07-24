//
//  TestViewController.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 7/17/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class MenuViewController: UIViewController {
    
    let gameViewController = GameViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = SKView()
        gameViewController.viewControllerScene(scene: "MenuScene", viewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
