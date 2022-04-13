//
//  DCUITextFeildView.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 22/06/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit
//import DCUtilFramework


@objc public protocol DCUITextFeildViewDelegate{
    
    func textFeildViewClickPerformed(textFeildView:DCUITextFeildView);
    func textFeildValueChange(value:String!);
    func closeKeyBoard();
    func scrollKeyboard();
    func textfeildViewEndEditing();
    func textFeildValueChange(value:String!,sender:DCUITextFeildView);
}


@IBDesignable


public class DCUITextFeildView: UIStackView {
    
    
   public var view:UIView!
    @objc public var delegate:DCUITextFeildViewDelegate?    
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet public weak var txtFeild: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var lblError: UILabel!
    
    public var datePicker:DCUIFDateTimePicker!;
    public var valueObject:Any!;
    public var textFeildType:DCUIFTextFeildViewType = DCUIFTextFeildViewType.Text;
    public var dateType:DCUIFDateTimePicker.DateTimePickerType = DCUIFDateTimePicker.DateTimePickerType.DateMonth;
    public var isEnable:Bool = true;
    public var multipalDates:Array<Date> = [];
    
    @objc public  enum DCUIFTextFeildViewType:Int{
        
        case Text,
        Email,
        numeric,
        Date,
        Dropdown,
        TextAction
    }
    
    @IBInspectable public var displayText:String = "" {
        didSet{
            lblName.text = displayText;
           // self.lblName.font = UIFont.init(name: "Montserrat-Medium", size: 15)
     
        }
    };
    
    @IBInspectable public var value:String  {
        
        set{
            txtFeild.text = newValue;
        }
        get{
            return txtFeild.text!;
        }
    };
    
    @IBInspectable public var placeholder:String = "" {
        didSet{
            txtFeild.placeholder = placeholder;
           // self.txtFeild.font = UIFont.init(name: "Montserrat-Regular", size: 14)
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    @objc public func setTextFeildType(type:DCUIFTextFeildViewType,value:Any?){
        
        self.textFeildType = type;
        valueObject = value;
        switch self.textFeildType {
        case DCUIFTextFeildViewType.Date:
            actionButton.isHidden = false;
            actionButton .setImage(DCUIFImageView.CALENDER_IMAGE, for: UIControlState.normal)
            if(!isEnable){
                actionButton.isHidden = true;
            }
            break;
        case DCUIFTextFeildViewType.Dropdown:
            actionButton.isHidden = false;
            
            actionButton .setImage(DCUIFImageView.ARROW_RIGHT_IMAGE, for: UIControlState.normal)
            if(!isEnable){
                actionButton.isHidden = true;
            }
            break;
        case DCUIFTextFeildViewType.TextAction:
            actionButton.isHidden = false;
            actionButton .setImage(DCUIFImageView.OPTIONAL_CHECK_IMAGE, for: UIControlState.normal)
            if(!isEnable){
                actionButton.isHidden = true;
            }
            break;
            
        default:
            actionButton.isHidden = true;
            break;
            
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit();
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit();
    }
    
    public func setError(isError:Bool,errorString:String) {
        
        if(isError){
            
            //self.txtFeild.layer.borderColor = UIColor.red as! CGColor;
            self.lblError.text = errorString;
            
        }
        else{
            
            // self.txtFeild.layer.borderColor = UIColor.gray as! CGColor;
            self.lblError.text = "";
            
        }
    }
    
    func commonInit(){
        
        let viewName = "DCUITextFeildView";
        DCUIFramework.bundle.loadNibNamed(viewName,owner: self, options: nil)
        addSubview(contentView);
        contentView.frame = self.bounds;
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth];
        self.txtFeild.delegate=self;
        self.setTextFeildType(type: textFeildType, value: nil)
        self.lblError.text = "";
        //self.setError(isError: false, errorString: "");
        
    }
    
    func performAction(){
        
        switch self.textFeildType {
        case DCUIFTextFeildViewType.Date:
            self.delegate?.closeKeyBoard();
            self.txtFeild.endEditing(true);
            datePicker = DCUIFDateTimePicker.init();
            if(self.txtFeild.text != ""){
                var format = DCUIFDate.DateStringFormat.DayMonthYear;
                
                if self.dateType == DCUIFDateTimePicker.DateTimePickerType.Year{
                    format = DCUIFDate.DateStringFormat.OnlyYear
                }else if self.dateType == DCUIFDateTimePicker.DateTimePickerType.MonthYear{
                    format = DCUIFDate.DateStringFormat.MonthYear
                }else{
                    format = DCUIFDate.DateStringFormat.DayMonthYear
                }
                
                var date:Date = self.valueObject as! Date;
                //if(date == nil){
                    date = DCUIFDate.getDateFromDateString(dateString: self.txtFeild.text!, dateFormatter: DCUIFDate.getDateFormatterForType(type: format));
                //}
                datePicker.multipleDates = [multipalDates[0],date,multipalDates[2]];
            }
            else{
                
                 datePicker.multipleDates = [multipalDates[0],multipalDates[1],multipalDates[2]];
               
            }
            
            datePicker.openDatePicker(type: dateType, complition: { (date) in
            
            self.setDateToTextFeild(date: date);
                
            });
            
//            datePicker.openDatePicker(type: DCUIFDateTimePicker.DateTimePickerType.DateMonth, complition: { (date) in
//                self.setDateToTextFeild(date: date);
//
//            });
            
            break;
        case DCUIFTextFeildViewType.Dropdown:
            
            self.delegate?.closeKeyBoard();
            self.txtFeild.endEditing(true);
            self.delegate?.textFeildViewClickPerformed(textFeildView: self)
            break;
        case DCUIFTextFeildViewType.Text:
           
            self.delegate?.scrollKeyboard();
              self.delegate?.textFeildViewClickPerformed(textFeildView: self)
            break;
        case DCUIFTextFeildViewType.TextAction:
            // self.txtFeild.autocorrectionType = .no
            //self.delegate?.closeKeyBoard();
            //  self.delegate?.textFeildViewClickPerformed(textFeildView: self)
            break;
        case DCUIFTextFeildViewType.numeric:
            
            self.txtFeild.keyboardType = UIKeyboardType.decimalPad
            self.delegate?.textFeildViewClickPerformed(textFeildView: self)
            
            //--- add UIToolBar on keyboard and Done button on UIToolBar ---//
            self.addDoneButtonOnKeyboard()
            
            break;
            
        case DCUIFTextFeildViewType.Email:
            
            self.txtFeild.keyboardType = UIKeyboardType.emailAddress
            self.txtFeild.autocorrectionType = .no
            self.delegate?.textFeildViewClickPerformed(textFeildView: self)
            
            break;

        }
    }
    
    func setDateToTextFeild(date:Date){
        valueObject = date
        if dateType == DCUIFDateTimePicker.DateTimePickerType.MonthYear{
        self.txtFeild.text = date.stringFromFormat("MMMM' 'yyyy")
        }else if dateType == DCUIFDateTimePicker.DateTimePickerType.Year{
            self.txtFeild.text = date.stringFromFormat("yyyy")
        }
        else{
          self.txtFeild.text = date.stringFromFormat("d' 'MMMM' 'yyyy'")
        }
        self.delegate?.textFeildValueChange(value: self.txtFeild.text);
        
    }
    
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "DONE_COMMON".localized(withComment: ""), style: UIBarButtonItemStyle.done, target: self, action: #selector(self.doneButtonAction))
        
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.txtFeild.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.txtFeild.resignFirstResponder()
    }
    
    @IBAction func actionButtonClick(_ sender: Any) {
        // performAction();
        if(self.textFeildType == .TextAction){
            self.delegate?.textFeildViewClickPerformed(textFeildView: self)
        }
        else{
            performAction();
        }
        
    }
}

public class DCUITextFeildViewModel:NSObject {
    
    public var fieldValue : String?
    public var displayText : String?
    public var placeholderText : String?
    public var fieldIdentifier : String?

  

}

extension DCUITextFeildView:UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
        performAction();
        
        
    }
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.delegate?.textfeildViewEndEditing();
        return true;
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if(self.textFeildType == .TextAction || self.textFeildType == .numeric || self.textFeildType == .Text || self.textFeildType == .Email  ){
            
            return true;
   
        }
        performAction();
        return false;
        
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
        self.delegate?.textFeildValueChange(value: txtAfterUpdate);
        self.delegate?.textFeildValueChange(value: txtAfterUpdate, sender: self)
       // self.delegate?.textFeildValueChange!(value: txtAfterUpdate,sender:self);
        return true;
        
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField)
    {
        
        textField.resignFirstResponder();
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder();
        return true;
    }
    
}



