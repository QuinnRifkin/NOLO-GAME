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
    
    
    
    
  //  @IBAction func signin(_ sender: AnyObject) {
   //     let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    //    appDelegate.window?.rootViewController = appDelegate.tabBarController
  //  }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = SKView()
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = SKScene(fileNamed: "WelcomeScene") {
            
            // Get the SKScene from the loaded GKScene
            
                                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                 let view = self.view as! SKView?
                    view?.presentScene(scene)
                    
                    view?.ignoresSiblingOrder = true
                    
                    view?.showsFPS = true
                    view?.showsNodeCount = true
                }
            }
    
    

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
