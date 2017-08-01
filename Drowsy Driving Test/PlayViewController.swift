//
//  PlayViewController.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 7/17/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class PlayViewController: UIViewController {
    
    var launchDefault = UserDefaults.standard
    
    var audioPlayer = AVAudioPlayer()
    var gameViewController = GameViewController()
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func hideTabBar(){
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func sceneTransition(scene: SKScene, transitionScene: String, transitionType: SKTransition){
        let transition = transitionType
        let gameScene = DeathScene(fileNamed: transitionScene)
        gameScene?.scaleMode = .aspectFill
        
        scene.view?.presentScene(gameScene!, transition: transition)
    }
    
    func playMusic(file: String){
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: file, ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()
            
            do{
                try audioSession.setCategory(AVAudioSessionCategorySoloAmbient)
            }
            catch{
                print (error)
            }
        }
        catch {
            print(error)
        }
        audioPlayer.play()
    }
    
    func isPlayingMusic() -> Bool {
        return audioPlayer.isPlaying
    }
    
    func stopMusic(){
        audioPlayer.stop()
    }
    
    func setLoops(loops: Int){
        audioPlayer.numberOfLoops = loops
    }
    
    func getDefault() -> Int {
        return launchDefault.integer(forKey: "Launch")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = SKView()
        let delegate2 = UIApplication.shared.delegate as! AppDelegate
        delegate2.playViewController = self
        gameViewController.viewControllerScene(scene: "MenuScene", viewController: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

