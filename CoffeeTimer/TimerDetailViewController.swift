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
    override func viewDidLoad() {
        super.viewDidLoad()

        title = timerModel.name
        
        durationLabel.text = "\(timerModel.duration / 60) min \(timerModel.duration % 60) sec"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
