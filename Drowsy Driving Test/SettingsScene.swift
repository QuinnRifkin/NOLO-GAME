//
//  SettingsScene.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 6/27/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class SettingsScene: SKScene, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    let welcomeScene = WelcomeScene()
    let gameScene = GameScene()
    let gameViewController = GameViewController()
    let sleepScene = SleepScene()
    var playViewController = (UIApplication.shared.delegate as! AppDelegate).playViewController!
    
    var resetPulse = SKAction.sequence([SKAction.scale(by: 1.1, duration: 0.5), SKAction.wait(forDuration: 0.05), SKAction.scale(by: (1/1.1), duration: 0.5), SKAction.wait(forDuration: 0.05)])
    
    var nameLabel : UILabel!
    var resetLabel : SKSpriteNode!
    
    var muteButton : SKSpriteNode!
    var unmuteButton : SKSpriteNode!
    
    var nameInput : UITextField!
    var numberInput : UITextField!
    let agePicker = UIPickerView()
    
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    let toolbarName = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    
    var birthMonth : String!
    var birthDay : String!
    var birthYear : String!
    
    var month = ""
    var day = ""
    var year = ""
    
    func setName(name: String){
        welcomeScene.setName(name: name)
    }
    
    func getName() -> String {
        return welcomeScene.getName()
    }
    
    func setBirthday(month: String, day: String, year: String){
        welcomeScene.setBirthday(month: month, day: day, year: year)
    }
    
    func getBirthMonth() -> String {
        return welcomeScene.getBirthMonth()
    }
    
    func getBirthDay() -> String {
        return welcomeScene.getBirthDay()
    }
    
    func getBirthYear() -> String {
        return welcomeScene.getBirthYear()
    }

    override func didMove(to view: SKView) {
        
        if(UIScreen.main.bounds.height == 480){
            nameLabel = UILabel(frame: CGRect(x: 30, y: 2, width: 150, height: 50))
        }else if(UIScreen.main.bounds.height == 568){
            nameLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 150, height: 50))
        }else{
            nameLabel = UILabel(frame: CGRect(x: 6, y: -15, width: 150, height: 100))
        }
        
        if(UIScreen.main.bounds.height == 480){
            nameInput = UITextField(frame: CGRect(x: 0, y: 0, width: self.frame.width/5, height: 20))
            numberInput = UITextField(frame: CGRect(x: 0, y: 0, width: self.frame.width/5, height: 20))
            nameInput.center = CGPoint(x: UIScreen.main.bounds.width/1.5 ,y: UIScreen.main.bounds.height/4 - 15)
            numberInput.center = CGPoint(x: UIScreen.main.bounds.width/1.5 ,y: UIScreen.main.bounds.height/4 + 40)
        }else if(UIScreen.main.bounds.height == 568){
            nameInput = UITextField(frame: CGRect(x: 0, y: 0, width: self.frame.width/4, height: 30))
            numberInput = UITextField(frame: CGRect(x: 0, y: 0, width: self.frame.width/4, height: 30))
            nameInput.center = CGPoint(x: UIScreen.main.bounds.width/1.5 ,y: UIScreen.main.bounds.height/4 - 15)
            numberInput.center = CGPoint(x: UIScreen.main.bounds.width/1.5 ,y: UIScreen.main.bounds.height/4 + 40)
        }else if(UIScreen.main.bounds.height == 736){
            nameInput = UITextField(frame: CGRect(x: 0, y: 0, width: self.frame.width/3.5, height: 30))
            numberInput = UITextField(frame: CGRect(x: 0, y: 0, width: self.frame.width/3.5, height: 30))
            nameInput.center = CGPoint(x: UIScreen.main.bounds.width/1.5 ,y: UIScreen.main.bounds.height/4 - 20)
            numberInput.center = CGPoint(x: UIScreen.main.bounds.width/1.5 ,y: UIScreen.main.bounds.height/4 + 60)
        }else{
            nameInput = UITextField(frame: CGRect(x: self.frame.width/5, y: self.frame.height/10, width: self.frame.width/4, height: 30))
            numberInput = UITextField(frame: CGRect(x: self.frame.width/5, y: self.frame.height/6.5, width: self.frame.width/4, height: 30))
        }
        
        resetLabel = self.childNode(withName: "Reset") as! SKSpriteNode
        
        muteButton = self.childNode(withName: "MuteButton") as! SKSpriteNode
        unmuteButton = self.childNode(withName: "UnmuteButton") as! SKSpriteNode
        if(gameScene.isMute()){
            muteButton.isHidden = true
            unmuteButton.isHidden = false
        }else{
            muteButton.isHidden = false
            unmuteButton.isHidden = true
        }
        
        //resetLabel.run(SKAction.repeatForever(resetPulse))
        
        let name = String(welcomeScene.getName())
        if(name!.characters.count >= 25)
        {
            nameLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 10)
        } else if(name!.characters.count >= 20){
            nameLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 12)
        } else if(name!.characters.count >= 15){
            nameLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 14)
        } else if(name!.characters.count >= 10){
            nameLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 16)
        } else {
            nameLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 18)
        }
        
        nameLabel.attributedText = NSAttributedString(string: name!, attributes: [NSForegroundColorAttributeName : UIColor.white])
        nameLabel.textAlignment = NSTextAlignment.left

        self.view?.addSubview(nameLabel)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(SettingsScene.donePressed(sender:)))
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(SettingsScene.cancelPressed(sender:)))
        
        let cancelNameButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(SettingsScene.cancelNamePressed(sender:)))
        
        nameInput.attributedPlaceholder = NSAttributedString(string: welcomeScene.getName(), attributes: [NSForegroundColorAttributeName : UIColor.black])
        nameInput.font = UIFont(name: "ChalkboardSE-Regular", size: 15)
        nameInput.borderStyle = .roundedRect
        nameInput.autocorrectionType = UITextAutocorrectionType.no
        nameInput.keyboardType = UIKeyboardType.default
        nameInput.returnKeyType = UIReturnKeyType.done
        nameInput.clearButtonMode = UITextFieldViewMode.whileEditing;
        nameInput.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        nameInput.delegate = self as UITextFieldDelegate
        nameInput.backgroundColor = .white
        
        numberInput.font = UIFont(name: "ChalkboardSE-Regular", size: 15)
        numberInput.attributedPlaceholder = NSAttributedString(string: welcomeScene.getBirthMonth() + " " + welcomeScene.getBirthDay() + ", " + welcomeScene.getBirthYear(), attributes: [NSForegroundColorAttributeName : UIColor.black])
        numberInput.borderStyle = UITextBorderStyle.roundedRect
        numberInput.autocorrectionType = UITextAutocorrectionType.no
        numberInput.keyboardType = UIKeyboardType.numberPad
        numberInput.returnKeyType = UIReturnKeyType.done
        numberInput.clearButtonMode = UITextFieldViewMode.whileEditing;
        numberInput.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        numberInput.delegate = self as UITextFieldDelegate
        numberInput.backgroundColor = .white
        
        agePicker.delegate = self
        agePicker.dataSource = self
        numberInput.inputView = agePicker
        
        toolbar.barStyle = .default
        toolbar.tintColor = UIColor.blue
        toolbar.setItems([cancelButton, flexButton, doneButton], animated: true)
        numberInput.inputAccessoryView = toolbar
        
        toolbarName.barStyle = UIBarStyle.default
        toolbarName.tintColor = UIColor.blue
        toolbarName.setItems([cancelNameButton], animated: true)
        nameInput.inputAccessoryView = toolbarName
        
        birthMonth = welcomeScene.getBirthMonth()
        birthDay = welcomeScene.getBirthDay()
        birthYear = welcomeScene.getBirthYear()
        let birthYearInt = 2017 - (Int(birthYear))!
        let birthDayInt = (-1 + Int(birthDay)!)
        var birthMonthInt = 0
        switch(birthMonth){
        case "January":
            birthMonthInt = 0
        case "Febuary":
            birthMonthInt = 1
        case "March":
            birthMonthInt = 2
        case "April":
            birthMonthInt = 3
        case "May":
            birthMonthInt = 4
        case "June":
            birthMonthInt = 5
        case "July":
            birthMonthInt = 6
        case "August":
            birthMonthInt = 7
        case "September":
            birthMonthInt = 8
        case "October":
            birthMonthInt = 9
        case "November":
            birthMonthInt = 10
        case "December":
            birthMonthInt = 11
        default: birthMonthInt = 0
        }
        
        let when = DispatchTime.now() + 0.0 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.view?.addSubview(self.nameInput)
            self.view?.addSubview(self.numberInput)
            self.agePicker.selectRow(birthMonthInt, inComponent: 0, animated: true)
            self.agePicker.selectRow(birthDayInt, inComponent: 1, animated: true)
            self.agePicker.selectRow(birthYearInt, inComponent: 2, animated: true)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return gameViewController.database.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gameViewController.database[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gameViewController.database[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch(component){
        case 0:
            month = gameViewController.database[component][pickerView.selectedRow(inComponent: 0)]
            birthMonth = gameViewController.database[component][pickerView.selectedRow(inComponent: 0)]
        case 1:
            day = gameViewController.database[component][pickerView.selectedRow(inComponent: 1)]
            birthDay = gameViewController.database[component][pickerView.selectedRow(inComponent: 1)]
        case 2:
            year = gameViewController.database[component][pickerView.selectedRow(inComponent: 2)]
            birthYear = gameViewController.database[component][pickerView.selectedRow(inComponent: 2)]
        default: break
        }
        numberInput.text = birthMonth + " " + birthDay + ", " + birthYear
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == nameInput){
            nameInput.text = welcomeScene.getName()
            nameInput.placeholder = ""
        }
        if(textField == numberInput){
            numberInput.text = birthMonth + " " + birthDay + ", " + birthYear
        }
        moveTextField(textField: nameInput, moveDistace: -20, up: true)
        moveTextField(textField: numberInput, moveDistace: -20, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField: nameInput, moveDistace: -20, up: false)
        moveTextField(textField: numberInput, moveDistace: -20, up: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == nameInput){
            nameInput.resignFirstResponder()
            setName(name: nameInput.text!)
            nameLabel.attributedText = NSAttributedString(string: nameInput.text!, attributes: [NSForegroundColorAttributeName : UIColor.white])
            if(nameInput.text!.characters.count >= 25)
            {
                nameLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 10)
            } else if(nameInput.text!.characters.count >= 20){
                nameLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 12)
            } else if(nameInput.text!.characters.count >= 15){
                nameLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 14)
            } else if(nameInput.text!.characters.count >= 10){
                nameLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 16)
            } else {
                nameLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 18)
            }
        }
        else{
            numberInput.resignFirstResponder()
            agePicker.resignFirstResponder()
        }
        return true
    }
    
    func moveTextField(textField: UITextField, moveDistace: Int, up: Bool){
        let duration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistace : -moveDistace)
        
        UIView.beginAnimations("TextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(duration)
        self.view?.frame = (self.view?.frame)!.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func donePressed(sender: UIBarButtonItem){
        numberInput.resignFirstResponder()
        self.view?.endEditing(true)
        setBirthday(month: birthMonth, day: birthDay, year: birthYear)
        numberInput.text = birthMonth + " " + birthDay + ", " + birthYear
    }

    func cancelPressed(sender:UIBarButtonItem){
        numberInput.resignFirstResponder()
        self.view?.endEditing(true)
        numberInput.text! = welcomeScene.getBirthMonth() + " " + welcomeScene.getBirthDay() + ", " + welcomeScene.getBirthYear()
    }
    
    func cancelNamePressed(sender: UIBarButtonItem){
        nameInput.resignFirstResponder()
        self.view?.endEditing(true)
        nameInput.text! = welcomeScene.getName()
        
    }
    
    func stopMusic(){
        playViewController.stopMusic()
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "ResetNode" {
                resetLabel.scale(to: CGSize(width: 144, height: 74))
            }
            
            if nodesArray.first?.name == "MuteNode" { //click unmute
                if(unmuteButton.isHidden){
                    muteButton.scale(to: CGSize(width: 135, height: 74))
                }else{
                    unmuteButton.scale(to: CGSize(width: 190, height: 74))
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "ResetNode" {
                resetLabel.scale(to: CGSize(width: 160, height: 82))
            }
            if nodesArray.first?.name == "MuteNode" {
                if(muteButton.isHidden){
                    muteButton.scale(to: CGSize(width: 150, height: 82))
                }else{
                    unmuteButton.scale(to: CGSize(width: 211, height: 82))
                }
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let highScore = gameScene.getHighScore()
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "ResetNode" {
                resetLabel.scale(to: CGSize(width: 160, height: 82))
                if(highScore != 0){
                    let alert = UIAlertController(title: "WARNING", message: "Your highscore is " + String(highScore) + "\n There is no going back...", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
                    alert.addAction(UIAlertAction(title: "RESET", style: UIAlertActionStyle.destructive, handler: { action in
                        self.gameScene.resetHighScore()}))
                
                    if let vc = self.view?.window?.rootViewController {
                        vc.present(alert, animated: true, completion: nil)
                    }
                }
                else{
                    let alert = UIAlertController(title: "Nice Try", message: "Your highscore is already 0", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                    if let vc = self.view?.window?.rootViewController {
                        vc.present(alert, animated: true, completion: nil)
                    }
                }
            }
            if nodesArray.first?.name == "MuteNode" { //click unmute
                if(muteButton.isHidden){
                    muteButton.scale(to: CGSize(width: 150, height: 82))
                    muteButton.isHidden = false
                    unmuteButton.isHidden = true
                    gameScene.setMute(muteBool: false)  //.mute.set(false, forKey: "isMute")
                    print("not mute")
                }else{
                    unmuteButton.scale(to: CGSize(width: 211, height: 82))
                    muteButton.isHidden = true
                    unmuteButton.isHidden = false
                    gameScene.setMute(muteBool: true)  //.mute.set(true, forKey: "isMute")
                    print("mute")
                }
            }
        }
    }
}
