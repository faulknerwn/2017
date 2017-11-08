//
//  InterfaceController.swift
//  Time Tracker WatchKit Extension
//
//  Created by Wendy Faulkner on 10/19/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    var clockedIn = false
    
    var timer:  Timer? = nil
    
    @IBOutlet var topLabel: WKInterfaceLabel!
    @IBOutlet var middleLabel: WKInterfaceLabel!
    @IBOutlet var button: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
       
    }
    
    override func willActivate() {
        if UserDefaults.standard.value(forKey: "clockedIn") != nil {
            
            if timer == nil {
                startUpTimer()
            }
            
            clockedIn = true
            updateUI(clockedIn: true)
            
        } else {
            clockedIn = false
            updateUI(clockedIn: false)
            
        }
    }
    
    func updateUI(clockedIn:Bool) {
        if clockedIn {
            // The UI for when someone is clocked in
            topLabel.setHidden(false)
            topLabel.setText("Today\n\(totalTimeWorkedAsString())")
            middleLabel.setText("0s")
            button.setTitle("Clock-Out")
            button.setBackgroundColor(UIColor.red)
        }
        else {
            // they are clocked out
            topLabel.setHidden(true)
            middleLabel.setText("Today\n\(totalTimeWorkedAsString())")
            button.setTitle("Clock-In")
            button.setBackgroundColor(UIColor.green)
        }
    }
    
    
    @IBAction func clockInOutTapped() {
        
        if clockedIn {
            clockOut()
        } else {
            clockIn()
            
        }
        updateUI(clockedIn: clockedIn)
       
    }
    
    func clockIn() {
        clockedIn = true
        
        UserDefaults.standard.set(Date(), forKey: "clockedIn")
        UserDefaults.standard.synchronize()
        
       startUpTimer()
        
    }
    
    func startUpTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if let clockedInDate = UserDefaults.standard.value(forKey: "clockedIn") as? Date {
                let timeInterval = Int(Date().timeIntervalSince(clockedInDate))
                
                let hours = timeInterval / 3600
                let minutes = (timeInterval % 3600) / 60
                let seconds = (timeInterval % 60)
                
                var currentClockedInString = ""
                
                if hours != 0 {
                    
                    currentClockedInString += "\(hours)h "
                }
                
                if minutes != 0 || hours != 0 {
                    currentClockedInString += "\(minutes)m "
                }
                currentClockedInString += " \(seconds)s"
                self.middleLabel.setText("\(currentClockedInString)")
                
                
                self.topLabel.setText("Today: \(self.totalTimeWorkedAsString())")
            }
        }
    }
    
    func clockOut() {
        
        clockedIn = false
        timer?.invalidate()
        timer = nil
        
        if let clockedInDate = UserDefaults.standard.value(forKey: "clockedIn") as? Date {
            // adding the clockin time to the clockins array
            if var clockIns = UserDefaults.standard.array(forKey: "clockIns") as? [Date] {
                clockIns.insert(clockedInDate, at: 0)
                UserDefaults.standard.set(clockIns, forKey: "clockIns")
                print(clockIns)
            } else {
                UserDefaults.standard.set([clockedInDate], forKey: "clockIns")
            }
            // adding the clockin time to the clockouts array
            if var clockOuts = UserDefaults.standard.array(forKey: "clockOuts") as? [Date] {
                clockOuts.insert(Date(), at: 0)
                UserDefaults.standard.set(clockOuts, forKey: "clockOuts")
                print(clockOuts)
            } else {
                UserDefaults.standard.set([Date()], forKey: "clockOuts")
            }
            UserDefaults.standard.set(nil, forKey: "clockedIn")
        }
        UserDefaults.standard.synchronize()
        
    }
    
    func totalClockedTime() -> Int {
        if var clockIns = UserDefaults.standard.array(forKey: "clockIns") as? [Date] {
            
            if var clockOuts = UserDefaults.standard.array(forKey: "clockOuts") as? [Date] {
                var seconds = 0
                for index in 0..<clockIns.count {
                    // find the seocnds between clock in and out
                    let currentSeconds = Int(clockOuts[index].timeIntervalSince(clockIns[index]))
                    
                    //add time to seconds
                    seconds += currentSeconds
                }
                
                return seconds
            }
            
            
        }
        return 0
    }
    
    func totalTimeWorkedAsString() -> String {
        
        var currentClockedInSeconds = 0
        
        if let clockedInDate = UserDefaults.standard.value(forKey: "clockedIn") as? Date {
            currentClockedInSeconds = Int(Date().timeIntervalSince(clockedInDate))
        }
        
        let totalTimeInterval = currentClockedInSeconds  + self.totalClockedTime()
        let totalHours = totalTimeInterval / 3600
        let totalMinutes = (totalTimeInterval % 3600) / 60
        
        return "\(totalHours)h \(totalMinutes)m"
    }
    
    @IBAction func historyTapped() {
        pushController(withName: "timeTableController", context: nil)
    }
    
    
    @IBAction func resetAllTapped() {
        UserDefaults.standard.set(nil, forKey: "clockedIn")
        UserDefaults.standard.set(nil, forKey: "clockIns")
        UserDefaults.standard.set(nil, forKey: "clockOuts")
        updateUI(clockedIn: false)
        UserDefaults.standard.synchronize()
    }
}
