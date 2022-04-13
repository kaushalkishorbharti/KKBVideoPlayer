//
//  DCUIFPlaceHolderTextView.swift
//  DCUIFramework
//
//  Created by Abhinav Agarwal on 1/19/18.
//  Copyright © 2018 Abhinav Agarwal. All rights reserved.
//

import UIKit

public class DCUIFPlaceHolderTextView: KMPlaceholderTextView {
    
    
    public override func awakeFromNib() {
        super.awakeFromNib();
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        self.layer.borderWidth = 0.5
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = 5.0
    }

}
