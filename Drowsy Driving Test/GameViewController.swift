//
//  GameViewController.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 6/16/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    
    var launchDefault = UserDefaults.standard
    
    var timeOfDay = Date()
    var calendar = Calendar.current
    
    var database = [
        ["January","February","March","April","May","June","July","August","September","October","November","December"],
        ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"],
        ["2017","2016","2015","2014","2013","2012","2011","2010","2009","2008","2007","2006","2005","2004","2003","2002","2001","2000","1999","1998","1997","1996","1995","1994","1993","1992","1991","1990","1989","1988","1987","1986","1985","1984","1983","1982","1981","1980","1979","1978","1977","1976","1975","1974","1973","1972","1971","1970","1969","1968","1967","1966","1965","1964","1963","1962","1961","1960","1959","1958","1957","1956","1955","1954","1953","1952","1951","1950","1949","1948","1947","1946","1945","1944","1943","1942","1941","1940","1939","1938","1937","1936","1935","1934","1933","1932","1931","1930","1929","1928","1927","1926","1925","1924","1923","1922","1921","1920","1919","1918","1917","1916","1915","1914","1913","1912","1911","1910","1909","1908","1907","1906","1905","1904","1903","1902","1901","1900"]
    ]
    
    func labelTransition(label: SKLabelNode, color: UIColor, scene: SKScene, transitionScene: String, transitionType: SKTransition){
        label.fontColor = UIColor.lightGray
        let when = DispatchTime.now() + 0.1 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            label.fontColor = color
        }
        let transition = transitionType
        let gameScene = MenuScene(fileNamed: transitionScene)
        gameScene?.scaleMode = .aspectFill
        let when2 = DispatchTime.now() + 0.15 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when2) {
            scene.view?.presentScene(gameScene!, transition: transition)
        }
    }
    
    func buttonTransition(button: SKSpriteNode, button2: String, scene: SKScene, transitionScene: String){
        button.texture = SKTexture(imageNamed: "SettingsButton2")
        let when = DispatchTime.now() + 0.1 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            button.texture = SKTexture(imageNamed: button2)
        }
        let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 0.5)
        let gameScene = MenuScene(fileNamed: transitionScene)
        let when2 = DispatchTime.now() + 0.15 // change 2 to desired number of seconds
        gameScene?.scaleMode = .aspectFill
        DispatchQueue.main.asyncAfter(deadline: when2) {
            scene.view?.presentScene(gameScene!, transition: transition)
        }

    }
    
       func getDefault() -> Int {
        return launchDefault.integer(forKey: "Launch")
    }
    
    func socialMediaLink(appLink: String, webLink: String){
        let appURL = NSURL(string: appLink)!
        let webURL = NSURL(string: webLink)!

        let application = UIApplication.shared
        if application.openURL(appURL as URL) {
        }
        else {
        application.openURL(webURL as URL)
        }
    }
    
    func viewControllerScene(scene: String, viewController: UIViewController){
        let view = viewController.view as! SKView?
        
        if let scene = SKScene(fileNamed: scene){
            scene.scaleMode = .aspectFill
            view!.presentScene(scene)
            view!.ignoresSiblingOrder = false
            view!.showsFPS = true
            view!.showsNodeCount = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.gameViewController = self

        self.view = SKView()
//        let view = self.view as! SKView?
        
        let hours = calendar.component(.hour, from: timeOfDay)
        let minutes = calendar.component(.minute, from: timeOfDay)
        if(hours > 12){
        print(String(hours) + ":" + String(minutes) + " PM")
        } else{
            print(String(hours) + ":" + String(minutes) + " AM")
        }
        
        if(launchDefault.value(forKey: "Launch") == nil || launchDefault.integer(forKey: "Launch" ) == 0 ){
            launchDefault.set(0, forKey: "Launch")
            viewControllerScene(scene: "WelcomeScene", viewController: self)
        }
        else{
            viewControllerScene(scene: "LoadingScene", viewController: self)
        }
        launchDefault.set(launchDefault.integer(forKey: "Launch") + 1, forKey: "Launch")
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
