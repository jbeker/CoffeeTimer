//
//  ViewController.swift
//  CoffeeTimer
//
//  Created by Jeremy Beker on 4/17/15.
//  Copyright (c) 2015 Picosphere. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timerModel: TimerModel! {
        willSet(newModel) {
            println("About to change model to \(newModel)")
        }
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("viewDidLoad")
        title = "Root"
        setupModels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    func setupModels() {
        self.timerModel = TimerModel(name: "Columbian", duration: 240)
    }
    
    func updateUI() {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("Preparing for segue with identifier:\(segue.identifier)")
        
        
        if segue.identifier == "pushDetail" {
            let dest = segue.destinationViewController as? TimerDetailViewController
            
            if (dest != nil) {
                dest?.timerModel = timerModel
            } else {
                println("WTH?!")
            }
        } else if segue.identifier == "editDetail" {
            let destNav = segue.destinationViewController as? UINavigationController
            let dest = destNav?.topViewController as? TimerEditViewController
            
            if (dest != nil) {
                dest?.timerModel = timerModel
            } else {
                println("WTH?!")
            }
        }
    }

}

