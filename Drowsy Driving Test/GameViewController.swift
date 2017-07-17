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

class Player:NSObject {
    static var sharedPlayer = Player()
    var aPlayer:AVAudioPlayer?

    func playMusic(file: String) {
        do {
            Player.sharedPlayer.aPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: file, ofType: "mp3")!))
            Player.sharedPlayer.aPlayer?.prepareToPlay()
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch {
            print(error)
        }
        Player.sharedPlayer.aPlayer?.play()
    }

    func setLoops(loops: Int){
        Player.sharedPlayer.aPlayer?.numberOfLoops = loops
    }

    func stopMusic() {
        if Player.sharedPlayer.aPlayer?.isPlaying ?? false {
            Player.sharedPlayer.aPlayer?.stop()
        }
    }
}

class GameViewController: UIViewController {
    
    var launchDefault = UserDefaults.standard
    
    var timeOfDay = Date()
    var calendar = Calendar.current
    
//    func labelTransition(node: String, label: SKLabelNode, color: UIColor, scene: SKScene, transitionScene: String){
//        if scene is MenuScene {
//            label.fontColor = UIColor.lightGray
//            let when = DispatchTime.now() + 0.1 // change 2 to desired number of seconds
//            DispatchQueue.main.asyncAfter(deadline: when) {
//                    MenuScene.label.fontColor = color
//            }
//            let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 0.5)
//            let gameScene = MenuScene(fileNamed: transitionScene)
//            gameScene?.scaleMode = .aspectFill
//            let when2 = DispatchTime.now() + 0.15 // change 2 to desired number of seconds
//            DispatchQueue.main.asyncAfter(deadline: when2) {
//                scene.view?.presentScene(gameScene!, transition: transition)
//            }
//        }
//    }
//    
//    func buttonTransition(node: String, button: SKSpriteNode, button2: String, scene: SKScene, transitionScene: String){
//        button.texture = SKTexture(imageNamed: "SettingsButton2")
//        let when = DispatchTime.now() + 0.1 // change 2 to desired number of seconds
//        DispatchQueue.main.asyncAfter(deadline: when) {
//            MenuScene.button.texture = SKTexture(imageNamed: button2)
//        }
//        let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 0.5)
//        let gameScene = MenuScene(fileNamed: transitionScene)
//        let when2 = DispatchTime.now() + 0.15 // change 2 to desired number of seconds
//        gameScene?.scaleMode = .aspectFill
//        DispatchQueue.main.asyncAfter(deadline: when2) {
//            scene.view?.presentScene(gameScene!, transition: transition)
//        }
//
//    }
    
    func volume() {
        Player.sharedPlayer.aPlayer?.setVolume(0, fadeDuration: 0)
    }
    
    func getDefault() -> Int {
        return launchDefault.integer(forKey: "Launch")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = self.view as! SKView?
        
        let hours = calendar.component(.hour, from: timeOfDay)
        let minutes = calendar.component(.minute, from: timeOfDay)
        if(hours > 12){
        print(String(hours) + ":" + String(minutes) + " PM")
        } else{
            print(String(hours) + ":" + String(minutes) + " AM")
        }
        
        if(launchDefault.value(forKey: "Launch") == nil || launchDefault.integer(forKey: "Launch" ) == 0 ){
            launchDefault.set(0, forKey: "Launch")
            if let scene = SKScene(fileNamed: "WelcomeScene"){
                scene.scaleMode = .aspectFill
                view!.presentScene(scene)
                view!.ignoresSiblingOrder = false
                view!.showsFPS = true
                view!.showsNodeCount = true
            }
        }
        else{
            if let scene = SKScene(fileNamed: "WelcomeScene"){
                scene.scaleMode = .aspectFill
                view!.presentScene(scene)
                view!.ignoresSiblingOrder = false
                view!.showsFPS = true
                view!.showsNodeCount = true
            }
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
