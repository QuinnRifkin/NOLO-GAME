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
    
    var highScoreDefault = UserDefaults.standard
    var highScore: Int = 0
    
    struct collisionType{
        static let carx : UInt32 = 1
        static let zspritex : UInt32 = 2
    }
    
    var widthFrame : UInt32 = 0
    var halfWidthFrame : UInt32 = 0
    var heightFrame : UInt32 = 0
    var halfHeightFrame : UInt32 = 0
    
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
    
    let upper : UInt32 = (128)
    var acc = CGFloat(0.0)
    
    var zCount = 0
    var zTrueCount = 0
    var zBackCount = 0
    
    var zCountDefault = UserDefaults.standard
    var time : Int = 0
    var timer = Timer()
    
    var resetButtonNode: SKSpriteNode!
    var homeLabelNode: SKSpriteNode!
    
    var timeLabel : UILabel!
    var highScoreLabel : UILabel!
    var zCountLabel : UILabel!
    
    let road1 = SKSpriteNode(imageNamed: "RoadSpriteWGrass")
    let road2 = SKSpriteNode(imageNamed: "RoadSpriteWGrass")
    
    let obstacle1 = SKSpriteNode(imageNamed: "WallSprite")
    let obstacle2 = SKSpriteNode(imageNamed: "WallSprite")
    let obstacle3 = SKSpriteNode(imageNamed: "WallSprite")
    let obstacle4 = SKSpriteNode(imageNamed: "WallSprite")
    
    let car = SKSpriteNode(imageNamed: "CarSprite")
    
    let zSprite1Right = SKSpriteNode(imageNamed: "ZSprite")
    let zSprite1Middle = SKSpriteNode(imageNamed: "ZSprite")
    let zSprite1Left = SKSpriteNode(imageNamed: "ZSprite")
    
    let zSprite2Right = SKSpriteNode(imageNamed: "ZSprite")
    let zSprite2Middle = SKSpriteNode(imageNamed: "ZSprite")
    let zSprite2Left = SKSpriteNode(imageNamed: "ZSprite")
    
    let zSprite3Right = SKSpriteNode(imageNamed: "ZSprite")
    let zSprite3Middle = SKSpriteNode(imageNamed: "ZSprite")
    let zSprite3Left = SKSpriteNode(imageNamed: "ZSprite")
    
    let zSprite4Right = SKSpriteNode(imageNamed: "ZSprite")
    let zSprite4Middle = SKSpriteNode(imageNamed: "ZSprite")
    let zSprite4Left = SKSpriteNode(imageNamed: "ZSprite")
    
    let zSpriteRandom1 = SKSpriteNode(imageNamed: "ZSprite")
    let zSpriteRandom2 = SKSpriteNode(imageNamed: "ZSprite")
    let zSpriteRandom3 = SKSpriteNode(imageNamed: "ZSprite")
    let zSpriteRandom4 = SKSpriteNode(imageNamed: "ZSprite")
    
    let leftWall = SKSpriteNode(imageNamed: "FieldLines")
    let rightWall = SKSpriteNode(imageNamed: "FieldLines")
    
    let left = SKAction.moveBy(x: -175, y: 0, duration: 0.2)
    let right = SKAction.moveBy(x: 175, y: 0, duration: 0.2)
    
    func swipeLeft(_ gestureRecognizer: UITapGestureRecognizer){
        car.run(left)
    }
    
    func swipeRight(_ gestureRecognizer: UITapGestureRecognizer){
        car.run(right)
    }
    
    func addLeftWall(){
        leftWall.position = CGPoint(x: 0 - (self.frame.width/2) - (leftWall.size.width/2) - 50, y: 0)
        leftWall.size = CGSize(width: 100, height: self.frame.height + car.size.height*2)
        leftWall.zPosition = -1
        leftWall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: leftWall.size.width, height: leftWall.size.height))
        leftWall.physicsBody?.isDynamic = false
        leftWall.physicsBody?.allowsRotation = false
        leftWall.physicsBody?.mass = 10000000000000000000.0
        addChild(leftWall)
    }
    
    func addRightWall(){
        rightWall.position = CGPoint(x: 0 + (self.frame.width/2) + (rightWall.size.width/2) + 50, y: 0)
        rightWall.size = CGSize(width: 100, height: self.frame.height + car.size.height*2)
        rightWall.zPosition = -1
        rightWall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rightWall.size.width, height: rightWall.size.height))
        rightWall.physicsBody?.isDynamic = false
        rightWall.physicsBody?.allowsRotation = false
        rightWall.physicsBody?.mass = 10000000000000000000.0
        addChild(rightWall)
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
    
    func addRandomZSprite(zSprite: SKSpriteNode, position: CGPoint, name: String){
        zSprite.name = name
        zSprite.position = position
        zSprite.zPosition = 1
        zSprite.size = CGSize(width: 60, height: 60)
        zSprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: zSprite.size.width, height: zSprite.size.height))
        zSprite.physicsBody?.isDynamic = true
        zSprite.physicsBody?.allowsRotation = false
        zSprite.physicsBody?.mass = 0.1
        zSprite.physicsBody?.categoryBitMask = collisionType.zspritex
        addChild(zSprite)
    }
    
    func moveRandomZSprite(zSprite: SKSpriteNode, position: CGPoint){
        if(zSprite.isHidden){
            zSprite.isHidden = false;
            zSprite.position = CGPoint(x: rangex1, y: rangey1)
        }
        else{
            zSprite.position = CGPoint(x: zSprite.position.x, y: zSprite.position.y-4-acc+CGFloat(zCount/10))
        }
    }
    
    func updateTime(){
        time += 1;
        acc += 0.15
        zBackCount += 1;
        if(zBackCount >= 5 && zCount > 0){
            zCount -= 1;
            zBackCount -= 5
        }
    }
    
    func movingBackground(){
        
        road1.position = CGPoint(x: road1.position.x, y: road1.position.y-4-acc+CGFloat(zCount/10))
        road2.position = CGPoint(x: road2.position.x, y: road2.position.y-4-acc+CGFloat(zCount/10))
        
        obstacle1.position = CGPoint(x: obstacle1.position.x, y: obstacle1.position.y-4-acc+CGFloat(zCount/10))
        obstacle2.position = CGPoint(x: obstacle2.position.x, y: obstacle2.position.y-4-acc+CGFloat(zCount/10))
        obstacle3.position = CGPoint(x: obstacle3.position.x, y: obstacle3.position.y-4-acc+CGFloat(zCount/10))
        obstacle4.position = CGPoint(x: obstacle4.position.x, y: obstacle4.position.y-4-acc+CGFloat(zCount/10))
        
        moveRandomZSprite(zSprite: zSpriteRandom1, position: zSpriteRandom1.position)
        moveRandomZSprite(zSprite: zSpriteRandom2, position: zSpriteRandom2.position)
        moveRandomZSprite(zSprite: zSpriteRandom3, position: zSpriteRandom3.position)
        moveRandomZSprite(zSprite: zSpriteRandom4, position: zSpriteRandom4.position)
    }
    
    func getHighScore() -> Int {
        return (highScoreDefault.integer(forKey: "HighScore"))
    }
    
    func getFinishZCount() -> Int {
        return zCountDefault.integer(forKey: "FinalZCount")
    }
    
    func setHighScore(zcount: Int){
        if(highScore > (highScoreDefault.integer(forKey: "HighScore"))){
            highScoreDefault.set(highScore, forKey: "HighScore")
        }
        highScoreDefault.synchronize()
    }
    
    func setFinishZCount(zcount: Int){
        zCountDefault.set(zcount, forKey: "FinalZCount")
        zCountDefault.synchronize()
    }
    
    func resetHighScore(){
        highScoreDefault.set(0, forKey: "HighScore")
    }
    
    override func didMove(to view: SKView) {
        
        timeLabel = UILabel(frame: CGRect(x: 0, y: 20, width: self.frame.width/2 , height: 20))
        timeLabel.font = UIFont.init(name: "PressStart2P", size: 13)
        highScoreLabel = UILabel(frame: CGRect(x: 0, y: 40, width: self.frame.width/2 , height: 20))
        highScoreLabel.font = UIFont.init(name: "PressStart2P", size: 13)
        zCountLabel = UILabel(frame: CGRect(x: 0, y: 60, width: self.frame.width/2 , height: 20))
        zCountLabel.font = UIFont.init(name: "PressStart2P", size: 13)
        
        widthFrame = UInt32(self.frame.width)
        halfWidthFrame = widthFrame/2
        heightFrame = UInt32(self.frame.height)
        halfHeightFrame = heightFrame/2
        
        randomNumberx1 = (Int(arc4random_uniform(widthFrame)))
        rangex1 = Int(randomNumberx1 - Int(halfWidthFrame))
        
        randomNumberx2 = (Int(arc4random_uniform(widthFrame)))
        rangex2 = Int(randomNumberx2 - Int(halfWidthFrame))
        
        randomNumberx3 = (Int(arc4random_uniform(widthFrame)))
        rangex3 = Int(randomNumberx3 - Int(halfWidthFrame))
        
        randomNumberx4 = (Int(arc4random_uniform(widthFrame)))
        rangex4 = Int(randomNumberx4 - Int(halfWidthFrame))
        
        randomNumbery1 = (Int(arc4random_uniform(heightFrame)))
        rangey1 = Int(randomNumbery1 + Int(halfHeightFrame))
        
        randomNumbery2 = (Int(arc4random_uniform(heightFrame)))
        rangey2 = Int(randomNumbery2 + Int(halfHeightFrame))
        
        randomNumbery3 = (Int(arc4random_uniform(heightFrame)))
        rangey3 = Int(randomNumbery3 + Int(halfHeightFrame))
        
        randomNumbery4 = (Int(arc4random_uniform(heightFrame)))
        rangey4 = Int(randomNumbery4 + Int(halfHeightFrame))
        
        gameViewController.playMusic(file: "GameStartSound")
        
        if(highScoreDefault.value(forKey: "HighScore") != nil){
            highScore = highScoreDefault.value(forKey: "HighScore") as! NSInteger!
            highScoreLabel.text = String(highScore)
            self.view?.addSubview(highScoreLabel)
        }
        zCountDefault.set(0, forKey: "FinalTime")
        
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
        homeLabelNode = self.childNode(withName: "HomeNode") as! SKSpriteNode
        homeLabelNode.texture = SKTexture(imageNamed: "HomeIcon")
        
        addLeftWall()
        addRightWall()
        
        addRoad(road: road1, y: 0)
        addRoad(road: road2, y: road1.size.height-1)
        
        addObstacle(obstacle: obstacle1, location: CGPoint(x:127.908, y: 1350), name: "obstacle1")
        addObstacle(obstacle: obstacle2, location: CGPoint(x:-128.339, y: 900), name: "obstacle2")
        addObstacle(obstacle: obstacle3, location: CGPoint(x:127.908, y: 450), name: "obstacle3")
        addObstacle(obstacle: obstacle4, location: CGPoint(x:-128.339, y: 0), name: "obstacle4")
        
        addCar(car: car)
        
        addRandomZSprite(zSprite: zSpriteRandom1, position: CGPoint(x: rangex1, y: rangey1), name: "zspriterandom1")
        addRandomZSprite(zSprite: zSpriteRandom2, position: CGPoint(x: rangex2, y: rangey2), name: "zspriterandom2")
        addRandomZSprite(zSprite: zSpriteRandom3, position: CGPoint(x: rangex3, y: rangey3), name: "zspriterandom3")
        addRandomZSprite(zSprite: zSpriteRandom4, position: CGPoint(x: rangex4, y: rangey4), name: "zspriterandom4")
        
        timeLabel.textAlignment = NSTextAlignment.right
        highScoreLabel.textAlignment = NSTextAlignment.right
        zCountLabel.textAlignment = NSTextAlignment.right
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        randomNumberx1 = (Int(arc4random_uniform(widthFrame)))
        rangex1 = Int(randomNumberx1 - Int(halfWidthFrame))
        randomNumbery1 = (Int(arc4random_uniform(heightFrame)))
        rangey1 = Int(randomNumbery1 + Int(halfHeightFrame))
        randomNumberx2 = (Int(arc4random_uniform(widthFrame)))
        rangex2 = Int(randomNumberx2 - Int(halfWidthFrame))
        randomNumbery2 = (Int(arc4random_uniform(heightFrame)))
        rangey2 = Int(randomNumbery2 + Int(halfHeightFrame))
        randomNumberx3 = (Int(arc4random_uniform(widthFrame)))
        rangex3 = Int(randomNumberx3 - Int(halfWidthFrame))
        randomNumbery3 = (Int(arc4random_uniform(heightFrame)))
        rangey3 = Int(randomNumbery3 + Int(halfHeightFrame))
        randomNumberx4 = (Int(arc4random_uniform(widthFrame)))
        rangex4 = Int(randomNumberx4 - Int(halfWidthFrame))
        randomNumbery4 = (Int(arc4random_uniform(heightFrame)))
        rangey4 = Int(randomNumbery4 + Int(halfHeightFrame))
        
        if(!gameViewController.isPlayingMusic()){
            gameViewController.playMusic(file: "GameContinueSound")
        }
        
        if(zTrueCount >= highScore){
            highScore = zTrueCount
        }
        
        highScoreLabel.attributedText = NSAttributedString(string: String(highScore), attributes: [NSForegroundColorAttributeName : UIColor.white])
        self.view?.addSubview(highScoreLabel)
        
        timeLabel.attributedText = NSAttributedString(string: String(time), attributes: [NSForegroundColorAttributeName : UIColor.white])
        self.view?.addSubview(timeLabel)
        
        zCountLabel.attributedText = NSAttributedString(string: String(zTrueCount), attributes: [NSForegroundColorAttributeName : UIColor.white])
        self.view?.addSubview(zCountLabel)
        
        let randomNumber = (Int(arc4random_uniform(upper + upper)))
        let range : Int = Int(randomNumber - Int(upper))
        
        if(road1.position.y < -road1.size.height-0){
            road1.position = CGPoint(x: road1.position.x, y: road2.position.y + road2.size.height)
        }
        
        if(road2.position.y < -road2.size.height-0){
            road2.position = CGPoint(x: road2.position.x, y: road1.position.y + road1.size.height)
        }
        
        if(obstacle1.position.y < -1080){
            obstacle1.position = CGPoint(x: range , y: 700)
            resetZSprite(zsprite: zSprite1Right)
            resetZSprite(zsprite: zSprite1Middle)
            resetZSprite(zsprite: zSprite1Left)
        }
        if(obstacle2.position.y < -1080){
            obstacle2.position = CGPoint(x: range, y: 700)
            resetZSprite(zsprite: zSprite2Right)
            resetZSprite(zsprite: zSprite2Middle)
            resetZSprite(zsprite: zSprite2Left)
        }
        if(obstacle3.position.y < -1080){
            obstacle3.position = CGPoint(x: range, y: 700)
            resetZSprite(zsprite: zSprite3Right)
            resetZSprite(zsprite: zSprite3Middle)
            resetZSprite(zsprite: zSprite3Left)
        }
        if(obstacle4.position.y < -1080){
            obstacle4.position = CGPoint(x: range, y: 700)
            resetZSprite(zsprite: zSprite4Right)
            resetZSprite(zsprite: zSprite4Middle)
            resetZSprite(zsprite: zSprite4Left)
        }
        checkRandomZ(zSprite: zSpriteRandom1)
        checkRandomZ(zSprite: zSpriteRandom2)
        checkRandomZ(zSprite: zSpriteRandom3)
        checkRandomZ(zSprite: zSpriteRandom4)
        
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
            removeZSprite(zSprite: zSprite1Right)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite1middle"){
            removeZSprite(zSprite: zSprite1Middle)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite1left"){
            removeZSprite(zSprite: zSprite1Left)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite2right"){
            removeZSprite(zSprite: zSprite2Right)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite2middle"){
            removeZSprite(zSprite: zSprite2Middle)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite2left"){
            removeZSprite(zSprite: zSprite2Left)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite3right"){
            removeZSprite(zSprite: zSprite3Right)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite3middle"){
            removeZSprite(zSprite: zSprite3Middle)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite3left"){
            removeZSprite(zSprite: zSprite3Left)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite4right"){
            removeZSprite(zSprite: zSprite4Right)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite4middle"){
            removeZSprite(zSprite: zSprite4Middle)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zsprite4left"){
            removeZSprite(zSprite: zSprite4Left)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zspriterandom1"){
            removeZSprite(zSprite: zSpriteRandom1)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zspriterandom2"){
            removeZSprite(zSprite: zSpriteRandom2)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zspriterandom3"){
            removeZSprite(zSprite: zSpriteRandom3)
        }
        else if(firstBody.node?.name == "Car" && secondBody.node?.name == "zspriterandom4"){
            removeZSprite(zSprite: zSpriteRandom4)
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
            zSpriteRandom1.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle1" && secondBody.node?.name == "zspriterandom2"){
            zSpriteRandom2.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle1" && secondBody.node?.name == "zspriterandom3"){
            zSpriteRandom3.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle1" && secondBody.node?.name == "zspriterandom4"){
            zSpriteRandom4.isHidden = true
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
            zSpriteRandom1.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle2" && secondBody.node?.name == "zspriterandom2"){
            zSpriteRandom2.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle2" && secondBody.node?.name == "zspriterandom3"){
            zSpriteRandom3.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle2" && secondBody.node?.name == "zspriterandom4"){
            zSpriteRandom4.isHidden = true
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
            zSpriteRandom1.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle3" && secondBody.node?.name == "zspriterandom2"){
            zSpriteRandom2.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle3" && secondBody.node?.name == "zspriterandom3"){
            zSpriteRandom3.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle3" && secondBody.node?.name == "zspriterandom4"){
            zSpriteRandom4.isHidden = true
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
            zSpriteRandom1.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle4" && secondBody.node?.name == "zspriterandom2"){
            zSpriteRandom2.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle4" && secondBody.node?.name == "zspriterandom3"){
            zSpriteRandom3.isHidden = true
        }
        else if(firstBody.node?.name == "obstacle4" && secondBody.node?.name == "zspriterandom4"){
            zSpriteRandom4.isHidden = true
        }
        
    }
    func checkRandomZ(zSprite: SKSpriteNode){
        if(zSprite.position.y < -self.frame.height/2-zSprite.size.height/2){
            zSprite.isHidden = true
            moveRandomZSprite(zSprite: zSprite, position: zSprite.position)
        }
    }
    
    func removeZSprite(zSprite: SKSpriteNode){
        zSprite.isHidden = true
        zTrueCount += 1
        zCount += 1
    }
    
    func resetZSprite(zsprite: SKSpriteNode){
        zsprite.isHidden = false
    }
    func checkCar(){
        if(car.position.y < 0 - self.frame.height/2 - car.size.height/2){
            gameViewController.stopMusic()
            setHighScore(zcount: zTrueCount)
            setFinishZCount(zcount: zTrueCount)
            zCountLabel.isHidden = true
            timeLabel.isHidden = true
            highScoreLabel.isHidden = true
            let transition = SKTransition.push(with: SKTransitionDirection.up, duration: 1)
            let gameScene = DeathScene(fileNamed: "DeathScene")
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
                setHighScore(zcount: zTrueCount)
                setFinishZCount(zcount: zTrueCount)
                zCountLabel.isHidden = true
                timeLabel.isHidden = true
                highScoreLabel.isHidden = true
                let transition = SKTransition.push(with: SKTransitionDirection.down, duration: 0.5)
                let gameScene = DeathScene(fileNamed: "MenuScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
            if nodesArray.first?.name == "resetButton" {
                gameViewController.stopMusic()
                setHighScore(zcount: zTrueCount)
                setFinishZCount(zcount: zTrueCount)
                zCountLabel.isHidden = true
                timeLabel.isHidden = true
                highScoreLabel.isHidden = true
                let transition = SKTransition.fade(withDuration: 1)
                let gameScene = DeathScene(fileNamed: "GameScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
        }
    }
}
