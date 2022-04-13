//
//  DCUITextFieldWithUnderline.swift
//  DCUIFramework
//
//  Created by kaushal kishor on 04/01/19.
//  Copyright © 2019 Abhinav Agarwal. All rights reserved.
//

import UIKit

public protocol DCUITextFieldWithUnderlineDelegate {
    func textFeildValueChange(value:String)
    func textFeildViewEndEditing()
}

public enum DCUITextFieldWithUnderlineType: Int {
    case inactive = 0
    case active = 1
    case error = 2
    
    public init() {
        self = .inactive
    }
    public init(value: Int) {
        var result: DCUITextFieldWithUnderlineType = DCUITextFieldWithUnderlineType()
        switch value {
        case DCUITextFieldWithUnderlineType.inactive.rawValue:
            result = .inactive
        case DCUITextFieldWithUnderlineType.active.rawValue:
            result = .active
        case DCUITextFieldWithUnderlineType.error.rawValue:
            result = .error
        default:
            result = .inactive
        }
        self = result
    }
}

@IBDesignable

public class DCUITextFieldWithUnderline: UIView {

    @IBOutlet weak var lblTitle: DCUIFActiveThemeLabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var viewRoot: UIView!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var viewUnderline: UIView!
    @IBOutlet weak var btnAction: DCUIFThemeButton!
    
    public var isShowUnderline:Bool = true
    public var delegate:DCUITextFieldWithUnderlineDelegate?

    @IBInspectable public var value:String  {
        set{
            txtField.text = newValue
            configureData()
        }
        get{
            return txtField.text ?? ""
        }
    }
    
    @IBInspectable public var placeholder: String = "" {
        didSet {
            txtField.placeholder = placeholder
            configureData()
        }
    }
    
    @IBInspectable public var viewUnderlineBg: UIColor = UIColor.white {
        didSet {
            viewUnderline.backgroundColor = viewUnderlineBg
            configureData()
        }
    }
    
    @IBInspectable public var title: String = "" {
        didSet {
            lblTitle.text = title
            configureData()
        }
    }
    
    @IBInspectable public var isShowUnderLine: Bool = true {
        didSet {
            self.isShowUnderline = isShowUnderLine
            configureData()
        }
    }
    
    @IBInspectable public var btnTite: String = "" {
        didSet {
            btnAction.setTitle(btnTite, for: UIControlState())
            configureData()
        }
    }
    
    @IBInspectable public var isShowHideBtn: Bool = false {
        didSet {
            self.btnAction.isHidden = isShowHideBtn
            configureData()
        }
    }

    @IBInspectable public var txtFieldState: Int = 0 {
        didSet {
            configureData()
        }
    }
    /*
    0: default // Default type for the current input method.
    4: numberPad // A number pad with locale-appropriate digits (0-9, ۰-۹, ०-९, etc.). Suitable for PIN entry.
    5: phonePad // A phone pad (1-9, *, 0, #, with letters under the numbers).
    6: namePhonePad // A type optimized for entering a person's name or phone number.
    7: emailAddress // A type optimized for multiple email address entry (shows space @ . prominently).
    8: decimalPad // A number pad with a decimal point.
    */
    
    @IBInspectable public var keyboardType: Int = 0 {
        didSet {
            txtField.keyboardType = UIKeyboardType.init(rawValue: keyboardType)!
            configureData()
        }
    }
    
    @IBInspectable public var isSecureEntry: Bool = false {
        didSet {
            self.txtField.isSecureTextEntry = isSecureEntry
            self.toggleActionBtnTitle()
            self.configureData()
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    
    func commonInit() {
        let viewName = "DCUITextFieldWithUnderline";
        DCUIFramework.bundle.loadNibNamed(viewName,owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.txtField.delegate = self
        self.txtField.text = ""
        lblTitle.text = ""
        btnAction.setTitle("", for: UIControlState())
        viewUnderline.backgroundColor = UIColor.gray
        txtField.textColor = DCUIFColor.PrimaryBlack.getColor()
        txtField.font = UIFont.systemFont(ofSize: DCUIFFontSize.heading.getFontSize(), weight: DCUIFWeight.medium.getFontWeight())
        configureData()
    }
    
    private func configureData() {
        if let lblTitletextCount = lblTitle.text?.count {
            if lblTitletextCount > 0 {
                lblTitle.isHidden = false
            }else{
              lblTitle.isHidden = true
            }
        }else{
            lblTitle.isHidden = true
        }
        
        (self.isShowHideBtn == true) ? (self.btnAction.isHidden = false) : (self.btnAction.isHidden = true)
         (self.isShowUnderLine == true) ? (viewUnderline.isHidden = false) : (viewUnderline.isHidden = true)
        self.txtField.autocorrectionType = .no
         self.toggleActionBtnTitle()
         self.changeUnderlineColor()
    }
    
    private func toggleActionBtnTitle() {
        self.isSecureEntry ? btnAction.setTitle("Show", for: UIControlState()) : btnAction.setTitle("Hide", for: UIControlState())
    }
    
    private func changeUnderlineColor() {
        switch self.txtFieldState {
        case DCUITextFieldWithUnderlineType.inactive.rawValue:
             viewUnderline.backgroundColor = DCUIFColor.MediumGray.getColor()
        case DCUITextFieldWithUnderlineType.active.rawValue:
            viewUnderline.backgroundColor = DCUIFColor.PrimaryBlack.getColor()
        case DCUITextFieldWithUnderlineType.error.rawValue:
            viewUnderline.backgroundColor = DCUIFColor.BluishYellow.getColor()
        default:
            viewUnderline.backgroundColor = DCUIFColor.MediumGray.getColor()
        }
    }
    
    @IBAction func btnActionClicked(_ sender: DCUIFThemeButton) {
        self.isSecureEntry = !self.isSecureEntry
        self.toggleActionBtnTitle()
        configureData()
    }
    
    @IBAction func txtFieldEditingChanged(_ sender: UITextField) {
        if let text = sender.text {
            self.delegate?.textFeildValueChange(value: text)
        }
    }

}

extension DCUITextFieldWithUnderline: UITextFieldDelegate {
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.delegate?.textFeildViewEndEditing()
        self.txtFieldState = 0
        return true
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
       self.txtFieldState = 1
       return true
    }
   
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.txtFieldState = 0
        textField.resignFirstResponder();
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.txtFieldState = 0
        textField.resignFirstResponder()
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let txtAfterUpdate = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        if txtAfterUpdate.count > 25 {
            return false
        }
        return true
    }
}
