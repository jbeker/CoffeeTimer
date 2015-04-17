//
//  ViewController.swift
//  CoffeeTimer
//
//  Created by Jeremy Beker on 4/17/15.
//  Copyright (c) 2015 Picosphere. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var progress: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("viewDidLoad")
        view.backgroundColor = UIColor.orangeColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonWasPressed(sender: AnyObject) {
        println("buttonWasPressed",sender)
        let date = NSDate()
        
        label.text = "Button was pressed at \(date)"
    }

    @IBAction func sliderValueChanged(sender: AnyObject) {
        self.progress.progress = self.slider.value
    }
}

