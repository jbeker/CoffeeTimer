//
//  TimerListTableViewController.swift
//  CoffeeTimer
//
//  Created by Jeremy Beker on 5/27/15.
//  Copyright (c) 2015 Picosphere. All rights reserved.
//

import UIKit

class TimerListTableViewController: UITableViewController {
    var coffeeTimers: [TimerModel]!
    var teaTimers: [TimerModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coffeeTimers = [
            TimerModel(name: "Colombian", duration: 240),
            TimerModel(name: "Mexican", duration: 200)
        ]
        
        teaTimers = [
            TimerModel(name: "Green Tea", duration: 400),
            TimerModel(name: "Oolong", duration: 400),
            TimerModel(name: "Rooibos", duration: 480)
        ]
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2

    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return coffeeTimers.count
        } else if section == 1 {
            return teaTimers.count
        } else {
            return 0
        }

    }
    override func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let timerModel: TimerModel = {
            if indexPath.section == 0 {
                return self.coffeeTimers[indexPath.row]
            } else {
                return self.teaTimers[indexPath.row]
            }
        }()
        
        // Configure the cell...
        cell.textLabel?.text = timerModel.name
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Coffee"
        } else {
            return "Tea"
        }
    }
}
