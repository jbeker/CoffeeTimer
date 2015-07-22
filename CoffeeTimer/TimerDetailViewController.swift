//
//  TimerDetailViewController.swift
//  CoffeeTimer
//
//  Created by Jeremy Beker on 5/13/15.
//  Copyright (c) 2015 Picosphere. All rights reserved.
//

import UIKit

class TimerDetailViewController: UIViewController {

    var timerModel: TimerModel!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var timerStartStopButton: UIButton!
    
    var timer: NSTimer?
    var notification: UILocalNotification?
    var timeRemaining: NSInteger {
        if let fireDate = notification?.fireDate {
        let now = NSDate()
        let timeInterval = fireDate.timeIntervalSinceDate(now)
        let roundedTimeInterval = round(timeInterval)
        return NSInteger(roundedTimeInterval)
    } else {
        return 0
        }
    }
    
    
    enum StopTimerReason {
        case Cancelled
        case Completed
        func message() -> String {
        switch self {
            case .Cancelled:
                return "Timer Cancelled."
            case .Completed:
                return "Timer Completed."
        }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // Request local notifications and set up local notification
        let settings = UIUserNotificationSettings(forTypes: ([.Alert, .Sound]),
        categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = timerModel.name
        
        durationLabel.text = "\(timerModel.duration / 60) min \(timerModel.duration % 60) sec"
        
        countDownLabel.text = "Timer not started"
        
        timerModel.addObserver(self, forKeyPath: "duration", options: .New, context: nil)
        timerModel.addObserver(self, forKeyPath: "name", options: .New, context: nil)
        
    }
    
    deinit {
        timerModel.removeObserver(self, forKeyPath: "duration")
        timerModel.removeObserver(self, forKeyPath: "name")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "duration" {
            durationLabel.text = "\(timerModel.duration / 60) min \(timerModel.duration % 60) sec"
        } else if keyPath == "name" {
            title = timerModel.name
        }
    }
    

    @IBAction func startStopPressed(sender: AnyObject) {
        if let _ = self.timer {
            self.stopTimer(.Cancelled)
        } else {
            self.startTimer()
        }
    }
    
    func startTimer() {
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.rightBarButtonItem?.enabled = false
        timerStartStopButton.setTitle("Stop", forState: .Normal)
        timer = NSTimer.scheduledTimerWithTimeInterval(1,
            target: self,
            selector: "timerFired",
            userInfo: nil,
            repeats: true)
        
        // Set up local notification
        let localNotification = UILocalNotification()
        localNotification.alertBody = "Timer Completed!"
        localNotification.fireDate =
            NSDate().dateByAddingTimeInterval(
            NSTimeInterval(timerModel.duration)
        )
        
        localNotification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        notification = localNotification
        countDownLabel.text = String(format: "%d:%02d",timeRemaining / 60, timeRemaining % 60)
    }
    
    func stopTimer(reason: StopTimerReason) {
        if let _ = self.timer {
            // stop timer
            self.navigationItem.setHidesBackButton(false, animated: true)
            navigationItem.rightBarButtonItem?.enabled = true
            self.countDownLabel.text = reason.message()
            self.timerStartStopButton.setTitle("Start", forState: .Normal)
            
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            
            self.timer = nil
        }
    }
    
    func timerFired() {
        if timeRemaining > 0 {
            self.countDownLabel.text = String(format: "%d:%02d", self.timeRemaining / 60, timeRemaining % 60)
        } else {
            self.stopTimer(.Completed)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editDetail" {
        let navigationController = segue.destinationViewController
        as! UINavigationController
        let editViewController = navigationController.topViewController
        as! TimerEditViewController
        editViewController.timerModel = timerModel
        }
    }

}
