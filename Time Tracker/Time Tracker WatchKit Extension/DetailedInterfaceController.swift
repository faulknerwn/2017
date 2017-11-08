//
//  DetailedInterfaceController.swift
//  Time Tracker WatchKit Extension
//
//  Created by Wendy Faulkner on 10/28/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import WatchKit
import Foundation


class DetailedInterfaceController: WKInterfaceController {

    @IBOutlet var clockInLabel: WKInterfaceLabel!
    
    @IBOutlet var clockOutLabel: WKInterfaceLabel!
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
       if  let dates = context as? [Date] {
            let clockIn = dates[0]
        let clockOut = dates[1]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d h:mma"
        clockInLabel.setText(formatter.string(from: clockIn))
            clockOutLabel.setText(formatter.string(from: clockOut))
        }
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
