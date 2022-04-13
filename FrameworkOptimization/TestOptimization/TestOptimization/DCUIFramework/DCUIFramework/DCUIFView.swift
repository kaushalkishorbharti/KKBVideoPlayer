//
//  DCUIFView.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 23/05/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit
//import SwiftyToolTip
//import JDFTooltips

enum borderSide:String{
    
    case left = "Left"
    case right = "Right"
    case top = "Top"
    case bottom = "Bottom"
    case none = "none"
    
    static func parse(type:String) -> borderSide {
        switch type {
        case "Left":return .left
        case "Right":return .right
        case "Top":return .top
        case "Bottom":return .bottom
        default: return .none
        }
    }
}




public class DCUIFView: UIView {
    
    @IBInspectable var roundRadius:Float = 0
    
    
    private static let TOOLTIP_HIDING_TIME:Double = 3.0
    private static let TOOLTIP_ShOW_TIME:Double = 2.0
    
    
    
    
    @IBInspectable var isBorder:Bool = false {
        
        
        didSet {
            commonInit();
        }
    }
     /*
    public static func getTooltipDirection(isDirectionBottom:Bool)->JDFTooltipViewArrowDirection{
        
        if(isDirectionBottom == true){
            return JDFTooltipViewArrowDirection.down
        }
        else{
            return JDFTooltipViewArrowDirection.up
        }
        
    }
    
    public static func showToolTipOnTabBar(tabBarController:UITabBarController,index: Int,message:String) {
        
        let view = tabBarController.tabBar.items?[index]
        
        let tooltip:JDFTooltipView = JDFTooltipView.init(targetView: view?.view, hostView: DCUIFViewController.getTopViewController().view, tooltipText: message, arrowDirection: .down, width: 200.0)
        tooltip.show()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
            tooltip.hide(animated: false)
        }
        return
        
     
    }
    public static var currentToolTipView:JDFTooltipView? = nil
    
    public static func showToolTipOnView(view:UIView,message:String,isDirectionBottom:Bool = true) {
        
        let tooltip:JDFTooltipView = JDFTooltipView.init(targetView: view, hostView: DCUIFViewController.getTopViewController().view, tooltipText: message, arrowDirection: getTooltipDirection(isDirectionBottom:isDirectionBottom), width: 200.0)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + TOOLTIP_ShOW_TIME) {
            tooltip.show()
            currentToolTipView = tooltip
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + TOOLTIP_HIDING_TIME) {
                tooltip.hide(animated: false)
            }
        }
        
        

        return;
        
    
        
    }
    
    public static func showToolTip(view:UIView,message:String) {
        let tipView = EasyTipView(text: message)
        tipView.show(forView: view)
    }
    
    public  static func removeToolTipFromView(view:UIView) {
      //  view.removeToolTip()
    }
    
    
    
    static func findSubviewWithName(view:UIView,name:String) -> Any?{
        
        
        var allSubviews: [UIView] {
            return view.subviews.reduce([UIView]()) { $0 + [$1] + $1.allSubviews }
        }
        
        
        // Get the subviews of the view
        let subviews = view.subviews
        
        // Return if there are no subviews
        if subviews.count == 0 {
            return nil;
        }
        
        for subview : AnyObject in subviews{
            
            // Do what you want to do with the subview
            if(subview.description.contains(name)){
                return subview;
            }
            
            //print(subview.self);
            
            // List the subviews of subview
            findSubviewWithName(view: subview as! UIView, name: name)
        }
        return nil;
    }
    
    public static func setLeftBorderWithCALayer(_ width: CGFloat, withBorderColor color: CGColor?)
    {
        let border = CALayer()
        border.backgroundColor = color
        // border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        // self.layer.addSublayer(border)
        
    }
    
    public static func setRightBorderWithCALayer(_ width: CGFloat, withBorderColor color: CGColor?)
    {
        let border = CALayer()
        border.backgroundColor = color
        
        //border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        //self.layer.addSublayer(border)
    }
    
    public static func setTopBorderWithCALayer(_ width: CGFloat, withBorderColor color: CGColor?)
    {
        let border = CALayer()
        border.backgroundColor = color
        
        //border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        // self.layer.addSublayer(border)
    }
    
    public static func setBottomBorderWithCALayer(_ width: CGFloat, withBorderColor color: CGColor?)
    {
        let border = CALayer()
        border.backgroundColor = color
        
        // border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        // self.layer.addSublayer(border)
    }
    
    public static func dropShadow(view:UIView,color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1,cornorRadius: CGFloat = 0) {
        
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOffset = offSet
        view.layer.shadowOpacity = opacity
        view.layer.shadowRadius = radius
        view.layer.masksToBounds = false
        view.layer.cornerRadius = cornorRadius
        
    }
    */
    func commonInit(){
        
        if(isBorder){
            self.layer.masksToBounds = true;
            
            self.layer.cornerRadius=CGFloat(self.roundRadius);
            self.layer.borderWidth = 1.0;
            // self.layer.borderColor = DCUIFTheme.sharedInstance.appTheme?.borderSecondry.cgColor;
            self.layer.borderColor = DCUIFColor.Seperator.getColor().cgColor
        }
        else{
            self.layer.borderWidth = 0.0;
            
        }
    }
   /*
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit();
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    override public func awakeFromNib() {
        super.awakeFromNib();
        commonInit();
    }
    
    
    public func addDashedBorder(color:UIColor){
        
        let yourViewBorder = CAShapeLayer()
        yourViewBorder.strokeColor = color.cgColor;
        yourViewBorder.lineDashPattern = [2, 2]
        yourViewBorder.frame = self.bounds
        yourViewBorder.fillColor = nil
        yourViewBorder.path = UIBezierPath(rect: self.bounds).cgPath
        self.layer.addSublayer(yourViewBorder)
    }
    */
}
extension UIView {
    
    public func removeAllSubviews(){
        
        for view in self.subviews{
            view.removeFromSuperview();
        }
        
    }
    
}
extension UIView {
    var allSubviews: [UIView] {
        return self.subviews.reduce([UIView]()) { $0 + [$1] + $1.allSubviews }
    }
    
  public func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 1.0, width: CGFloat = 0.0, height: CGFloat = 1.0) {
    switch location {
    case .bottom:
      addShadow(offset: CGSize(width: width, height: height), color: color, opacity: opacity, radius: radius)
    case .top:
      addShadow(offset: CGSize(width: width, height: -height), color: color, opacity: opacity, radius: radius)
    }
  }
  
  public func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 1.0) {
    self.layer.masksToBounds = false
    self.layer.shadowColor = color.cgColor
    self.layer.shadowOffset = offset
    self.layer.shadowOpacity = opacity
    self.layer.shadowRadius = radius
  }
  
  public func addShadowForCommentBox(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 1.0, width: CGFloat = 0.0, height: CGFloat = 1.0) {
//    self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//    self.layer.shadowRadius = 4
//    self.layer.shadowOffset = CGSize(width: 0.0, height: -4.0)
//    self.layer.shadowOpacity = 0.5
//    self.layer.shadowColor = DCUIFColor.PrimaryBlack.getColor().cgColor
//    self.clipsToBounds = false
//
//    let shadowSize: CGFloat = 4
//    let height = self.frame.size.height
//    let width = self.frame.size.width
//    let contactRect = CGRect(x: -shadowSize, y: height, width: width + shadowSize * 2, height: shadowSize)
//    self.layer.shadowPath = UIBezierPath(rect: contactRect).cgPath
    
    
    let shadowSize : CGFloat = height

    let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                               y: -shadowSize / 2,
                                               width: self.frame.size.width * 2,
                                               height: self.frame.size.height + shadowSize))
    self.layer.masksToBounds = false
    self.layer.shadowColor = color.cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.layer.shadowOpacity = opacity
    self.layer.shadowPath = shadowPath.cgPath
    
  }
  
}

public enum VerticalLocation: String {
  case bottom
  case top
}
