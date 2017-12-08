//
//  BorderButton.swift
//  app-swoosh
//
//  Created by Wendy Faulkner on 11/27/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class BorderButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.white.cgColor
        
    }
    
}
