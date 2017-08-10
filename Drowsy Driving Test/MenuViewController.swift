//
//  TestViewController.swift
//  Drowsy Driving Test
//
//  Created by Tannay Chandhok on 7/17/17.
//  Copyright © 2017 NoLo. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
import Charts

class MenuViewController: UIViewController {
    
    //let gameViewController = GameViewController()

  //  override func viewDidLoad() {
//        super.viewDidLoad()
      //  self.view = SKView()
        //gameViewController.viewControllerScene(scene: "MenuScene", viewController: self)


   // override func didReceiveMemoryWarning() {
   //     super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
   // }


    @IBOutlet weak var lineChartView: LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let populationData :[Int : Double] = [
            1990 : 123456.0,
            2000 : 233456.0,
            2010 : 343456.0
        ]
        
        let ySeries = populationData.map { x, y in
            return ChartDataEntry(x: Double(x), y: y)
        }
        
        let data = LineChartData()
        let dataset = LineChartDataSet(values: ySeries, label: "Hello")
        dataset.colors = [NSUIColor.red]
        data.addDataSet(dataset)
        
        self.lineChartView.data = data
        
        self.lineChartView.gridBackgroundColor = NSUIColor.white
        self.lineChartView.xAxis.drawGridLinesEnabled = false;
        self.lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        self.lineChartView.chartDescription?.text = "LineChartView Example"
        
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        self.lineChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    }

}

