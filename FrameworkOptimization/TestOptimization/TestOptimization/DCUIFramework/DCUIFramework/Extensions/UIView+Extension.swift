//
//  UIView+Extension.swift
//  DCUIFramework
//
//  Created by Docquity on 11/12/18.
//  Copyright © 2018 Abhinav Agarwal. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    public func setShadow(_ shadowOpacity: Float = 0.5,
                          _ width: CGFloat = 1,
                          _ height: CGFloat = 1,
                          _ shadowRadius: CGFloat = 1,
                          _ shadowColor: UIColor = UIColor.black) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = shadowRadius
    }
    
    public func setShadowWith(ShadowOpacity shadowOpacity: Float = 0.5,
                              Width width: CGFloat = 1,
                              Height height: CGFloat = 1,
                              ShadowRadius shadowRadius: CGFloat = 1,
                              ShadowColor shadowColor: UIColor = UIColor.black) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = shadowRadius
    }
    
    public func setBorderWith(_ width: CGFloat = 1,
                       _ radius: CGFloat = 2,
                       _ color: UIColor = UIColor.lightGray) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
}

extension UIView {
    
    // OUTPUT 1
    public func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    public func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowColor = color.cgColor
      layer.shadowOpacity = opacity
      layer.shadowOffset = offSet
      layer.shadowRadius = radius
      self.clipsToBounds = false
      layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
     
    }
}
