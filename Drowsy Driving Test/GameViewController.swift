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
    
    var audioPlayer = AVAudioPlayer()
    
    var timeOfDay = Date()
    var calendar = Calendar.current
    
    func labelTransition(node: String, label: SKLabelNode, color: UIColor, scene: SKScene, transitionScene: String){
        label.fontColor = UIColor.lightGray
        let when = DispatchTime.now() + 0.1 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            //scene.label.fontColor = color
        }
        let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 0.5)
        let gameScene = MenuScene(fileNamed: transitionScene)
        gameScene?.scaleMode = .aspectFill
        let when2 = DispatchTime.now() + 0.15 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when2) {
            scene.view?.presentScene(gameScene!, transition: transition)
        }

    }
    
    func buttonTransition(node: String, button: SKSpriteNode, button2: String, scene: SKScene, transitionScene: String){
        button.texture = SKTexture(imageNamed: "SettingsButton2")
        let when = DispatchTime.now() + 0.1 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            //scene.button.texture = SKTexture(imageNamed: button2)
        }
        let transition = SKTransition.reveal(with: SKTransitionDirection.left, duration: 0.5)
        let gameScene = MenuScene(fileNamed: transitionScene)
        let when2 = DispatchTime.now() + 0.15 // change 2 to desired number of seconds
        gameScene?.scaleMode = .aspectFill
        DispatchQueue.main.asyncAfter(deadline: when2) {
            scene.view?.presentScene(gameScene!, transition: transition)
        }

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
        if(audioPlayer.isPlaying){
            return true
        }
        return false
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
    
    func getDefault() -> Int {
        return launchDefault.integer(forKey: "Launch")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = self.view as! SKView?
        
        var hours = calendar.component(.hour, from: timeOfDay)
        var minutes = calendar.component(.minute, from: timeOfDay)
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
