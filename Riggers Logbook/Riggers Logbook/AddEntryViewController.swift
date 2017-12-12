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

class AddEntryViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet var customerName: UITextField!
    
    @IBOutlet var datePicker: UIDatePicker!
    

    @IBOutlet var address: UITextField!
    
    @IBOutlet var containerMfg: UITextField!
    
    @IBOutlet var containerType: UITextField!
    
    @IBOutlet var containerMfgDate: UITextField!
    
    @IBOutlet var containerSerial: UITextField!
    
    @IBOutlet var reserveMfg: UITextField!
    
    @IBOutlet var reserveType: UITextField!
    
    @IBOutlet var reserveSize: UITextField!
    
    @IBOutlet var reserveSerial: UITextField!
    
    @IBOutlet var reserveMfgDate: UITextField!
    
    @IBOutlet var aadSerial: UITextField!
    
    @IBOutlet var aadMfg: UITextField!
    
    @IBOutlet var aadType: UITextField!
    
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
        print("is nil", entry!.name)
        if entry != nil {
            customerName.text = entry?.name!
            aadMfgDate.text = entry!.aadDate
            datePicker.date =  entry!.date! as Date
            aadMfg.text = entry!.aadMfg
            aadSerial.text = entry!.aadSerial
            aadType.text = entry!.aadType
            containerMfg.text = entry!.containerMfg
            containerType.text = entry!.containerType
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
            containerSerial.text = ""
            containerMfgDate.text = ""
            reserveType.text = ""
            reserveMfgDate.text = ""
            reserveSerial.text = ""
            reserveMfg.text = ""
            reserveSize.text = ""
            comments.text = ""
            
            addUpdateButton.setTitle("Update", for: .normal)
            deleteButton.isHidden = true
        }
        // Do any additional setup after loading the view.
        datePicker.addTarget(self, action: #selector(getDateAndTime), for: .valueChanged)
         self.getDateAndTime()
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
