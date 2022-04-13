//
//  DCUIFTextFeild.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 23/05/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit

public class DCUIFTextFeild: UITextField {
    
    
    @IBInspectable var insetX: CGFloat = 6 {
        didSet {
            layoutIfNeeded()
        }
    }
    @IBInspectable var insetY: CGFloat = 6 {
        didSet {
            layoutIfNeeded()
        }
    }
    
    // placeholder position
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    // text position
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
}

public class DCUIFBinableTextField: DCUIFTextFeild {
    //MARK: Observer
    var textChanged :(String) -> () = { _ in }
    public func bind(callback :@escaping (String) -> ()) {
        self.textChanged = callback
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc public func textFieldDidChange(_ textField :UITextField) {
        self.textChanged(textField.text!)
    }
}
