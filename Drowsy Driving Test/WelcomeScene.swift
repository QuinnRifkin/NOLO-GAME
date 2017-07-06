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

class WelcomeScene: SKScene, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    let name1 = UserDefaults.standard
    
    let birthday = UserDefaults.standard
    
    var continueButtonNode: SKSpriteNode!
    
    var nameInput : UITextField!
    var numberInput : UITextField!
    var agePicker = UIPickerView()
    
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    
    var database = [
        ["January","February","March","April","May","June","July","August","September","October","November","December"],
        ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"],
        ["2017","2016","2015","2014","2013","2012","2011","2010","2009","2008","2007","2006","2005","2004","2003","2002","2001","2000","1999","1998","1997","1996","1995","1994","1993","1992","1991","1990","1989","1988","1987","1986","1985","1984","1983","1982","1981","1980"]
    ]
    
    var month = "January"
    var day = "1"
    var year = "2017"
    
    func setName(name: String){
        name1.set(name, forKey: "UserName")
        name1.synchronize()
    }
    
    func getName() -> String {
        if name1.value(forKey: "UserName") == nil{
            return "TAN"
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
        return (birthday.string(forKey: "Month")!)
    }

    func getBirthDay() -> String {
        return (birthday.string(forKey: "Day")!)
    }
    
    func getBirthYear() -> String {
        return (birthday.string(forKey: "Year")!)
    }
    
    override func didMove(to view: SKView){
        
        nameInput = UITextField(frame: CGRect(x: self.frame.width/12, y: self.frame.height/5, width: self.frame.width/3, height: 30))
        numberInput = UITextField(frame: CGRect(x: self.frame.width/12, y: self.frame.height/4, width: self.frame.width/3, height: 30))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(WelcomeScene.donePressed(sender:)))
        
        nameInput.attributedPlaceholder = NSAttributedString(string: "Enter Name...", attributes: [NSForegroundColorAttributeName : UIColor.black])
        nameInput.font = UIFont(name: "HelveticaNeue-UltraLight", size: 15)
        nameInput.borderStyle = UITextBorderStyle.roundedRect
        nameInput.autocorrectionType = UITextAutocorrectionType.no
        nameInput.keyboardType = UIKeyboardType.default
        nameInput.returnKeyType = UIReturnKeyType.continue
        nameInput.clearButtonMode = UITextFieldViewMode.whileEditing;
        nameInput.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        nameInput.delegate = self as UITextFieldDelegate
        nameInput.backgroundColor = .white
        self.view?.addSubview(nameInput)
        
        numberInput.font = UIFont(name: "HelveticaNeue-UltraLight", size: 15)
        numberInput.attributedPlaceholder = NSAttributedString(string: "Enter Age...", attributes: [NSForegroundColorAttributeName : UIColor.black])
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

        agePicker.delegate = self
        agePicker.dataSource = self
        numberInput.inputView = agePicker
        
        toolbar.barStyle = UIBarStyle.blackTranslucent
        toolbar.tintColor = UIColor.blue
        toolbar.setItems([doneButton], animated: true)
        numberInput.inputAccessoryView = toolbar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return database.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return database[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return database[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch(component){
        case 0:
            month = database[component][pickerView.selectedRow(inComponent: 0)]
        case 1:
            day = database[component][pickerView.selectedRow(inComponent: 1)]
        case 2:
            year = database[component][pickerView.selectedRow(inComponent: 2)]
        default: break
        }

        numberInput.text = month + " " + day + ", " + year
        setBirthday(month: month, day: day, year: year)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField: nameInput, moveDistace: -50, up: true)
        moveTextField(textField: numberInput, moveDistace: -50, up: true)
        if(textField == numberInput){
            numberInput.text = month + " " + day + ", " + year
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField: nameInput, moveDistace: -50, up: false)
        moveTextField(textField: numberInput, moveDistace: -50, up: false)
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
                nameInput.isHidden = true
                numberInput.isHidden = true
                let transition = SKTransition.crossFade(withDuration: 0.05)
                let gameScene = MenuScene(fileNamed: "LoadingScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
        }
    }
}
