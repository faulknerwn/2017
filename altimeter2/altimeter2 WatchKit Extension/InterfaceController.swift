//
//  InterfaceController.swift
//  altimeter2 WatchKit Extension
//
//  Created by Wendy Faulkner on 10/29/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion
//import UIKit

class InterfaceController: WKInterfaceController {

    @IBOutlet var altitude: WKInterfaceLabel!
    
    var altimeter = CMAltimeter() // load CMAltimeter
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
       
        startAltimeter()
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func startAltimeter() {
        
        print("Started relative altitude updates.")
        
        // Check if altimeter feature is available
        if (CMAltimeter.isRelativeAltitudeAvailable()) {
            
            //self.activityIndicator.startAnimating()
            
            // Start altimeter updates, add it to the main queue
            self.altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: { (altitudeData:CMAltitudeData?, error:Error?) in
                print("hello")
                if (error != nil) {
                    
                    // If there's an error, stop updating and alert the user
                    
                    print(error)
                    self.stopAltimeter()
                    
                    //let alertView = UIAlertView(title: "Error", message: error!.localizedDescription, delegate: nil, cancelButtonTitle: "OK")
                
                    //alertView.show()
                    
                } else {
                    
                    let altitude = altitudeData!.relativeAltitude.floatValue * 3.28 / 100   // Relative altitude in meters converted to feet
                    print(altitude)
                    
                    // Update labels, truncate float to two decimal points
                    self.altitude.setText(String(format: "%.02f", altitude))
                    
                    
                }
                
            })
            
        } else {
            print("bad")
            let h0 = { print("ok")}
            
            let action1 = WKAlertAction(title: "Ok", style: .default, handler:h0)
            //let action2 = WKAlertAction(title: "Decline", style: .destructive) {}
            //let action3 = WKAlertAction(title: "Cancel", style: .cancel) {}
            
            presentAlert(withTitle: "Error", message: "Barometer not available on this device.", preferredStyle: .actionSheet, actions: [action1])
            

            
           // printAlertControllerWithTitle("Error", message: "Barometer not available on this device.", preferredStyle: .ActionSheet,
            //alertView.show()
            
        }
        
    }
    
    func stopAltimeter() {
        
        // Reset labels
        self.altitude.setText("-")
        
        
        self.altimeter.stopRelativeAltitudeUpdates() // Stop updates
        
        //self.activityIndicator.stopAnimating() // Hide indicator
        
        print("Stopped relative altitude updates.")
        
    }
}
