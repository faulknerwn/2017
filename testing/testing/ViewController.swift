//
//  ViewController.swift
//  testing
//
//  Created by Wendy Faulkner on 11/24/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import SearchTextField



class ViewController: UIViewController {
   
       @IBOutlet var mySearchTextField: SearchTextField!
    
    //mySearchTextField.filterStrings(["Aerodyne", "Altico", "Butler", "Fliteline"])
    //"Infinity", "Mirage", "National", "Parachute Labs", "Para-Phenalia", "Rigging Innovations", "Strong", "Sunpath", "Sunrise Rigging", "Stunts", "UPT"])
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        mySearchTextField.filterStrings(["Aerodyne", "Altico", "Butler", "Fliteline", "Infinity", "Mirage", "National", "Parachute Labs", "Para-Phenalia", "Rigging Innovations", "Strong", "Sunpath", "Sunrise Rigging", "Stunts", "UPT"])
        //mySearchTextField.theme = SearchTextFieldTheme.darkTheme()
        mySearchTextField.comparisonOptions = [.caseInsensitive]
        mySearchTextField.maxNumberOfResults = 10
       // mySearchTextField.inlineMode = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

