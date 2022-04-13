//
//  DCUIGradientView.swift
//  DCUIFramework
//
//  Created by kaushal kishor on 13/05/20.
//  Copyright © 2020 Abhinav Agarwal. All rights reserved.
//

import UIKit

@IBDesignable public class DCUIGradientView: UIView {
  
  
  private var gradientLayer: CAGradientLayer!
  
  @IBInspectable public var topColor: UIColor = .red {
    didSet {
      setNeedsLayout()
    }
  }
  
  @IBInspectable public var bottomColor: UIColor = .yellow {
    didSet {
      setNeedsLayout()
    }
  }
  
  @IBInspectable public var shadowColor: UIColor = .clear {
    didSet {
      setNeedsLayout()
    }
  }
  
  @IBInspectable public var shadowX: CGFloat = 0 {
    didSet {
      setNeedsLayout()
    }
  }
  
  @IBInspectable public var shadowY: CGFloat = -3 {
    didSet {
      setNeedsLayout()
    }
  }
  
  @IBInspectable public var shadowBlur: CGFloat = 3 {
    didSet {
      setNeedsLayout()
    }
  }
  
  @IBInspectable public var startPointX: CGFloat = 0 {
    didSet {
      setNeedsLayout()
    }
  }
  
  @IBInspectable public var startPointY: CGFloat = 0.5 {
    didSet {
      setNeedsLayout()
    }
  }
  
  @IBInspectable public var endPointX: CGFloat = 1 {
    didSet {
      setNeedsLayout()
    }
  }
  
  @IBInspectable public var endPointY: CGFloat = 0.5 {
    didSet {
      setNeedsLayout()
    }
  }
  
  @IBInspectable public var cornerRadius: CGFloat = 0 {
    didSet {
      setNeedsLayout()
    }
  }
  
  override public class var layerClass: AnyClass {
    return CAGradientLayer.self
  }
  
  override public func layoutSubviews() {
    self.gradientLayer = self.layer as? CAGradientLayer
    self.gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    self.gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
    self.gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
    self.layer.cornerRadius = cornerRadius
    self.layer.shadowColor = shadowColor.cgColor
    self.layer.shadowOffset = CGSize(width: shadowX, height: shadowY)
    self.layer.shadowRadius = shadowBlur
    self.layer.shadowOpacity = 1
    
  }
  
  public func animate(duration: TimeInterval, newTopColor: UIColor, newBottomColor: UIColor) {
    let fromColors = self.gradientLayer?.colors
    let toColors: [AnyObject] = [ newTopColor.cgColor, newBottomColor.cgColor]
    self.gradientLayer?.colors = toColors
    let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
    animation.fromValue = fromColors
    animation.toValue = toColors
    animation.duration = duration
    animation.isRemovedOnCompletion = true
    animation.fillMode = kCAFillModeForwards
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    self.gradientLayer?.add(animation, forKey:"animateGradient")

  }
}


