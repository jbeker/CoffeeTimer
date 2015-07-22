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
    
    enum TableSection: Int {
        case Coffee = 0
        case Tea
        case NumberOfSections
    }
    
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
        return TableSection.NumberOfSections.rawValue

    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == TableSection.Coffee.rawValue {
            return coffeeTimers.count
        } else if section == TableSection.Tea.rawValue {
            return teaTimers.count
        } else {
            return 0
        }

    }
    override func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        
        let timerModel = timerModelFromIndexPath(indexPath)
        // Configure the cell...
        cell.textLabel?.text = timerModel.name
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == TableSection.Coffee.rawValue {
            return "Coffee"
        } else {
            return "Tea"
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UITableViewCell {
            let indexPath = tableView.indexPathForCell(cell)!
            let timerModel = timerModelFromIndexPath(indexPath)
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
        } else if let _ = sender as? UIBarButtonItem {
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


    override func shouldPerformSegueWithIdentifier(identifier: String,sender: AnyObject?) -> Bool {
        if identifier == "pushDetail" {
            if tableView.editing {
                return false
            }
        }
        return true
    }
    
    // MARK: Tableview delegate functions
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView.editing {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
            performSegueWithIdentifier("editDetail", sender: cell)
        }
    }
    
    override func tableView(tableView: UITableView, shouldShowMenuForRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        if action == "copy:" {
            return true
        }
        return false
    }
    
    override func tableView(tableView: UITableView, performAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
            let timerModel = timerModelFromIndexPath(indexPath)
            let pasteboard = UIPasteboard.generalPasteboard()
            pasteboard.string = timerModel.name
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the data from the array.
            if indexPath.section == TableSection.Coffee.rawValue {
                coffeeTimers.removeAtIndex(indexPath.row)
            } else { // Must be 1
                teaTimers.removeAtIndex(indexPath.row)
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        if sourceIndexPath.section == TableSection.Coffee.rawValue {
                coffeeTimers.moveFrom(sourceIndexPath.row, toDestination: destinationIndexPath.row)
            } else { // Must be 1
                teaTimers.moveFrom(sourceIndexPath.row, toDestination: destinationIndexPath.row)
        }
    }
    
    override func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        // If the source and destination index paths are the same section,
        // then return the proposed index path
        if sourceIndexPath.section == proposedDestinationIndexPath.section {
            return proposedDestinationIndexPath
        }
        // The sections are different, which we want to disallow.
        if sourceIndexPath.section == TableSection.Coffee.rawValue {
            // This is coming from the coffee section, so return
            // the last index path in that section.
            return NSIndexPath(forItem: coffeeTimers.count - 1, inSection: TableSection.Coffee.rawValue)
        } else { // Must be 1
            // This is coming from the tea section, so return
            // the first index path in that section.
            return NSIndexPath(forItem: 0, inSection: TableSection.Tea.rawValue)
        }
    }
    
    
    // MARK: Delegate Functions
    
    func timerEditViewControllerDidCancel(viewController: TimerEditViewController) {
        
    }
    
    func timerEditViewControllerDidSave(viewController: TimerEditViewController) {
        let model = viewController.timerModel
        let type = model.type
        if type == .Coffee {
            if !coffeeTimers.contains(model) {
                coffeeTimers.append(model)
            }
            teaTimers = teaTimers.filter({
                (item) -> Bool in
                return item != model
            })
        } else { // Type must be .Tea
            if !teaTimers.contains(model) {
                teaTimers.append(model)
            }
        
            coffeeTimers = coffeeTimers.filter({
                (item) -> Bool in
                return item != model
            }) }
        }
    
    // MARK: Utility functions
    
    private func timerModelFromIndexPath(indexPath: NSIndexPath) -> TimerModel {
                if indexPath.section == TableSection.Coffee.rawValue {
                return coffeeTimers[indexPath.row]
            } else {
                return teaTimers[indexPath.row]
                }
    }

}
