//
//  BarGraph.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 8/11/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import UIKit

class BarGraph: UIView {
    
    let savedValues = UserDefaults.standard
    
    var sundayStart : Date!
    var sundayEnd : Date!
    var mondayStart : Date!
    var mondayEnd : Date!
    var tuesdayStart : Date!
    var tuesdayEnd : Date!
    var wednesdayStart : Date!
    var wednesdayEnd : Date!
    var thursdayStart : Date!
    var thursdayEnd : Date!
    var fridayStart : Date!
    var fridayEnd : Date!
    var saturdayStart : Date!
    var saturdayEnd : Date!

    var isAdult : Bool!
    
    let graph = UIView()
    let blur = UIView()
    
    let sunday = UIView()
    let monday = UIView()
    let tuesday = UIView()
    let wednesday = UIView()
    let thursday = UIView()
    let friday = UIView()
    let saturday = UIView()
    
    let target = UIView()
    
    let sun = UILabel()
    let mon = UILabel()
    let tues = UILabel()
    let wed = UILabel()
    let thurs = UILabel()
    let fri = UILabel()
    let sat = UILabel()
    
    var now = Date()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        graph.layer.cornerRadius = 5
        graph.bounds = CGRect(x: 0, y: 0, width: 300, height: 100)
        graph.center = CGPoint(x: 187.5 , y: 333.5  + 30)
        blur.layer.cornerRadius = 10
        blur.frame = CGRect(x: 150, y: 50, width: 300, height: 130)
        blur.center = CGPoint(x: 150, y: 60)
        blur.backgroundColor = .white
        blur.layer.opacity = 0.5
        self.addSubview(graph)
        self.graph.addSubview(blur)
        
        target.bounds = CGRect(x: 0, y: 0, width: 275, height: 1)
        target.center = CGPoint(x: 150, y: 52)
        target.backgroundColor = .black
        
        addLabel(label: sun, title: "S", xOffSet: -120)
        addLabel(label: mon, title: "M", xOffSet: -80)
        addLabel(label: tues, title: "T", xOffSet: -40)
        addLabel(label: wed, title: "W", xOffSet: 0)
        addLabel(label: thurs, title: "T", xOffSet: 40)
        addLabel(label: fri, title: "F", xOffSet: 80)
        addLabel(label: sat, title: "S", xOffSet: 120)
        
        self.graph.addSubview(sun)
        self.graph.addSubview(mon)
        self.graph.addSubview(tues)
        self.graph.addSubview(wed)
        self.graph.addSubview(thurs)
        self.graph.addSubview(fri)
        self.graph.addSubview(sat)
        
        now = Date()
        
        duration(start: sundayStart ?? now, end: sundayEnd ?? now, day: sunday, xposition: -120, dayName: "sunday")
        duration(start: mondayStart ?? now, end: mondayEnd ?? now, day: monday, xposition: -80, dayName: "monday")
        duration(start: tuesdayStart ?? now, end: tuesdayEnd ?? now, day: tuesday, xposition: -40, dayName: "tuesday")
        duration(start: wednesdayStart ?? now, end: wednesdayEnd ?? now, day: wednesday, xposition: 0, dayName: "wednesday")
        duration(start: thursdayStart ?? now, end: thursdayEnd ?? now, day: thursday, xposition: 40, dayName: "thursday")
        duration(start: fridayStart ?? now, end: fridayEnd ?? now, day: friday, xposition: 80, dayName: "friday")
        duration(start: saturdayStart ?? now, end: saturdayEnd ?? now, day: saturday, xposition: 120, dayName: "saturday")
        
        self.graph.addSubview(sunday)
        self.graph.addSubview(monday)
        self.graph.addSubview(tuesday)
        self.graph.addSubview(wednesday)
        self.graph.addSubview(thursday)
        self.graph.addSubview(friday)
        self.graph.addSubview(saturday)
        self.graph.addSubview(target)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func duration(start: Date, end: Date, day: UIView, xposition: CGFloat, dayName: String){
        var rawValue : Int!
        let time = Calendar.current.dateComponents([.hour, .minute, .weekday], from: start, to: end)
        let hours = time.hour
        let minutes = time.minute
        if(savedValues.value(forKey: dayName) != nil && savedValues.integer(forKey: dayName) >= 1 && (start == now || end == now)){
            rawValue = savedValues.integer(forKey: dayName)
        }else{
            rawValue = (((((hours)!*60) + (minutes)!)/8)*10)
            if(rawValue >= 800){
                rawValue = 800
            }
            savedValues.set(rawValue, forKey: dayName)
        }
        if(isAdult ?? false){
            if(rawValue >= 450){
                day.backgroundColor = .green
            }else{
                day.backgroundColor = .red
            }
        }else{
            if(rawValue >= 600){
                day.backgroundColor = .green
            }else{
                day.backgroundColor = .red
            }
        }
        day.layer.cornerRadius = 3
        day.bounds = CGRect(x: 0, y: 0, width: 30, height: ((rawValue)/10))
        day.center = CGPoint(x: (150 + (xposition)), y: (50 - ((day.frame.height)/2) + (44)))
    }
    
    func addLabel(label: UILabel, title: String, xOffSet: Int){
        label.text = title
        label.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        label.center = CGPoint(x: (150 + (xOffSet)), y: (110))
        label.textAlignment = .center
    }
    
    func reLoad(){
        self.sunday.removeFromSuperview()
        self.monday.removeFromSuperview()
        self.tuesday.removeFromSuperview()
        self.wednesday.removeFromSuperview()
        self.thursday.removeFromSuperview()
        self.friday.removeFromSuperview()
        self.saturday.removeFromSuperview()
        
        duration(start: sundayStart ?? now, end: sundayEnd ?? now, day: sunday, xposition: -120, dayName: "sunday")
        duration(start: mondayStart ?? now, end: mondayEnd ?? now, day: monday, xposition: -80, dayName: "monday")
        duration(start: tuesdayStart ?? now, end: tuesdayEnd ?? now, day: tuesday, xposition: -40, dayName: "tuesday")
        duration(start: wednesdayStart ?? now, end: wednesdayEnd ?? now, day: wednesday, xposition: 0, dayName: "wednesday")
        duration(start: thursdayStart ?? now, end: thursdayEnd ?? now, day: thursday, xposition: 40, dayName: "thursday")
        duration(start: fridayStart ?? now, end: fridayEnd ?? now, day: friday, xposition: 80, dayName: "friday")
        duration(start: saturdayStart ?? now, end: saturdayEnd ?? now, day: saturday, xposition: 120, dayName: "saturday")
        
        self.graph.addSubview(sunday)
        self.graph.addSubview(monday)
        self.graph.addSubview(tuesday)
        self.graph.addSubview(wednesday)
        self.graph.addSubview(thursday)
        self.graph.addSubview(friday)
        self.graph.addSubview(saturday)
        self.graph.addSubview(target)
    }
    
    func updateTarget(){
        if(isAdult){
            target.center = CGPoint(x: 150, y: 55)
        }else{
            target.center = CGPoint(x: 150, y: 35)
        }
        ageAdj(day: sunday, dayName: "sunday")
        ageAdj(day: monday, dayName: "monday")
        ageAdj(day: tuesday, dayName: "tuesday")
        ageAdj(day: wednesday, dayName: "wednesday")
        ageAdj(day: thursday, dayName: "thursday")
        ageAdj(day: friday, dayName: "friday")
        ageAdj(day: saturday, dayName: "saturday")
    }
    
    func ageAdj(day: UIView, dayName: String){
        if(isAdult ?? false){
            if(savedValues.integer(forKey: dayName) >= 450){
                day.backgroundColor = .green
            }else{
                day.backgroundColor = .red
            }
        }else{
            if(savedValues.integer(forKey: dayName) >= 600){
                day.backgroundColor = .green
            }else{
                day.backgroundColor = .red
            }
        }
    }
}
