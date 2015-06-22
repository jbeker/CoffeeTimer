//
//  TimerEditViewController.swift
//  CoffeeTimer
//
//  Created by Jeremy Beker on 5/15/15.
//  Copyright (c) 2015 Picosphere. All rights reserved.
//

import UIKit

@objc protocol TimerEditViewControllerDelegate {
    func timerEditViewControllerDidCancel(viewController: TimerEditViewController)
    func timerEditViewControllerDidSave(viewController: TimerEditViewController)
}

class TimerEditViewController: UIViewController {

    var timerModel: TimerModel!
    var creatingNewTimer = false
    var delegate: TimerEditViewControllerDelegate!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var minutesSlider: UISlider!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var secondsSlider: UISlider!
    @IBOutlet weak var typeSegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let numberOfMinutes = Int(timerModel.duration/60)
        let numberOfSeconds = Int(timerModel.duration%60)
        nameField.text = timerModel.name

        updateLabelsWithMinutes(numberOfMinutes, seconds: numberOfSeconds)
        minutesSlider.value = Float(numberOfMinutes)
        secondsSlider.value = Float(numberOfSeconds)
        
        switch timerModel.type {
        case .Coffee:
            typeSegmentControl.selectedSegmentIndex = 0
        case .Tea:
            typeSegmentControl.selectedSegmentIndex = 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        timerModel.name = nameField.text
        timerModel.duration = Int(minutesSlider.value)*60 + Int(secondsSlider.value)
        
        if typeSegmentControl.selectedSegmentIndex == 0 {
            timerModel.type = .Coffee
        } else { // Must be 1
            timerModel.type = .Tea
        }
        
        delegate?.timerEditViewControllerDidSave(self)
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)

    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        delegate?.timerEditViewControllerDidCancel(self)
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func sliderValueChanged(sender: AnyObject) {
        let numberOfMinutes = Int(minutesSlider.value)
        let numberOfSeconds = Int(secondsSlider.value)
        updateLabelsWithMinutes(numberOfMinutes, seconds: numberOfSeconds)
    }

    func updateLabelsWithMinutes(minutes: Int, seconds: Int) {
        func pluralize(value: Int, singular: String, plural: String) -> String {
            switch value {
                case 1:
                    return "1 \(singular)"
                case let pluralValue:
                    return "\(pluralValue) \(plural)"
            }
        }
            
        minutesLabel.text = pluralize(minutes, "minute", "minutes")
        secondsLabel.text = pluralize(seconds, "second", "seconds")
    }

}
