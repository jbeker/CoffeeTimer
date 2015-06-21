//
//  TimerListTableViewController.swift
//  CoffeeTimer
//
//  Created by Jeremy Beker on 5/27/15.
//  Copyright (c) 2015 Picosphere. All rights reserved.
//

import UIKit

class TimerListTableViewController: UITableViewController, TimerEditViewControllerDelegate {
    var coffeeTimers: [TimerModel]!
    var teaTimers: [TimerModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coffeeTimers = [
            TimerModel(name: "Colombian", duration: 240, type: .Coffee ),
            TimerModel(name: "Mexican", duration: 200, type: .Coffee)
        ]
        
        teaTimers = [
            TimerModel(name: "Green Tea", duration: 400, type: .Tea),
            TimerModel(name: "Oolong", duration: 400, type: .Tea),
            TimerModel(name: "Rooibos", duration: 480, type: .Tea)
        ]
        
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if presentedViewController != nil {
            tableView.reloadData()
        }
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UITableViewCell {
            let indexPath = tableView.indexPathForCell(cell)!
            let timerModel: TimerModel = {
                if indexPath.section == 0 {
                    return self.coffeeTimers[indexPath.row]
                } else {
                    return self.teaTimers[indexPath.row]
                }
            }()
        
            if segue.identifier == "pushDetail" {
                if let detailViewController = segue.destinationViewController as? TimerDetailViewController {
                    detailViewController.timerModel = timerModel
                }
            } else if segue.identifier == "editDetail" {
                if let navigationController = segue.destinationViewController as? UINavigationController,
                    editViewController = navigationController.topViewController as? TimerEditViewController {
                        editViewController.timerModel = timerModel
                        editViewController.delegate = self
                }
            }
        } else if let addButton = sender as? UIBarButtonItem {
            if segue.identifier == "newTimer" {
            if let navigationController = segue.destinationViewController as? UINavigationController,
                editViewController = navigationController.topViewController as? TimerEditViewController {
                    editViewController.creatingNewTimer = true
                    editViewController.delegate = self
                    editViewController.timerModel = TimerModel(name: "", duration: 240, type: .Coffee)
                }
            }
        }
    }


    override func shouldPerformSegueWithIdentifier(identifier: String?,sender: AnyObject?) -> Bool {
        if identifier == "pushDetail" {
            if tableView.editing {
                return false
            }
        }
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView.editing {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
            performSegueWithIdentifier("editDetail", sender: cell)
        }
    }
    
    func timerEditViewControllerDidCancel(viewController: TimerEditViewController) {
        
    }
    
    func timerEditViewControllerDidSave(viewController: TimerEditViewController) {
        let model = viewController.timerModel
        let type = model.type
        if type == .Coffee {
            if !contains(coffeeTimers, model) {
                coffeeTimers.append(model)
            }
            teaTimers = teaTimers.filter({
                (item) -> Bool in
                return item != model
            })
        } else { // Type must be .Tea
            if !contains(teaTimers, model) {
                teaTimers.append(model)
            }
        
            coffeeTimers = coffeeTimers.filter({
                (item) -> Bool in
                return item != model
            }) }
        }
    

}
