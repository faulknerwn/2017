//
//  ViewController.swift
//  RiggersLogbook
//
//  Created by Wendy Faulkner on 11/10/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    
   var rigData = ["Aerodyne", "Altico", "Butler", "Fliteline", "Infinity", "Mirage", "National", "Parachute Labs", "Para-Phenalia", "Rigging Innovations", "Strong", "Sunpath", "Sunrise Rigging", "Stunts", "UPT"]
    
    var aadData = ["Argus", "Cypres 2", "Mars","Vigil", "Vigil 2"]
    
    var parachuteData = ["Aerodyne" : ["Smart"], "Icarus" : ["Nano"], "Parachute Labs" : ["AngelFire"], "Paraflite" : ["Swift", "Swift Plus"], "PD" : ["PD", "Optimum"]]
    
  
    
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
    
    
}

