//
//  DCUIFButton.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 30/06/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit

public class DCUIFButton: UIButton {

    @objc public enum SelectionType:Int {
        case Selected
        case NotSelected
        case Custom
    }
    @IBInspectable public var styleSelection:Bool = false
    var type:SelectionType = .NotSelected
    @IBInspectable public var selectionType:SelectionType {
        get {
            return self.type
        }
        set( selectedType) {
            self.type = selectedType
        }
    }
    
   // @IBInspectable public var styleFilled:Bool = true;
    //@IBInspectable public var isSecondryStyle:Bool = false;
   // @IBInspectable public var isDisableStyle:Bool = false;
    @IBInspectable public var roundRadius:Float = 0
    @IBInspectable public var isBorder:Bool = false;
    
    var isDisabled:Bool = false
    
    @IBInspectable public var isDisableStyle:Bool {
        get {
            return self.isDisabled
        }
        set( isDisableStyle) {
            self.isDisabled = isDisableStyle
            commonInit()
        }
    }
  
    var isSecondry:Bool = false
    
    @IBInspectable public var isSecondryStyle:Bool {
        get {
            return self.isSecondry
        }
        set( isSecondryStyle) {
            self.isSecondry = isSecondryStyle
            commonInit();
        }
    }

    var isFilled:Bool = false
    
    @IBInspectable public var styleFilled:Bool {
        get {
            return self.isFilled
        }
        set( styleFilled) {
            self.isFilled = styleFilled
            commonInit()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        if(DCUIFTheme.sharedInstance.appTheme == nil){
            
        }
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
    
    /*
    func commonInit(){
        
        if(styleFilled){
            
            
            if(isSecondryStyle){
                
                self.backgroundColor = UIColor.init(red: 156/255, green: 8/255, blue: 8/255, alpha: 1)
                  //  DCUIFTheme.sharedInstance.appTheme?.buttonPriamryColor;
                
              
                
            }
            else if(isDisableStyle){
                self.backgroundColor = DCUIFTheme.sharedInstance.appTheme?.extraColor_4;
            }
            else{
                self.backgroundColor = DCUIFTheme.sharedInstance.appTheme?.buttonPriamryColor;
            }
          
            
            self .setTitleColor(UIColor.white, for: UIControlState.normal);
      
        }
        else{
            self.backgroundColor = UIColor.clear;
            self.tintColor = DCUIFTheme.sharedInstance.appTheme?.buttonPriamryColor;
            self .setTitleColor(DCUIFTheme.sharedInstance.appTheme?.buttonPriamryColor, for: UIControlState.normal);
        }
        if(isBorder){
        self.layer.masksToBounds = true;
        self.layer.cornerRadius=CGFloat(self.roundRadius);
        self.layer.borderWidth = 1.0;
        self.layer.borderColor=DCUIFTheme.sharedInstance.appTheme?.buttonPriamryColor.cgColor;
        }
        
        
    }*/

    
    func commonInit(){
        
        if (styleSelection)
        {
            
        }else{
            
        if(styleFilled){
            
            if(isSecondryStyle){
                //self.backgroundColor = UIColor.init(red: 156/255, green: 8/255, blue: 8/255, alpha: 1)
                self.backgroundColor = DCUIFTheme.sharedInstance.appTheme?.colorSecondary
            }
            else if(isDisableStyle){
                self.backgroundColor = DCUIFTheme.sharedInstance.appTheme?.colorGrey50;
                
            }
            else{
                self.backgroundColor = DCUIFTheme.sharedInstance.appTheme?.colorPrimary;
            }
            
            self .setTitleColor(UIColor.white, for: UIControlState.normal);
        }
        else{
            self.backgroundColor = UIColor.clear;
            
            if(isSecondryStyle){
                self.tintColor = DCUIFTheme.sharedInstance.appTheme?.colorSecondary;
                self .setTitleColor(DCUIFTheme.sharedInstance.appTheme?.colorSecondary, for: UIControlState.normal);
            }
            else if(isDisableStyle){
                self.backgroundColor = DCUIFTheme.sharedInstance.appTheme?.colorGrey50;
                self.setTitleColor(UIColor.white, for: UIControlState.normal);

            }
            else{
                self.tintColor = DCUIFTheme.sharedInstance.appTheme?.colorPrimary;
                self .setTitleColor(DCUIFTheme.sharedInstance.appTheme?.colorPrimary, for: UIControlState.normal);
            }
        }
        
        if(isBorder){
            self.layer.masksToBounds = true;
            self.layer.cornerRadius=CGFloat(self.roundRadius);
            self.layer.borderWidth = 1.0;
            self.layer.borderColor = DCUIFTheme.sharedInstance.appTheme?.colorGrey25.cgColor;
            
            if(styleFilled){
                if(isSecondryStyle){
                    self.layer.borderColor=DCUIFTheme.sharedInstance.appTheme?.colorSecondary.cgColor;
                }else{
                  self.layer.borderColor=DCUIFTheme.sharedInstance.appTheme?.colorPrimary.cgColor;
                }
            }else{
              self.layer.borderColor=DCUIFTheme.sharedInstance.appTheme?.colorGrey25.cgColor;
            }
            //self.layer.borderColor=DCUIFTheme.sharedInstance.appTheme?.colorPrimary.cgColor;
        }
        }
    }
 
    /*
    func commonInit(){
        
        if (styleSelection)
        {
            
        }else{
            
            if(isFilled){
                
                if(isSecondry){
                    
                    self.backgroundColor = DCUIFTheme.sharedInstance.appTheme?.colorSecondary
                }
                else if(isDisabled){
                    self.backgroundColor = DCUIFTheme.sharedInstance.appTheme?.colorGrey50;
                    
                }
                else{
                    self.backgroundColor = DCUIFTheme.sharedInstance.appTheme?.colorPrimary;
                }
                
                self .setTitleColor(UIColor.white, for: UIControlState.normal);
            }
            else{
                self.backgroundColor = UIColor.clear;
                
                if(isSecondry){
                    self.tintColor = DCUIFTheme.sharedInstance.appTheme?.colorSecondary;
                    self .setTitleColor(DCUIFTheme.sharedInstance.appTheme?.colorSecondary, for: UIControlState.normal);
                }
                else if(isDisabled){
                    self.backgroundColor = DCUIFTheme.sharedInstance.appTheme?.colorGrey50;
                    self.setTitleColor(UIColor.white, for: UIControlState.normal);
                    
                }
                else{
                    self.tintColor = DCUIFTheme.sharedInstance.appTheme?.colorPrimary;
                    self .setTitleColor(DCUIFTheme.sharedInstance.appTheme?.colorPrimary, for: UIControlState.normal);
                }
            }
            
            if(isBorder){
                self.layer.masksToBounds = true;
                self.layer.cornerRadius=CGFloat(self.roundRadius);
                self.layer.borderWidth = 1.0;
                self.layer.borderColor = DCUIFTheme.sharedInstance.appTheme?.colorGrey25.cgColor;
                
                if(isFilled){
                    if(isSecondry){
                        self.layer.borderColor=DCUIFTheme.sharedInstance.appTheme?.colorSecondary.cgColor;
                    }else{
                        self.layer.borderColor=DCUIFTheme.sharedInstance.appTheme?.colorPrimary.cgColor;
                    }
                } else {
                    self.layer.borderColor=DCUIFTheme.sharedInstance.appTheme?.colorGrey25.cgColor;
                }
            }
        }
    }*/
}



public class DCUIFThemeButton: UIButton {
    
    public var style = DCUIFButtonStyle() {
        didSet {
            self.updateButton()
        }
    }
    public var fontStyle = DCUIFStyle() {
        didSet {
            self.updateButton()
        }
    }
    public var bgColor = DCUIFColor() {
        didSet {
            self.updateButton()
        }
    }
    public var titleColor = DCUIFColor() {
        didSet {
            self.updateButton()
        }
    }
    
    @IBInspectable public var buttonStylIB : Int = DCUIFButtonStyle.Opaque.rawValue {
        didSet {
            self.style = DCUIFButtonStyle.init(value: self.buttonStylIB)
        }
    }
    
    @IBInspectable public var buttonSizeType: Int = DCUIFStyle.MainHeadingBold.rawValue {
        didSet {
            self.fontStyle = DCUIFStyle.init(value: self.buttonSizeType)
        }
    }
    
    @IBInspectable public var bGColorIB: Int = DCUIFColor.PrimaryRed.rawValue {
        didSet {
            self.bgColor = DCUIFColor(value: self.bGColorIB)
        }
    }
    
    @IBInspectable public var titleTextColor: Int = DCUIFColor.PrimaryRed.rawValue {
        didSet {
            self.titleColor = DCUIFColor(value: self.titleTextColor)
        }
    }
    
   // public var haltBtnAction: Bool? {
   //     didSet {
//            self.isEnabled = false
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
//               self.isEnabled = true
//            })
  //      }
  //  }

//    public override var isTouchInside: Bool {
//       // haltBtnAction = true
//       // return self.isTouchInside
//    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
           // self.isEnabled = true
        })
        super.touchesBegan(touches, with: event)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func updateButton() {
        self.titleLabel?.font = self.fontStyle.getFont().font
        self.setBorderWith(self.style.getBorderWidth(), self.fontStyle.getFont().cornerRadius, self.style.getBorderColor())
        self.setTitleColor(self.titleColor.getColor(), for: UIControlState())
        switch self.style {
        case .Disable:
            self.isUserInteractionEnabled = false
            self.backgroundColor = DCUIFColor.SuperLightGrayMedium.getColor()
        default:
            self.isUserInteractionEnabled = true
            self.backgroundColor = self.bgColor.getColor()
        }
    }
    
    
    
    /*public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
             self.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                 self.isUserInteractionEnabled = true
            }
           
        }
    }*/
    
    
}

public enum DCUIFButtonStyle: Int {
    case Opaque = 0
    case TranparentWithBorder  = 1
    case TranparentWithOutBorder  = 2
    case Disable = 3
    case RoundedDropDown = 4
    
    public init() {
        self = .Opaque
    }
    
    public init(value: Int) {
        var result: DCUIFButtonStyle = DCUIFButtonStyle()
        switch value {
        case DCUIFButtonStyle.Opaque.rawValue:
            result = .Opaque
        case DCUIFButtonStyle.TranparentWithBorder.rawValue:
            result = .TranparentWithBorder
        case DCUIFButtonStyle.TranparentWithOutBorder.rawValue:
            result = .TranparentWithOutBorder
        case DCUIFButtonStyle.Disable.rawValue:
            result = .Disable
        case DCUIFButtonStyle.RoundedDropDown.rawValue:
            result = .RoundedDropDown
        default:
            result = .Opaque
        }
        self = result
    }
    
    func getBorderColor() -> UIColor {
        switch self {
        case .Opaque, .Disable, .TranparentWithOutBorder:
            return UIColor.clear
        case .TranparentWithBorder, .RoundedDropDown:
            //return UIColor.gray
            return DCUIFColor.SuperLightGrayMedium.getColor()
        }
    }
    
    func getBorderWidth() -> CGFloat {
        switch self {
        case .Opaque, .TranparentWithOutBorder, .Disable:
            return 0
        case .TranparentWithBorder, .RoundedDropDown:
            return 1
        }
    }
}
