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
    
    var audioPlayer = AVAudioPlayer()
    var gameViewController = GameViewController()
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //audioPlayer.stop()
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
            
            var audioSession = AVAudioSession.sharedInstance()
            
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
    
    func volume(){
        audioPlayer.setVolume(0, fadeDuration: 0)
    }
    
    public func audioPlayerBeginInterruption(_ player: AVAudioPlayer)
    {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = false
        
        let delegate2 = UIApplication.shared.delegate as! AppDelegate
        delegate2.playViewController = self

        self.view = SKView()
        gameViewController.viewControllerScene(scene: "WelcomeScene", viewController: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

