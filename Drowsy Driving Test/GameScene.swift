//
//  GameScene.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 6/16/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    var gameViewController = GameViewController()
    
    var HighScoreDefault = UserDefaults.standard
    var HighScore: Int = 0
    
    struct collisionType{
        static let carx : UInt32 = 1
        static let zspritex : UInt32 = 2
    }
    
    var widthframe : UInt32 = 0
    var halfwidthframe : UInt32 = 0
    var heightframe : UInt32 = 0
    var halfheightframe : UInt32 = 0
    
    var randomNumberx1 : Int = 0
    var rangex1 : Int = 0
    var randomNumbery1 : Int = 0
    var rangey1 : Int = 0
    var randomNumberx2 : Int = 0
    var rangex2 : Int = 0
    var randomNumbery2 : Int = 0
    var rangey2 : Int = 0
    var randomNumberx3 : Int = 0
    var rangex3 : Int = 0
    var randomNumbery3 : Int = 0
    var rangey3 : Int = 0
    var randomNumberx4 : Int = 0
    var rangex4 : Int = 0
    var randomNumbery4 : Int = 0
    var rangey4 : Int = 0
    
    let Upper : UInt32 = (128)
    var acc = CGFloat(0.0)
    
    var zcount = 0
    var ztruecount = 0
    var zbackcount = 0
    
    var TimeDefault = UserDefaults.standard
    var time : Int = 0
    var timer = Timer()
    
    var resetButtonNode: SKSpriteNode!
    var TimeLabelNode: SKSpriteNode!
    var HomeLabelNode: SKSpriteNode!
    var HighScoreLabelNode: SKSpriteNode!
    var ZLabelNode: SKSpriteNode!
    
    var timelabel : UILabel!
    var highscorelabel : UILabel!
    var zcountlabel : UILabel!
    
    let road1 = SKSpriteNode(imageNamed: "RoadSpriteWGrass")
    let road2 = SKSpriteNode(imageNamed: "RoadSpriteWGrass")
    
    let obstacle1 = SKSpriteNode(imageNamed: "WallSprite")
    let obstacle2 = SKSpriteNode(imageNamed: "WallSprite")
    let obstacle3 = SKSpriteNode(imageNamed: "WallSprite")
    let obstacle4 = SKSpriteNode(imageNamed: "WallSprite")
    
    let car = SKSpriteNode(imageNamed: "CarSprite")
    
    let zsprite1right = SKSpriteNode(imageNamed: "ZSprite")
    let zsprite1middle = SKSpriteNode(imageNamed: "ZSprite")
    let zsprite1left = SKSpriteNode(imageNamed: "ZSprite")
    
    let zsprite2right = SKSpriteNode(imageNamed: "ZSprite")
    let zsprite2middle = SKSpriteNode(imageNamed: "ZSprite")
    let zsprite2left = SKSpriteNode(imageNamed: "ZSprite")
    
    let zsprite3right = SKSpriteNode(imageNamed: "ZSprite")
    let zsprite3middle = SKSpriteNode(imageNamed: "ZSprite")
    let zsprite3left = SKSpriteNode(imageNamed: "ZSprite")
    
    let zsprite4right = SKSpriteNode(imageNamed: "ZSprite")
    let zsprite4middle = SKSpriteNode(imageNamed: "ZSprite")
    let zsprite4left = SKSpriteNode(imageNamed: "ZSprite")
    
    let zspriterandom1 = SKSpriteNode(imageNamed: "ZSprite")
    let zspriterandom2 = SKSpriteNode(imageNamed: "ZSprite")
    let zspriterandom3 = SKSpriteNode(imageNamed: "ZSprite")
    let zspriterandom4 = SKSpriteNode(imageNamed: "ZSprite")
    
    let leftwall = SKSpriteNode(imageNamed: "FieldLines")
    let rightwall = SKSpriteNode(imageNamed: "FieldLines")
    
    let left = SKAction.moveBy(x: -175, y: 0, duration: 0.2)
    let right = SKAction.moveBy(x: 175, y: 0, duration: 0.2)
    
    func swipeLeft(_ gestureRecognizer: UITapGestureRecognizer){
        car.run(left)
    }
    
    func swipeRight(_ gestureRecognizer: UITapGestureRecognizer){
        car.run(right)
    }
    
    func addLeftWall(){
        leftwall.position = CGPoint(x: 0 - (self.frame.width/2) - (leftwall.size.width/2) - 50, y: 0)
        leftwall.size = CGSize(width: 100, height: self.frame.height + car.size.height*2)
        leftwall.zPosition = -1
        leftwall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: leftwall.size.width, height: leftwall.size.height))
        leftwall.physicsBody?.isDynamic = false
        leftwall.physicsBody?.allowsRotation = false
        leftwall.physicsBody?.mass = 10000000000000000000.0
        addChild(leftwall)
    }
    
    func addRightWall(){
        rightwall.position = CGPoint(x: 0 + (self.frame.width/2) + (rightwall.size.width/2) + 50, y: 0)
        rightwall.size = CGSize(width: 100, height: self.frame.height + car.size.height*2)
        rightwall.zPosition = -1
        rightwall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rightwall.size.width, height: rightwall.size.height))
        rightwall.physicsBody?.isDynamic = false
        rightwall.physicsBody?.allowsRotation = false
        rightwall.physicsBody?.mass = 10000000000000000000.0
        addChild(rightwall)
    }
    
    func addRoad(road: SKSpriteNode, y: CGFloat){
        road.position = CGPoint(x: 0, y: y)
        road.zPosition = -1
        addChild(road)
    }
    
    func addObstacle(obstacle: SKSpriteNode, location: CGPoint, name: String){
        obstacle.name = name
        obstacle.position = location
        obstacle.size = CGSize(width: 414.98, height: 77.496)
        obstacle.zPosition = 2
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: obstacle.size.width, height: obstacle.size.height))
        obstacle.physicsBody?.isDynamic = false
        obstacle.physicsBody?.allowsRotation = false
        obstacle.physicsBody?.mass = 1000000000000000.0
        addChild(obstacle)
    }
    
    func addCar(car: SKSpriteNode){
        car.name = "Car"
        car.position = CGPoint(x: 5,y: -563.043)
        car.size = CGSize(width: 95.919, height: 178.812)
        car.zPosition = 3
        car.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: car.size.width, height: car.size.height))
        car.physicsBody?.isDynamic = true
        car.physicsBody?.allowsRotation = false
        car.physicsBody?.mass = 10
        car.physicsBody?.categoryBitMask = collisionType.carx
        car.physicsBody?.collisionBitMask = collisionType.zspritex
        car.physicsBody?.contactTestBitMask = collisionType.zspritex
        addChild(car)
    }
    
    func addZSprite(zsprite: SKSpriteNode, obstacleSize: SKSpriteNode, obstaclePlacement: CGPoint, name: String){
        let obstacleX = obstaclePlacement.x
        let obstacleY = obstaclePlacement.y
        
        zsprite.name = name
        zsprite.position = CGPoint(x: obstacleX, y: obstacleY - (obstacleSize.size.height/2) - 50)
        zsprite.zPosition = 1
        zsprite.size = CGSize(width: 70, height: 70)
        zsprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: zsprite.size.width, height: zsprite.size.height))
        zsprite.physicsBody?.isDynamic = false
        zsprite.physicsBody?.allowsRotation = false
        zsprite.physicsBody?.mass = 0.1
        zsprite.physicsBody?.categoryBitMask = collisionType.zspritex
        addChild(zsprite)
    }
    
    func addRandomZSprite(zsprite: SKSpriteNode, position: CGPoint, name: String){
        zsprite.name = name
        zsprite.position = position
        zsprite.zPosition = 1
        zsprite.size = CGSize(width: 70, height: 70)
        zsprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: zsprite.size.width, height: zsprite.size.height))
        zsprite.physicsBody?.isDynamic = true
        zsprite.physicsBody?.allowsRotation = false
        zsprite.physicsBody?.mass = 0.1
        zsprite.physicsBody?.categoryBitMask = collisionType.zspritex
        addChild(zsprite)
    }
    
    func moveZSprite(zspriteright: SKSpriteNode, zspritemiddle: SKSpriteNode, zspriteleft: SKSpriteNode, obstacle: SKSpriteNode){
        if(zspriteright.isHidden){
            zspriteright.position = CGPoint(x: 1000, y: 1000)
        }
        else {
            zspriteright.position = CGPoint(x: obstacle.position.x + obstacle.size.width/3, y: obstacle.position.y - (obstacle.size.height/2) - 60)
        }
        if(zspritemiddle.isHidden){
            zspritemiddle.position = CGPoint(x: 1000, y: 1000)
        }
        else {
            zspritemiddle.position = CGPoint(x: obstacle.position.x , y: obstacle.position.y - (obstacle.size.height/2) - 60)
        }
        if(zspriteleft.isHidden){
            zspriteleft.position = CGPoint(x: 1000, y: 1000)
        }
        else {
            zspriteleft.position = CGPoint(x: obstacle.position.x - obstacle.size.width/3, y: obstacle.position.y - (obstacle.size.height/2) - 60)
        }
    }
    
    func moveRandomZSprite(zsprite: SKSpriteNode, position: CGPoint){
        if(zsprite.isHidden){
            zsprite.isHidden = false;
            zsprite.position = CGPoint(x: rangex1, y: rangey1)
        }
        else{
            zsprite.position = CGPoint(x: zsprite.position.x, y: zsprite.position.y-4-acc+CGFloat(zcount/10))
        }
    }
    
    func updateTime(){
        time += 1;
        acc += 0.15
        zbackcount += 1;
        if(zbackcount >= 5 && zcount > 0){
            zcount -= 1;
            zbackcount -= 5
        }
        if(time > HighScore){
            HighScore = time;
        }
    }
    
    func movingBackground(){
        
        road1.position = CGPoint(x: road1.position.x, y: road1.position.y-4-acc+CGFloat(zcount/10))
        road2.position = CGPoint(x: road2.position.x, y: road2.position.y-4-acc+CGFloat(zcount/10))
        
        obstacle1.position = CGPoint(x: obstacle1.position.x, y: obstacle1.position.y-4-acc+CGFloat(zcount/10))
        obstacle2.position = CGPoint(x: obstacle2.position.x, y: obstacle2.position.y-4-acc+CGFloat(zcount/10))
        obstacle3.position = CGPoint(x: obstacle3.position.x, y: obstacle3.position.y-4-acc+CGFloat(zcount/10))
        obstacle4.position = CGPoint(x: obstacle4.position.x, y: obstacle4.position.y-4-acc+CGFloat(zcount/10))
        
        moveZSprite(zspriteright: zsprite1right, zspritemiddle: zsprite1middle, zspriteleft: zsprite1left, obstacle: obstacle1)
        moveZSprite(zspriteright: zsprite2right, zspritemiddle: zsprite2middle, zspriteleft: zsprite2left, obstacle: obstacle2)
        moveZSprite(zspriteright: zsprite3right, zspritemiddle: zsprite3middle, zspriteleft: zsprite3left, obstacle: obstacle3)
        moveZSprite(zspriteright: zsprite4right, zspritemiddle: zsprite4middle, zspriteleft: zsprite4left, obstacle: obstacle4)
        
        moveRandomZSprite(zsprite: zspriterandom1, position: zspriterandom1.position)
        moveRandomZSprite(zsprite: zspriterandom2, position: zspriterandom2.position)
        moveRandomZSprite(zsprite: zspriterandom3, position: zspriterandom3.position)
        moveRandomZSprite(zsprite: zspriterandom4, position: zspriterandom4.position)
    }
    
    func getHighScore() -> Int {
        return (HighScoreDefault.integer(forKey: "HighScore"))
    }
    
    func getFinishTime() -> Int {
        return TimeDefault.integer(forKey: "FinalTime")
    }
    
    func setHighScore(time: Int){
        if(HighScore > (HighScoreDefault.integer(forKey: "HighScore"))){
            HighScoreDefault.set(HighScore, forKey: "HighScore")
        }
        HighScoreDefault.synchronize()
    }
    
    func setFinishTime(time: Int){
        TimeDefault.set(time, forKey: "FinalTime")
        TimeDefault.synchronize()
    }
    
    override func didMove(to view: SKView) {
        
        timelabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width/2 , height: 20))
        highscorelabel = UILabel(frame: CGRect(x: 0, y: 20, width: self.frame.width/2 , height: 20))
        zcountlabel = UILabel(frame: CGRect(x: 0, y: 40, width: self.frame.width/2 , height: 20))
        
        widthframe = UInt32(self.frame.width)
        halfwidthframe = widthframe/2
        heightframe = UInt32(self.frame.height)
        halfheightframe = heightframe/2
        
        randomNumberx1 = (Int(arc4random_uniform(widthframe)))
        rangex1 = Int(randomNumberx1 - Int(halfwidthframe))
        randomNumbery1 = (Int(arc4random_uniform(heightframe)))
        rangey1 = Int(randomNumbery1 - Int(halfheightframe))
        randomNumberx2 = (Int(arc4random_uniform(widthframe)))
        rangex2 = Int(randomNumberx2 - Int(halfwidthframe))
        randomNumbery2 = (Int(arc4random_uniform(heightframe)))
        rangey2 = Int(randomNumbery2 - Int(halfheightframe))
        randomNumberx3 = (Int(arc4random_uniform(widthframe)))
        rangex3 = Int(randomNumberx3 - Int(halfwidthframe))
        randomNumbery3 = (Int(arc4random_uniform(heightframe)))
        rangey3 = Int(randomNumbery3 - Int(halfheightframe))
        randomNumberx4 = (Int(arc4random_uniform(widthframe)))
        rangex4 = Int(randomNumberx4 - Int(halfwidthframe))
        randomNumbery4 = (Int(arc4random_uniform(heightframe)))
        rangey4 = Int(randomNumbery4 - Int(halfheightframe))
        
        gameViewController.playMusic(file: "GameStartSound")
        
        if(HighScoreDefault.value(forKey: "HighScore") != nil){
            HighScore = HighScoreDefault.value(forKey: "HighScore") as! NSInteger!
            highscorelabel.text = String(HighScore)
            self.view?.addSubview(highscorelabel)
        }
        TimeDefault.set(0, forKey: "FinalTime")
        
        let swLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_:)))
        swLeft.direction = .left
        view.addGestureRecognizer(swLeft)
        
        let swRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(_:)))
        swRight.direction = .right
        view.addGestureRecognizer(swRight)
        
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        
        resetButtonNode = self.childNode(withName: "resetButton") as! SKSpriteNode
        TimeLabelNode = self.childNode(withName: "TimeNode") as! SKSpriteNode
        TimeLabelNode.texture = SKTexture(imageNamed: "TimeLabel")
        HomeLabelNode = self.childNode(withName: "HomeNode") as! SKSpriteNode
        HomeLabelNode.texture = SKTexture(imageNamed: "HomeIcon")
        HighScoreLabelNode = self.childNode(withName: "HighScoreNode") as! SKSpriteNode
        HighScoreLabelNode.texture = SKTexture(imageNamed: "HighScoreLabel")
        ZLabelNode = self.childNode(withName: "ZNode") as! SKSpriteNode
        ZLabelNode.texture = SKTexture(imageNamed: "ZLabel")
        
        addLeftWall()
        addRightWall()
        
        addRoad(road: road1, y: 0)
        addRoad(road: road2, y: road1.size.height-1)
        
        addObstacle(obstacle: obstacle1, location: CGPoint(x:127.908, y: 1350), name: "obstacle1")
        addObstacle(obstacle: obstacle2, location: CGPoint(x:-128.339, y: 900), name: "obstacle2")
        addObstacle(obstacle: obstacle3, location: CGPoint(x:127.908, y: 450), name: "obstacle3")
        addObstacle(obstacle: obstacle4, location: CGPoint(x:-128.339, y: 0), name: "obstacle4")
        
        addCar(car: car)
        
        addZSprite(zsprite: zsprite1right, obstacleSize: obstacle1, obstaclePlacement: obstacle1.position, name: "zsprite1right")
        addZSprite(zsprite: zsprite1middle, obstacleSize: obstacle1, obstaclePlacement: obstacle1.position, name: "zsprite1middle")
        addZSprite(zsprite: zsprite1left, obstacleSize: obstacle1, obstaclePlacement: obstacle1.position, name: "zsprite1left")
        
        addZSprite(zsprite: zsprite2right, obstacleSize: obstacle1, obstaclePlacement: obstacle2.position, name: "zsprite2right")
        addZSprite(zsprite: zsprite2middle, obstacleSize: obstacle1, obstaclePlacement: obstacle2.position, name: "zsprite2middle")
        addZSprite(zsprite: zsprite2left, obstacleSize: obstacle1, obstaclePlacement: obstacle2.position, name: "zsprite2left")
        
        addZSprite(zsprite: zsprite3right, obstacleSize: obstacle1, obstaclePlacement: obstacle3.position, name: "zsprite3right")
        addZSprite(zsprite: zsprite3middle, obstacleSize: obstacle1, obstaclePlacement: obstacle3.position, name: "zsprite3middle")
        addZSprite(zsprite: zsprite3left, obstacleSize: obstacle1, obstaclePlacement: obstacle3.position, name: "zsprite3left")
        
        addZSprite(zsprite: zsprite4right, obstacleSize: obstacle1, obstaclePlacement: obstacle4.position, name: "zsprite4right")
        addZSprite(zsprite: zsprite4middle, obstacleSize: obstacle1, obstaclePlacement: obstacle4.position, name: "zsprite4middle")
        addZSprite(zsprite: zsprite4left, obstacleSize: obstacle1, obstaclePlacement: obstacle4.position, name: "zsprite4left")
        
        addRandomZSprite(zsprite: zspriterandom1, position: CGPoint(x: rangex1, y: rangey1), name: "zspriterandom1")
        addRandomZSprite(zsprite: zspriterandom2, position: CGPoint(x: rangex2, y: rangey2), name: "zspriterandom2")
        addRandomZSprite(zsprite: zspriterandom3, position: CGPoint(x: rangex3, y: rangey3), name: "zspriterandom3")
        addRandomZSprite(zsprite: zspriterandom4, position: CGPoint(x: rangex4, y: rangey4), name: "zspriterandom4")
        
        timelabel.textAlignment = NSTextAlignment.right
        highscorelabel.textAlignment = NSTextAlignment.right
        zcountlabel.textAlignment = NSTextAlignment.right
    }
    override func update(_ currentTime: TimeInterval) {
        
        randomNumberx1 = (Int(arc4random_uniform(widthframe)))
        rangex1 = Int(randomNumberx1 - Int(halfwidthframe))
        randomNumbery1 = (Int(arc4random_uniform(heightframe)))
        rangey1 = Int(randomNumbery1 - Int(halfheightframe))
        randomNumberx2 = (Int(arc4random_uniform(widthframe)))
        rangex2 = Int(randomNumberx2 - Int(halfwidthframe))
        randomNumbery2 = (Int(arc4random_uniform(heightframe)))
        rangey2 = Int(randomNumbery2 - Int(halfheightframe))
        randomNumberx3 = (Int(arc4random_uniform(widthframe)))
        rangex3 = Int(randomNumberx3 - Int(halfwidthframe))
        randomNumbery3 = (Int(arc4random_uniform(heightframe)))
        rangey3 = Int(randomNumbery3 - Int(halfheightframe))
        randomNumberx4 = (Int(arc4random_uniform(widthframe)))
        rangex4 = Int(randomNumberx4 - Int(halfwidthframe))
        randomNumbery4 = (Int(arc4random_uniform(heightframe)))
        rangey4 = Int(randomNumbery4 - Int(halfheightframe))
        
        if(!gameViewController.isPlayingMusic()){
            gameViewController.playMusic(file: "GameContinueSound")
        }
        
        highscorelabel.text = String(HighScore)
        self.view?.addSubview(highscorelabel)
        
        timelabel.text = String(time)
        self.view?.addSubview(timelabel)
        
        zcountlabel.text = String(ztruecount)
        self.view?.addSubview(zcountlabel)
        
        let randomNumber = (Int(arc4random_uniform(Upper + Upper)))
        let range : Int = Int(randomNumber - Int(Upper))
        
        if(road1.position.y < -road1.size.height-0){
            road1.position = CGPoint(x: road1.position.x, y: road2.position.y + road2.size.height)
        }
        
        if(road2.position.y < -road2.size.height-0){
            road2.position = CGPoint(x: road2.position.x, y: road1.position.y + road1.size.height)
        }
        
        if(obstacle1.position.y < -1080){
            obstacle1.position = CGPoint(x: range , y: 700)
            resetZSprite(zsprite: zsprite1right)
            resetZSprite(zsprite: zsprite1middle)
            resetZSprite(zsprite: zsprite1left)
        }
        if(obstacle2.position.y < -1080){
            obstacle2.position = CGPoint(x: range, y: 700)
            resetZSprite(zsprite: zsprite2right)
            resetZSprite(zsprite: zsprite2middle)
            resetZSprite(zsprite: zsprite2left)
        }
        if(obstacle3.position.y < -1080){
            obstacle3.position = CGPoint(x: range, y: 700)
            resetZSprite(zsprite: zsprite3right)
            resetZSprite(zsprite: zsprite3middle)
            resetZSprite(zsprite: zsprite3left)
        }
        if(obstacle4.position.y < -1080){
            obstacle4.position = CGPoint(x: range, y: 700)
            resetZSprite(zsprite: zsprite4right)
            resetZSprite(zsprite: zsprite4middle)
            resetZSprite(zsprite: zsprite4left)
        }
        checkRandomZ(zsprite: zspriterandom1)
        checkRandomZ(zsprite: zspriterandom2)
        checkRandomZ(zsprite: zspriterandom3)
        checkRandomZ(zsprite: zspriterandom4)
        
        checkCar()
        movingBackground()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if(contact.bodyA.node?.name == "Car"){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite1right"){
            removeZSprite(zsprite: zsprite1right)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite1middle"){
            removeZSprite(zsprite: zsprite1middle)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite1left"){
            removeZSprite(zsprite: zsprite1left)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite2right"){
            removeZSprite(zsprite: zsprite2right)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite2middle"){
            removeZSprite(zsprite: zsprite2middle)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite2left"){
            removeZSprite(zsprite: zsprite2left)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite3right"){
            removeZSprite(zsprite: zsprite3right)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite3middle"){
            removeZSprite(zsprite: zsprite3middle)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite3left"){
            removeZSprite(zsprite: zsprite3left)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite4right"){
            removeZSprite(zsprite: zsprite4right)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite4middle"){
            removeZSprite(zsprite: zsprite4middle)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite4left"){
            removeZSprite(zsprite: zsprite4left)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zspriterandom1"){
            removeZSprite(zsprite: zspriterandom1)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zspriterandom2"){
            removeZSprite(zsprite: zspriterandom2)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zspriterandom3"){
            removeZSprite(zsprite: zspriterandom3)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zspriterandom4"){
            removeZSprite(zsprite: zspriterandom4)
        }
        
        if(contact.bodyA.node?.name == "obstacle1"){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if(firstBody.node?.name == "obstacle1" && secondBody.node?.name == "zspriterandom1"){
            zspriterandom1.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle1" && secondBody.node?.name == "zspriterandom2"){
            zspriterandom2.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle1" && secondBody.node?.name == "zspriterandom3"){
            zspriterandom3.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle1" && secondBody.node?.name == "zspriterandom4"){
            zspriterandom4.isHidden = true
        }
        
        if(contact.bodyA.node?.name == "obstacle2"){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if(firstBody.node?.name == "obstacle2" && secondBody.node?.name == "zspriterandom1"){
            zspriterandom1.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle2" && secondBody.node?.name == "zspriterandom2"){
            zspriterandom2.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle2" && secondBody.node?.name == "zspriterandom3"){
            zspriterandom3.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle2" && secondBody.node?.name == "zspriterandom4"){
            zspriterandom4.isHidden = true
        }
        
        if(contact.bodyA.node?.name == "obstacle3"){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if(firstBody.node?.name == "obstacle3" && secondBody.node?.name == "zspriterandom1"){
            zspriterandom1.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle3" && secondBody.node?.name == "zspriterandom2"){
            zspriterandom2.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle3" && secondBody.node?.name == "zspriterandom3"){
            zspriterandom3.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle3" && secondBody.node?.name == "zspriterandom4"){
            zspriterandom4.isHidden = true
        }
        
        if(contact.bodyA.node?.name == "obstacle4"){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if(firstBody.node?.name == "obstacle4" && secondBody.node?.name == "zspriterandom1"){
            zspriterandom1.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle4" && secondBody.node?.name == "zspriterandom2"){
            zspriterandom2.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle4" && secondBody.node?.name == "zspriterandom3"){
            zspriterandom3.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle4" && secondBody.node?.name == "zspriterandom4"){
            zspriterandom4.isHidden = true
        }
        
    }
    func checkRandomZ(zsprite: SKSpriteNode){
        if(zsprite.position.y < -self.frame.height/2-zsprite.size.height/2){
            zsprite.isHidden = true
            moveRandomZSprite(zsprite: zsprite, position: zsprite.position)
        }
    }
    
    func removeZSprite(zsprite: SKSpriteNode){
        zsprite.isHidden = true
        ztruecount += 1
        zcount += 1
    }
    
    func resetZSprite(zsprite: SKSpriteNode){
        zsprite.isHidden = false
    }
    func checkCar(){
        if(car.position.y < 0 - self.frame.height/2 - car.size.height/2){
            gameViewController.stopMusic()
            setHighScore(time: time)
            setFinishTime(time: time)
            zcountlabel.isHidden = true
            timelabel.isHidden = true
            highscorelabel.isHidden = true
            let transition = SKTransition.push(with: SKTransitionDirection.up, duration: 1)
            let gameScene = StartScene(fileNamed: "DeathScene")
            gameScene?.scaleMode = .aspectFill
            self.view?.presentScene(gameScene!, transition: transition)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "HomeNode" {
                gameViewController.stopMusic()
                setHighScore(time: time)
                setFinishTime(time: time)
                zcountlabel.isHidden = true
                timelabel.isHidden = true
                highscorelabel.isHidden = true
                let transition = SKTransition.reveal(with: SKTransitionDirection.down, duration: 1)
                let gameScene = StartScene(fileNamed: "MenuScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
            if nodesArray.first?.name == "resetButton" {
                gameViewController.stopMusic()
                setHighScore(time: time)
                setFinishTime(time: time)
                zcountlabel.isHidden = true
                timelabel.isHidden = true
                highscorelabel.isHidden = true
                let transition = SKTransition.fade(withDuration: 1)
                let gameScene = StartScene(fileNamed: "GameScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
            
        }
    }
}
