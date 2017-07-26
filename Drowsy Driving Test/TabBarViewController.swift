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
    
        let learnMore = LearnMoreViewController()
        let play = PlayViewController()
        let settings = SettingsViewController()
        let sleep = SleepViewController()
        
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
        
        self.tabBarController?.selectedIndex = 1
        self.viewControllers = [play, sleep, settings, learnMore]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
