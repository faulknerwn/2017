//
//  ViewController.swift
//  app-swoosh
//
//  Created by Wendy Faulkner on 11/27/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var bgImage: UIImageView!
    @IBOutlet var swoosh: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  swoosh.frame = CGRect(x: view.frame.size.width / 2  - swoosh.frame.size.width / 2, y: 50, width: swoosh.frame.size.width, height: swoosh.frame.size.height)
        
       // bgImage.frame = view.frame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

