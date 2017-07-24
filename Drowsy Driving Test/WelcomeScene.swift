//
//  WelcomeScene.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 6/26/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit
import AVFoundation

class WelcomeScene: SKScene, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var gameViewController = GameViewController()
    
    let name1 = UserDefaults.standard
    
    let birthday = UserDefaults.standard
    
    var continueButtonNode : SKSpriteNode!
    var continueLabelNode : SKLabelNode!
    
    var nameInput : UITextField!
    var numberInput : UITextField!
    var agePicker = UIPickerView()
    
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    
    var month = "January"
    var day = "1"
    var year = "2017"
    
    func setName(name: String){
        name1.set(name, forKey: "UserName")
        name1.synchronize()
    }
    
    func getName() -> String {
        if name1.value(forKey: "UserName") == nil{
            return "User"
        }
        return name1.string(forKey: "UserName")!
    }
    
    func setBirthday(month: String, day: String, year: String){
        birthday.set(month, forKey: "Month")
        birthday.set(day, forKey: "Day")
        birthday.set(year, forKey: "Year")
        birthday.synchronize()
    }
    
    func getBirthMonth() -> String {
        if(birthday.value(forKey: "Month") == nil){
            return ""
        }
        return (birthday.string(forKey: "Month")!)
    }

    func getBirthDay() -> String {
        if(birthday.value(forKey: "Day") == nil){
            return ""
        }
        return (birthday.string(forKey: "Day")!)
    }
    
    func getBirthYear() -> String {
        if(birthday.value(forKey: "Year") == nil){
            return ""
        }
        return (birthday.string(forKey: "Year")!)
    }
    
    override func didMove(to view: SKView){
        
        nameInput = UITextField(frame: CGRect(x: self.frame.width/12, y: self.frame.height/5, width: self.frame.width/3, height: 30))
        numberInput = UITextField(frame: CGRect(x: self.frame.width/12, y: self.frame.height/4, width: self.frame.width/3, height: 30))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(WelcomeScene.donePressed(sender:)))
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        nameInput.attributedPlaceholder = NSAttributedString(string: "Enter Name...", attributes: [NSForegroundColorAttributeName : UIColor.black])
        nameInput.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        nameInput.borderStyle = UITextBorderStyle.roundedRect
        nameInput.autocorrectionType = UITextAutocorrectionType.no
        nameInput.keyboardType = UIKeyboardType.default
        nameInput.returnKeyType = UIReturnKeyType.continue
        nameInput.clearButtonMode = UITextFieldViewMode.whileEditing;
        nameInput.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        nameInput.delegate = self as UITextFieldDelegate
        nameInput.backgroundColor = .white
        self.view?.addSubview(nameInput)
        
        numberInput.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        numberInput.attributedPlaceholder = NSAttributedString(string: "Enter Birthday...", attributes: [NSForegroundColorAttributeName : UIColor.black])
        numberInput.borderStyle = UITextBorderStyle.roundedRect
        numberInput.autocorrectionType = UITextAutocorrectionType.no
        numberInput.keyboardType = UIKeyboardType.numberPad
        numberInput.returnKeyType = UIReturnKeyType.done
        numberInput.clearButtonMode = UITextFieldViewMode.whileEditing;
        numberInput.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        numberInput.delegate = self as UITextFieldDelegate
        numberInput.backgroundColor = .white
        self.view?.addSubview(numberInput)
        
        continueButtonNode = self.childNode(withName: "ContinueNode") as! SKSpriteNode
        continueLabelNode = self.childNode(withName: "ContinueLabel") as! SKLabelNode

        agePicker.delegate = self
        agePicker.dataSource = self
        numberInput.inputView = agePicker
        
        toolbar.barStyle = UIBarStyle.blackTranslucent
        toolbar.tintColor = UIColor.blue
        toolbar.setItems([flexButton, doneButton], animated: true)
        numberInput.inputAccessoryView = toolbar
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
        case 1:
            day = gameViewController.database[component][pickerView.selectedRow(inComponent: 1)]
        case 2:
            year = gameViewController.database[component][pickerView.selectedRow(inComponent: 2)]
        default: break
        }

        numberInput.text = month + " " + day + ", " + year
        setBirthday(month: month, day: day, year: year)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField: nameInput, moveDistace: -30, up: true)
        moveTextField(textField: numberInput, moveDistace: -30, up: true)
        if(textField == numberInput){
            numberInput.text = month + " " + day + ", " + year
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField: nameInput, moveDistace: -30, up: false)
        moveTextField(textField: numberInput, moveDistace: -30, up: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == nameInput){
            numberInput.becomeFirstResponder()
            setName(name: nameInput.text!)
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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "ContinueNode" {
                continueLabelNode.fontColor = UIColor.lightGray
                let when = DispatchTime.now() + 0.1 // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.continueLabelNode.fontColor = UIColor.white
                }
                let transition = SKTransition.crossFade(withDuration: 0.05)
                let gameScene = SKScene(fileNamed: "LoadingScene")
                gameScene?.scaleMode = .aspectFill
                let when2 = DispatchTime.now() + 0.15 // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when2) {
                    self.nameInput.isHidden = true
                    self.numberInput.isHidden = true
                    self.view?.presentScene(gameScene!, transition: transition)
                }
            }
        }
    }
}
