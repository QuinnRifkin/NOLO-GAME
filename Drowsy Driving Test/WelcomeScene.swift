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
    
    var continueButtonNode: SKSpriteNode!
    
    var nameInput : UITextField!
    var numberInput : UITextField!
    var agePicker = UIPickerView()
    
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    
    var database = [
        ["January","February","March","April","May","June","July","August","September","October","November","December"],
        ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"],
        ["2017","2016","2015","2014","2013","2012","2011","2010","2009","2008","2007","2006","2005","2004","2003","2002","2001","2000","1999","1998","1997","1996","1995","1994","1993","1992","1991","1990","1989","1988","1987","1986","1985","1984","1983","1982","1981","1980","1979","1978","1977","1976","1975","1974","1973","1972","1971","1970","1969","1968","1967","1966","1965","1964","1963","1962","1961","1960","1959","1958","1957","1956","1955","1954","1953","1952","1951","1950","1949","1948","1947","1946","1945","1944","1943","1942","1941","1940","1939","1938","1937","1936","1935","1934","1933","1932","1931","1930","1929","1928","1927","1926","1925","1924","1923","1922","1921","1920","1919","1918","1917","1916","1915","1914","1913","1912","1911","1910","1909","1908","1907","1906","1905","1904","1903","1902","1901","1900"]
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

        agePicker.delegate = self
        agePicker.dataSource = self
        numberInput.inputView = agePicker
        
        toolbar.barStyle = UIBarStyle.blackTranslucent
        toolbar.tintColor = UIColor.blue
        toolbar.setItems([flexButton, doneButton], animated: true)
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
