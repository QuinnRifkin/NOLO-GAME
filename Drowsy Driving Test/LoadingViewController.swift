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
        
    func touched(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "PlayViewController") as UIViewController
        self.present(view, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = SKView()
        gameViewController.viewControllerScene(scene: "LoadingScene", viewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
