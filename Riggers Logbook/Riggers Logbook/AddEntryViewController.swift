//
//  AddEntryViewController.swift
//  Riggers Logbook
//
//  Created by Wendy Faulkner on 12/4/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import DLRadioButton
import CoreData
import SearchTextField

class AddEntryViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {

   
    @IBOutlet var customerName: SearchTextField!
    
    @IBOutlet var datePicker: UIDatePicker!
    

    @IBOutlet var address: UITextField!
    
    
    @IBOutlet var containerMfg: SearchTextField!
    
    
    @IBOutlet var containerType: SearchTextField!
    
    @IBOutlet var containerMfgDate: UITextField!
    
    @IBOutlet var containerExtra: UITextField!
    
    @IBOutlet var containerSerial: UITextField!
    
    @IBOutlet var reserveMfg: SearchTextField!
    
    
    @IBOutlet var reserveType: SearchTextField!
    
    
    @IBOutlet var reserveSize: UITextField!
    
    @IBOutlet var reserveSerial: UITextField!
    
    @IBOutlet var reserveMfgDate: UITextField!
    
    @IBOutlet var aadSerial: UITextField!
    
    
    @IBOutlet var aadMfg: SearchTextField!
    
    
    @IBOutlet var aadType: SearchTextField!
    
    @IBOutlet var comments: UITextField!
    
    @IBOutlet var aadMfgDate: UITextField!
    
    @IBOutlet var aAndP: DLRadioButton!
    @IBOutlet var iANdR: DLRadioButton!
    
    var entryDate = Date()
    
    var requestIdentifier: String = ""
    
    @IBAction func iAndRClicked(_ sender: Any) {
       if iANdR.isSelected {
                iAndRIsClicked = 1
        
            }
        else {
            iAndRIsClicked = 0
        
        }
       
    }
    
    @IBAction func aAndPClicked(_ sender: Any) {
        if aAndP.isSelected {
        aAndPIsClicked = 1
            
        } else {
            iAndRIsClicked = 0
            
        }
    }
    
    var iAndRIsClicked : Int16 = 0
    var aAndPIsClicked : Int16 = 0
    
    
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        datePicker.datePickerMode = .date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        
    }
    
    @objc func getDateAndTime() {
        
        // declare format of date we want to see
        let dateFormatter = DateFormatter()
        
        // DateFormatter.dateFormat(fromTemplate: "YYYY-MM-dd", options: 0, locale: nil)
        
        // convert date from datePicker.date to String type
        
        dateFormatter.dateFormat = "MMM dd yyyy"
        
        entryDate = datePicker.date
        
    }
    
    @IBOutlet var deleteButton: UIButton!
    @IBAction func deletePushed(_ sender: Any) {
        
        // get entry name
        requestIdentifier = (entry?.name)!
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context  = appDelegate.persistentContainer.viewContext
        
        
        context.delete(entry!)
        
        appDelegate.saveContext()
        
        performSegue(withIdentifier: "cancelSegue", sender: nil)
        
    }
    
    @IBOutlet var addUpdateButton: UIButton!
    
    @IBAction func addUpdatePushed(_ sender: Any) {
    
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context  = appDelegate.persistentContainer.viewContext
        
        if entry != nil { // Update entry
            if customerName.text != "" {
                
                entry?.name = customerName.text
                entry?.date = entryDate
                entry?.address = address.text
                entry?.containerMfg = containerMfg.text
                entry?.containerType = containerType.text
                entry?.containerExtra = containerExtra.text
                entry?.containerSerial = containerSerial.text
                entry?.containerDate = containerMfgDate.text
                entry?.reserveMfg = reserveMfg.text
                entry?.reserveDate = reserveMfgDate.text
                entry?.reserveSize = reserveSize.text
                entry?.reserveSerial = reserveSerial.text
                entry?.reserveType = containerType.text
                entry?.aadMfg = aadMfg.text
                entry?.aadDate = aadMfgDate.text
                entry?.aadSerial = aadSerial.text
                entry?.aadType = aadType.text
                entry?.comments = comments.text
                entry?.aAndP = aAndPIsClicked
                entry?.iAndR = iAndRIsClicked
            
                appDelegate.saveContext()
            
                performSegue(withIdentifier: "cancelSegue", sender: nil)
                
            }
            else {
                // make alert here need title
                let alert = UIAlertController(title: "Alert", message: "Customer Name is Required", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        } else {  // Add New Entry
            
            if customerName.text != "" {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let entry = Entry(context: context)
                entry.date = entryDate 
                entry.name = customerName.text
                entry.address = address.text
                entry.containerMfg = containerMfg.text
                entry.containerType = containerType.text
                entry.containerSerial = containerSerial.text
                entry.containerExtra = containerExtra.text
                entry.containerDate = containerMfgDate.text
                entry.reserveMfg = reserveMfg.text
                entry.reserveDate = reserveMfgDate.text
                entry.reserveSize = reserveSize.text
                entry.reserveSerial = reserveSerial.text
                entry.reserveType = containerType.text
                entry.aadMfg = aadMfg.text
                entry.aadDate = aadMfgDate.text
                entry.aadSerial = aadSerial.text
                entry.aadType = aadType.text
                entry.comments = comments.text
                entry.aAndP = aAndPIsClicked
                entry.iAndR = iAndRIsClicked
               
                appDelegate.saveContext()
                performSegue(withIdentifier: "cancelSegue", sender: nil)
                
            }
            else {
                // make alert here need title
                let alert = UIAlertController(title: "Alert", message: "Must provide Customer Name", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    var entry: Entry? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If rig exists Change Button to Update and add Delete Button
        self.iANdR.isMultipleSelectionEnabled = true
        self.aAndP.isMultipleSelectionEnabled = true
        
        if entry != nil {
            customerName.text = entry?.name!
            aadMfgDate.text = entry!.aadDate
            datePicker.date =  entry!.date! as Date
            aadMfg.text = entry!.aadMfg
            aadSerial.text = entry!.aadSerial
            aadType.text = entry!.aadType
            containerMfg.text = entry!.containerMfg
            containerType.text = entry!.containerType
            containerExtra.text = entry!.containerExtra
            containerSerial.text = entry!.containerSerial
            containerMfgDate.text = entry!.containerDate
            reserveType.text = entry!.reserveType
            reserveMfgDate.text = entry!.reserveDate
            reserveSerial.text = entry!.reserveSerial
            reserveMfg.text = entry!.reserveMfg
            reserveSize.text = entry!.reserveSize
            comments.text = entry!.comments
            
            
            if  entry!.aAndP == 1 {
                aAndP.isSelected = true
                aAndP.sendActions(for: .touchDown)
                aAndPIsClicked = 1
            } else {
                aAndP.isSelected = false
                aAndP.sendActions(for: .touchUpInside)
                aAndPIsClicked = 0
            }
            if entry!.iAndR == 1 {
                iANdR.isSelected = true
                iANdR.sendActions(for: .touchDown)
                iAndRIsClicked = 1
            }
            else {
                iANdR.isSelected = false
                iANdR.sendActions(for: .touchUpInside)
                iAndRIsClicked = 0
            }
            
            
            addUpdateButton.setTitle("Update", for: .normal)
            deleteButton.isHidden = false
            
        } else {
            let today = Date()
            customerName.text = ""
            aadMfgDate.text = ""
            datePicker.date =  today as Date
            aadMfg.text = ""
            aadSerial.text = ""
            aadType.text = ""
            containerMfg.text = ""
            containerType.text = ""
            containerExtra.text = ""
            containerSerial.text = ""
            containerMfgDate.text = ""
            reserveType.text = ""
            reserveMfgDate.text = ""
            reserveSerial.text = ""
            reserveMfg.text = ""
            reserveSize.text = ""
            comments.text = ""
            aAndPIsClicked = 0
            iAndRIsClicked = 0
            iANdR.isSelected = false
            iANdR.sendActions(for: .touchUpInside)
            aAndP.isSelected = false
            aAndP.sendActions(for: .touchUpInside)
            
            addUpdateButton.setTitle("Add", for: .normal)
            deleteButton.isHidden = true
        }
        // Do any additional setup after loading the view.
        datePicker.addTarget(self, action: #selector(getDateAndTime), for: .valueChanged)
         self.getDateAndTime()
        
        containerMfg.filterStrings(["Aerodyne", "AeroSports USA", "Altico", "Basik Air Concept", "Butler",   "Firebird", "Fliteline", "Flying High Manufacturing",  "Mirage Sys", "National", "North American Aerodynamics", "Parachutes de France", "Parachute Labs", "Paratec", "Para Avis",  "Parachute Systems", "Para-Phenalia", "Peregrine", "Plexus", "Precision", "Rigging Innovations", "Sife", "SWS", "Strong", "Sunpath", "Sunrise Rigging", "Stunts",  "Thomas Sports Equipment", "UPT", "Velocity Skydiving Equipment"])
        containerMfg.comparisonOptions = [.caseInsensitive]
        containerMfg.maxNumberOfResults = 10
        containerType.filterStrings(["Advance", "Atom", "Beast", "Centaurus",  "C-Flex", "Classic Pro", "Dolphin", "Dual Hawk", "Eclipse", "Evo", "Fire", "Flexon", "Genera", "Glide", "Icon", "Infinity", "Javelin", "Micron", "Mirage", "Next", "Next Tandem", "Omega", "P-124 Aviator", "Para-Cushion", "Plexus Tandem", "Power Racer", "Quasar", "Racer", "Reflex", "RT", "RTS", "SafetyPro", "Satchel", "Shadow Racer", "Sidewinder", "Sigma", "Softie", "Spirit", "Talon",  "TearDrop", "Telesis", "T-Flex", "TNT", "TP-5", "Triton", "Vector I", "Vector II", "Vector III", "Viper", "Voodoo", "Voodoo Curv", "Vortex", "Wings", "Zerox"  ])
        containerType.comparisonOptions = [.caseInsensitive]
        containerType.maxNumberOfResults = 10
        reserveMfg.filterStrings(["Aerodyne", "APS", "Basik Air Concept", "Django", "Firebird", "Flight Concepts", "FTS", "Glidepath", "Icarus Canopies", "North American Aerodynamics", "Parachute Labs", "Parachute Systems", "Parachutes de France", "Paraflite", "Paratec", "Performance Designs", "Pisa", "Precision"       ])
        reserveMfg.comparisonOptions = [.caseInsensitive]
        reserveMfg.maxNumberOfResults = 10
        reserveType.filterStrings(["Angelfire", "Cricket", "Dash-M", "Dash-MZ", "Decelerator", "Eagle", "Firelite", "Fury", "IC Reserve", "Laser", "Lo-Po Reserve", "Master", "Maverick", "MicroRaven", "Mini Cricket", "Minimax", "Nano", "Optimum", "PDR", "Quick 400", "R-Max", "Raven", "Rush", "Sharpchuter", "Smart", "Speed 2000", "Stellar", "Super Raven", "Swift Plus", "Swift", "Techno",  "Tempo",  "X-Fast" ])
        reserveType.comparisonOptions = [.caseInsensitive]
        reserveType.maxNumberOfResults = 10
        aadMfg.filterStrings(["AAD", "Airtec", "Aviacom", "FXC", "Mars"])
        aadMfg.comparisonOptions = [.caseInsensitive]
        aadMfg.maxNumberOfResults = 10
        aadType.filterStrings(["Argus", "Cypres", "Cypres 2", "FXC 12000", "M2", "Vigil", "Vigil 2"])
        aadType.comparisonOptions = [.caseInsensitive]
        aadType.maxNumberOfResults = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
