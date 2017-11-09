//
//  ViewController.swift
//  textFieldTests
//
//  Created by Wendy Faulkner on 11/8/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var testOne: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        testOne.delegate = self
        print(testOne)
        testOne.text = "now"
        
         /*DispatchQueue.main.sync(execute: {
            self.testOne.text = testOne
            
            })*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

