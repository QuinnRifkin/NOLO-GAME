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
    
    var goHomeLabelNode : SKLabelNode!
    
    let nameLabel = UILabel(frame: CGRect(x: 6, y: -15, width: 150, height: 100))
    
    var homeButtonNode : SKSpriteNode!
    
    var resetButtonNode : SKSpriteNode!
    
    var nameInput : UITextField!
    var numberInput : UITextField!
    let agePicker = UIPickerView()
    
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    let toolbarName = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    
    var database = [
        ["January","February","March","April","May","June","July","August","September","October","November","December"],
        ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"],
        ["2017","2016","2015","2014","2013","2012","2011","2010","2009","2008","2007","2006","2005","2004","2003","2002","2001","2000","1999","1998","1997","1996","1995","1994","1993","1992","1991","1990","1989","1988","1987","1986","1985","1984","1983","1982","1981","1980","1979","1978","1977","1976","1975","1974","1973","1972","1971","1970","1969","1968","1967","1966","1965","1964","1963","1962","1961","1960","1959","1958","1957","1956","1955","1954","1953","1952","1951","1950","1949","1948","1947","1946","1945","1944","1943","1942","1941","1940","1939","1938","1937","1936","1935","1934","1933","1932","1931","1930","1929","1928","1927","1926","1925","1924","1923","1922","1921","1920","1919","1918","1917","1916","1915","1914","1913","1912","1911","1910","1909","1908","1907","1906","1905","1904","1903","1902","1901","1900"]
    ]
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
        
        nameInput = UITextField(frame: CGRect(x: self.frame.width/12, y: self.frame.height/8, width: self.frame.width/3, height: 30))
        numberInput = UITextField(frame: CGRect(x: self.frame.width/12, y: self.frame.height/6, width: self.frame.width/3, height: 30))
        
        homeButtonNode = self.childNode(withName: "HomeNodeImage") as! SKSpriteNode
        //homeButtonNode.texture = SKTexture(imageNamed: "HomeIcon")
        homeButtonNode.color = .clear
        
        resetButtonNode = self.childNode(withName: "ResetNode") as! SKSpriteNode
        goHomeLabelNode = self.childNode(withName: "GoHomeLabel") as! SKLabelNode
        
        let name = String(welcomeScene.getName())
        if(name!.characters.count >= 25)
        {
            nameLabel.font = UIFont(name: "HelveticaNeue", size: 10)
        } else if(name!.characters.count >= 20){
            nameLabel.font = UIFont(name: "HelveticaNeue", size: 12)
        } else if(name!.characters.count >= 15){
            nameLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        } else if(name!.characters.count >= 10){
            nameLabel.font = UIFont(name: "HelveticaNeue", size: 16)
        } else {
            nameLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        }
        
        nameLabel.attributedText = NSAttributedString(string: name!, attributes: [NSForegroundColorAttributeName : UIColor.white])
        nameLabel.textAlignment = NSTextAlignment.left

        self.view?.addSubview(nameLabel)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(SettingsScene.donePressed(sender:)))
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(SettingsScene.cancelPressed(sender:)))
        
        let cancelNameButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(SettingsScene.cancelNamePressed(sender:)))
        
        nameInput.attributedPlaceholder = NSAttributedString(string: welcomeScene.getName(), attributes: [NSForegroundColorAttributeName : UIColor.black])
        nameInput.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        nameInput.borderStyle = UITextBorderStyle.roundedRect
        nameInput.autocorrectionType = UITextAutocorrectionType.no
        nameInput.keyboardType = UIKeyboardType.default
        nameInput.returnKeyType = UIReturnKeyType.done
        nameInput.clearButtonMode = UITextFieldViewMode.whileEditing;
        nameInput.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        nameInput.delegate = self as UITextFieldDelegate
        nameInput.backgroundColor = .white
        
        numberInput.font = UIFont(name: "HelveticaNeue-Light", size: 15)
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
        
        toolbar.barStyle = UIBarStyle.blackTranslucent
        toolbar.tintColor = UIColor.blue
        toolbar.setItems([cancelButton, flexButton, doneButton], animated: true)
        numberInput.inputAccessoryView = toolbar
        
        toolbarName.barStyle = UIBarStyle.blackTranslucent
        toolbarName.tintColor = UIColor.blue
        toolbarName.setItems([cancelNameButton], animated: true)
        nameInput.inputAccessoryView = toolbarName

        
        
        let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.view?.addSubview(self.nameInput)
            self.view?.addSubview(self.numberInput)
        }
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
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == nameInput){
            nameInput.text = welcomeScene.getName()

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
                nameLabel.font = UIFont(name: "HelveticaNeue", size: 10)
            } else if(nameInput.text!.characters.count >= 20){
                nameLabel.font = UIFont(name: "HelveticaNeue", size: 12)
            } else if(nameInput.text!.characters.count >= 15){
                nameLabel.font = UIFont(name: "HelveticaNeue", size: 14)
            } else if(nameInput.text!.characters.count >= 10){
                nameLabel.font = UIFont(name: "HelveticaNeue", size: 16)
            } else {
                nameLabel.font = UIFont(name: "HelveticaNeue", size: 18)
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
        setBirthday(month: month, day: day, year: year)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let highScore = gameScene.getHighScore()
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "HomeNode" {
                goHomeLabelNode.fontColor = UIColor.lightGray
                let when = DispatchTime.now() + 0.1 // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.goHomeLabelNode.fontColor = UIColor.white
                }
                let transition = SKTransition.push(with: SKTransitionDirection.right, duration: 0.5)
                let gameScene = MenuScene(fileNamed: "MenuScene")
                gameScene?.scaleMode = .aspectFill
                let when2 = DispatchTime.now() + 0.15 // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when2) {
                    self.nameLabel.isHidden = true
                    self.nameInput.isHidden = true
                    self.numberInput.isHidden = true
                    self.view?.presentScene(gameScene!, transition: transition)
                }
            }
            
            if nodesArray.first?.name == "ResetNode" {
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
        }
    }
}
