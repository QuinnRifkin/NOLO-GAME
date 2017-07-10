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
    
    func playMusic(file: String){
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: file, ofType: "mp3")!))
            audioPlayer.prepareToPlay()
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
    
    func getDefault() -> Int {
        return launchDefault.integer(forKey: "Launch")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = self.view as! SKView?
        
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
