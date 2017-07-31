//
//  LoadingViewController.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 7/24/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import UIKit
import SpriteKit

class LoadingViewController: UIViewController {
    let gameViewController = GameViewController()
    let tabBarViewController = TabBarViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = SKView()
        gameViewController.viewControllerScene(scene: "WelcomeScene", viewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
