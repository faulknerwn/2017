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
                iAndRIsClicked = true
            }
        else {
            iAndRIsClicked = false
           
        }
       
    }
    
    @IBAction func aAndPClicked(_ sender: Any) {
        if aAndP.isSelected {
        aAndPIsClicked = true
        } else {
            iAndRIsClicked = false
        }
    }
    
    var iAndRIsClicked = false
    var aAndPIsClicked = false
    
    
    
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
        //self.iANdR.isMultipleSelectionEnabled = true
        //self.aAndP.isMultipleSelectionEnabled = true
        
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
            
            addUpdateButton.setTitle("Add", for: .normal)
            deleteButton.isHidden = true
        }
        // Do any additional setup after loading the view.
        datePicker.addTarget(self, action: #selector(getDateAndTime), for: .valueChanged)
         self.getDateAndTime()
        
        containerMfg.filterStrings(["Aerodyne", "AeroSports USA", "Altico", "Butler", "Fliteline", "Velocity Skydiving Equipment", "Mirage Sys", "National", "Parachute Labs", "Para-Phenalia", "Rigging Innovations", "Strong", "Sunpath", "Sunrise Rigging", "Stunts", "UPT", "Parachutes de France", "Thomas Sports Equipment", "Precision", "Basik Air Concept", "Firebird", "North American Aerodynamics", "Para Avis", "Parachute Systems", "Paratec", "Peregrine", "Plexus", "Sife", "SWS"])
        containerMfg.comparisonOptions = [.caseInsensitive]
        containerMfg.maxNumberOfResults = 10
        containerType.filterStrings(["Icon", "SafetyPro", "Dolphin", "Reflex", "Infinity", "Mirage", "Racer", "Softie", "Talon", "Flexon", "Voodoo", "Voodoo Curv", "Para-Cushion", "Dual Hawk", "TNT", "Quasar", "Javelin", "Wings", "Eclipse", "Vector I", "Vector II", "Vector III", "Atom", "TearDrop", "P-124 Aviator", "Advance", "Evo", "Omega", "Flying High Manufacturing", "C-Flex", "T-Flex", "Sidewinder", "Power Racer", "Shadow Racer", "RTS", "Centaurus", "Satchel", "Spirit", "TP-5", "Beast", "Vortex", "Next", "Glide", "Triton", "Plexus Tandem", "Classic Pro", "Genera", "Telesis", "RT", "Fire", "Next Tandem", "Zerox", "Viper", "Sigma", "Micron"])
        containerType.comparisonOptions = [.caseInsensitive]
        containerType.maxNumberOfResults = 10
        reserveMfg.filterStrings(["Aerodyne", "Parachute Labs", "Performance Designs", "Precision", "Icarus Canopies", "Glidepath", "Flight Concepts", "Django", "Pisa", "APS", "FTS", "Basik Air Concept", "Paraflite", "Firebird", "North American Aerodynamics", "Parachute Systems", "Parachutes de France", "Paratec" ])
        reserveMfg.comparisonOptions = [.caseInsensitive]
        reserveMfg.maxNumberOfResults = 10
        reserveType.filterStrings(["Nano", "IC Reserve", "PDR", "Optimum", "Angelfire", "Smart", "Tempo", "Laser", "Mini Cricket", "Cricket", "Firelite", "Maverick", "Fury", "Sharpchuter", "Raven", "Super Raven", "MicroRaven", "Dash-M", "Dash-MZ", "R-Max", "X-Fast", "Master", "Quick 400", "Rush", "Eagle", "Swift Plus", "Swift", "Decelerator", "Minimax", "Techno", "Speed 2000", "Stellar", "Lo-Po Reserve"])
        reserveType.comparisonOptions = [.caseInsensitive]
        reserveType.maxNumberOfResults = 10
        aadMfg.filterStrings(["AAD", "Airtec", "Aviacom", "FXC", "Mars"])
        aadMfg.comparisonOptions = [.caseInsensitive]
        aadMfg.maxNumberOfResults = 10
        aadType.filterStrings(["M2", "Vigil", "Vigil 2", "Cypres", "Cypres 2", "Argus", "FXC 12000"])
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
