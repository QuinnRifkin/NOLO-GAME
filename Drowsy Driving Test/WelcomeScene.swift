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
    
    let Name = UserDefaults.standard
    
    let Birthday = UserDefaults.standard
    
    var ContinueButtonNode: SKSpriteNode!
    
    var NameInput : UITextField!
    var NumberInput : UITextField!
    var AgePicker = UIPickerView()
    
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    
    var Database = [
        ["January","February","March","April","May","June","July","August","September","October","November","December"],
        ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"],
        ["2017","2016","2015","2014","2013","2012","2011","2010","2009","2008","2007","2006","2005","2004","2003","2002","2001","2000","1999","1998","1997","1996","1995","1994","1993","1992","1991","1990","1989","1988","1987","1986","1985","1984","1983","1982","1981","1980"]
    ]
    
    var month = "January"
    var day = "1"
    var year = "2017"
    
    func setName(name: String){
        Name.set(name, forKey: "UserName")
        Name.synchronize()
    }
    
    func getName() -> String {
        if Name.value(forKey: "UserName") == nil{
            return "TAN"
        }
        return Name.string(forKey: "UserName")!
    }
    
    func setBirthday(month: String, day: String, year: String){
        Birthday.set(month, forKey: "Month")
        Birthday.set(day, forKey: "Day")
        Birthday.set(year, forKey: "Year")
        Birthday.synchronize()
    }
    
    func getBirthMonth() -> String {
        return (Birthday.string(forKey: "Month")!)
    }

    func getBirthDay() -> String {
        return (Birthday.string(forKey: "Day")!)
    }
    
    func getBirthYear() -> String {
        return (Birthday.string(forKey: "Year")!)
    }
    
    override func didMove(to view: SKView){
       // self.backgroundColor = .clear
        
        NameInput = UITextField(frame: CGRect(x: 65, y: 250, width: self.frame.width/4, height: 30))
        NumberInput = UITextField(frame: CGRect(x: 65, y: 320, width: self.frame.width/4, height: 30))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(WelcomeScene.donePressed(sender:)))
        
        NameInput.attributedPlaceholder = NSAttributedString(string: "Enter Name...", attributes: [NSForegroundColorAttributeName : UIColor.black])
        NameInput.font = UIFont(name: "HelveticaNeue-UltraLight", size: 15)
        NameInput.borderStyle = UITextBorderStyle.bezel
        NameInput.autocorrectionType = UITextAutocorrectionType.no
        NameInput.keyboardType = UIKeyboardType.default
        NameInput.returnKeyType = UIReturnKeyType.continue
        NameInput.clearButtonMode = UITextFieldViewMode.whileEditing;
        NameInput.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        NameInput.delegate = self as UITextFieldDelegate
        NameInput.backgroundColor = .white
        self.view?.addSubview(NameInput)
        
        NumberInput.font = UIFont(name: "HelveticaNeue-UltraLight", size: 15)
        NumberInput.attributedPlaceholder = NSAttributedString(string: "Enter Age...", attributes: [NSForegroundColorAttributeName : UIColor.black])
        NumberInput.borderStyle = UITextBorderStyle.bezel
        NumberInput.autocorrectionType = UITextAutocorrectionType.no
        NumberInput.keyboardType = UIKeyboardType.numberPad
        NumberInput.returnKeyType = UIReturnKeyType.done
        NumberInput.clearButtonMode = UITextFieldViewMode.whileEditing;
        NumberInput.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        NumberInput.delegate = self as UITextFieldDelegate
        NumberInput.backgroundColor = .white
        self.view?.addSubview(NumberInput)
        
        ContinueButtonNode = self.childNode(withName: "ContinueNode") as! SKSpriteNode
        ContinueButtonNode.texture = SKTexture(imageNamed: "ContinueButton")
        ContinueButtonNode.color = .clear
        
        AgePicker.delegate = self
        AgePicker.dataSource = self
        NumberInput.inputView = AgePicker
        
        toolbar.barStyle = UIBarStyle.blackTranslucent
        toolbar.tintColor = UIColor.blue
        toolbar.setItems([doneButton], animated: true)
        NumberInput.inputAccessoryView = toolbar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return Database.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Database[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Database[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch(component){
        case 0:
            month = Database[component][pickerView.selectedRow(inComponent: 0)]
        case 1:
            day = Database[component][pickerView.selectedRow(inComponent: 1)]
        case 2:
            year = Database[component][pickerView.selectedRow(inComponent: 2)]
        default: break
        }

        NumberInput.text = month + " " + day + ", " + year
        setBirthday(month: month, day: day, year: year)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField: NameInput, moveDistace: -50, up: true)
        moveTextField(textField: NumberInput, moveDistace: -50, up: true)
        if(textField == NumberInput){
            NumberInput.text = month + " " + day + ", " + year
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField: NameInput, moveDistace: -50, up: false)
        moveTextField(textField: NumberInput, moveDistace: -50, up: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == NameInput){
            NumberInput.becomeFirstResponder()
            setName(name: NameInput.text!)
        }
        else{
            NumberInput.resignFirstResponder()
            AgePicker.resignFirstResponder()
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
        NumberInput.resignFirstResponder()
        self.view?.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "ContinueNode" {
                NameInput.isHidden = true
                NumberInput.isHidden = true
                let transition = SKTransition.crossFade(withDuration: 0.05)
                let gameScene = StartScene(fileNamed: "LoadingScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!, transition: transition)
            }
        }
    }
}
