//
//  TabBarViewController.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 7/17/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import UIKit
import SpriteKit

class TabBarViewController: UITabBarController {

       override func viewDidLoad() {
        super.viewDidLoad()
    
        let home = GameViewController()
        let learnMore = LearnMoreViewController()
        let play = PlayViewController()
        let settings = SettingsViewController()
        let sleep = SleepViewController()
        
        //UIImage.init(data: "HomeIconWhenPressedcopy", scale: 0.5)
        
//        home.tabBarItem.title = "Home"
//        home.tabBarItem.image = UIImage(named: "HomeIconWhenPressed copy")
//        home.tabBarItem.index(ofAccessibilityElement: 0)
        learnMore.tabBarItem.title = "Learn More"
        learnMore.tabBarItem.image = UIImage(named: "InfoTabItem-2")
        learnMore.tabBarItem.index(ofAccessibilityElement: 1)
        play.tabBarItem.title = "Play"
        play.tabBarItem.image = UIImage(named: "PlayTabItemSmall")
        play.tabBarItem.index(ofAccessibilityElement: 2)
        settings.tabBarItem.title = "Settings"
        settings.tabBarItem.image = UIImage(named: "GearSmall")
        sleep.tabBarItem.title = "Sleep"
        sleep.tabBarItem.image = UIImage(named: "SleepTabIcon-1")
                //three.tabBarItem.image = UIImage(named: "SettingsButton2")
        //four.tabBarItem.title = "four"
       
        
        
        self.tabBarController?.selectedViewController = home
        self.tabBarController?.selectedIndex = 1
        self.viewControllers = [play, sleep, home, settings, learnMore ]
        
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
