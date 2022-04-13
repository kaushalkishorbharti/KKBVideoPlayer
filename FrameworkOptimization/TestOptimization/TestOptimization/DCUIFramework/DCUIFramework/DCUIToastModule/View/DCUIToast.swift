//
//  DCMRToast.swift
//  Demo
//
//  Created by Tim Moose on 8/12/16.
//  Copyright © 2016 SwiftKick Mobile. All rights reserved.
//

import UIKit
import SwiftMessages

class DCUIToast: MessageView {
    @IBOutlet weak var leftImageView: DCUIFImageView!
    @IBOutlet weak var lbl: UILabel!
    
        
    func bindViewModel(message: String, image: String) {
        
        
        self.lbl.text = message
        self.leftImageView.image = UIImage.init(named: image, in: DCUIFramework.bundle, compatibleWith: nil)
    }
}
