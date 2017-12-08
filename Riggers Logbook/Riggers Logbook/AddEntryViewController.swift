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
    
    @IBOutlet var reserveMfg: UITextField!
    
    @IBOutlet var reserveType: UITextField!
    
    @IBOutlet var reserveSize: UITextField!
    
    @IBOutlet var reserveMfgDate: UITextField!
    
    @IBOutlet var aadMfg: UITextField!
    
    @IBOutlet var aadType: UIView!
    
    @IBOutlet var aadMfgDate: UITextField!
    
    @IBOutlet var iAndR: DLRadioButton!
    @IBOutlet var aAndP: DLRadioButton!
    
    @IBOutlet var comments: UITextField!
    
    
    @IBAction func addPushed(_ sender: Any) {
    }
    
   
    @IBOutlet var addEntry: UIButton!
    
    var entry: Entry? = nil
    
    @IBAction func datePickerAction(sender: AnyObject) {
        

        datePicker.datePickerMode = .date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let selectedDate = dateFormatter.string(from: datePicker.date)
       
        print(selectedDate)
        
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
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
