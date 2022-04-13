
//
//  DCFAlertCustomView.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 16/10/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit

@objc public protocol DCFAlertCustomViewProtocol
{
    func OkClick();
    func btnCancelClick();

}

public class DCFAlertCustomView: UIView {
    
    @IBOutlet weak var imgView: DCUIFImageView!
    @IBOutlet weak var lblDescription: DCUIFLabel!
    @IBOutlet weak var termConditionText: DCUIFLabel!
    @IBOutlet weak var btnCancel: DCUIFButton!
    @IBOutlet weak var btnOk: DCUIFButton!
    @IBOutlet weak var btntick: UIButton!
    @IBOutlet weak var lblChannelFreeText: DCUIFLabel!
    @IBOutlet weak var acceptAllText: DCUIFLabel!
    public var  isChecked:Bool?=false;
    var closerOkClick:()->Void?;
    var closerCancelClick:()->Void?;
    public  var delegate:DCFAlertCustomViewProtocol?
    public  var descriptionText:String?
    public  var tncURL:String?
    public  var freeChannelText:String?
    public  var channelImageUrl:String?
    public  var pharmaName:String?


    class func instanceFromNib() -> UIView {
        return UINib(nibName: "DCFAlertCustomView", bundle: DCUIFramework.bundle).instantiate(withOwner: nil, options: nil)[0] as! DCFAlertCustomView
    }
    

    
    override public func awakeFromNib() {
        
        super.awakeFromNib();
        
      
        imgView.layer.cornerRadius = imgView.frame.width/2
        imgView.clipsToBounds = true
        
        termConditionText.textColor = DCUIFTheme.sharedInstance.appTheme?.secondaryColor
       
        self.acceptAllText.text = "I accept all".localized(withComment:"")
            
        self.termConditionText.text = "terms and conditions".localized(withComment:"")
        
        self.btnCancel.setTitle("CANCEL_COMMON".localized(withComment:""), for: .normal)
        self.btnOk.setTitle("OK_COMMON".localized(withComment:""), for: .normal)
        self.btnCancel.backgroundColor = UIColor.gray;
        self.btnOk.backgroundColor = DCUIFTheme.sharedInstance.appTheme?.buttonPriamryColor;

        //self.btnOk.backgroundColor = UIColor.rgbColor(red: 30, green: 173, blue: 156, alpha: 1)
        
        if  isChecked == false
        {
            //btntick.setBackgroundImage(UIImage(named:"uncheck_box"), for: .normal)
            btntick.setBackgroundImage(UIImage.init(named: "uncheck_box", in: DCUIFramework.bundle, compatibleWith: nil), for: .normal);            isChecked = false;
            self.btnOk.isEnabled = false;
        }
        else
        {
            //btntick.setBackgroundImage(UIImage(named:"check_box"), for: .normal)
            
            btntick.setBackgroundImage(UIImage.init(named: "check_box", in: DCUIFramework.bundle, compatibleWith: nil), for: .normal);
            isChecked = true;
            self.btnOk.isEnabled = true;
          
        }
        
        self.addGestureInTermsLabel();

    }
    
    func addGestureInTermsLabel()
    {
        self.termConditionText.isUserInteractionEnabled = true // gesture on commenter user name
        let taptermsAndConditions: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(OpentermsAndConditions))
        self.termConditionText.addGestureRecognizer(taptermsAndConditions)
        taptermsAndConditions.delegate = self as? UIGestureRecognizerDelegate
    }
    
    @objc func OpentermsAndConditions(sender: UITapGestureRecognizer)
    {
        
         self.superview?.removeFromSuperview();
         btnCancelClick(UIButton.init())
        
        let when = DispatchTime.now() + 0.02 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            let webView:DCUIWebView = DCUIWebView.getView(link:self.tncURL!, pageTitle: "TOOLS_TERMS_AND_CONDITIONS".localized(withComment:""))
            DCUIFViewController.getTopViewController().navigationController?.pushViewController(webView, animated: false);
        }
       
        
       
        
        

    }
    
    @IBAction func btnOkClick(_ sender: Any)
    {

        if isChecked == false
        {
        DCUIFAlert.showOkAlert(title: "Alert", description:"Please accept terms and conditions".localized(withComment:""), onViewCotroller: DCUIFViewController.getTopViewController());
        return;
        }
        
        else{
            //self.closerOkClick();
             self.superview?.removeFromSuperview();
            self.delegate?.OkClick()
            
        }
        
    }
    
    @IBAction func btnCancelClick(_ sender: Any)
    {
      
    
        self.delegate?.btnCancelClick();
        self.superview?.removeFromSuperview();
        
       
        
      //  self.removeFromSuperview();
      //
    }
    
    
    @IBAction func tick(sender: AnyObject)
        {
        //if let button:UIButton = sender as? UIButton {
        if isChecked == false
        {
             btntick.setBackgroundImage(UIImage.init(named: "check_box", in: DCUIFramework.bundle, compatibleWith: nil), for: .normal);
            //button.setBackgroundImage(UIImage(named:"check_box"), for: .normal)
            isChecked = true;
            self.btnOk.isEnabled = true;
        }
       else
        {
            btntick.setBackgroundImage(UIImage.init(named: "uncheck_box", in: DCUIFramework.bundle, compatibleWith: nil), for: .normal);
            //button.setBackgroundImage(UIImage(named:"uncheck_box"), for: .normal)
            isChecked = false;
            self.btnOk.isEnabled = false;
      
        }
                
    //}
}
    
    public init(frame: CGRect,delegate:DCFAlertCustomViewProtocol, descriptionText:String?,
                tncURL:String?,
                freeChannelText:String?,
                channelImageUrl:String?,
                pharmaName:String?) {
       
        self.closerCancelClick = {() -> Void in}
        self.closerOkClick = {() -> Void in}
         super.init(frame: frame);
        let view:DCFAlertCustomView = DCFAlertCustomView.instanceFromNib() as! DCFAlertCustomView;
        view.delegate = delegate;
        view.frame = frame;
        view.freeChannelText = freeChannelText
        view.descriptionText =  descriptionText
        view.tncURL = tncURL;
        view.channelImageUrl = channelImageUrl;
        view.pharmaName = pharmaName
        if(view.lblDescription != nil){
            
            view.lblDescription.text =   String(format: "%@ %@ by %@","Subscribe to".localized(withComment:""),view.descriptionText ?? "", view.pharmaName ?? "");
            view.lblChannelFreeText.text = view.freeChannelText;
            
            view.imgView.dcLoadImageFromRemotePath(path:view.channelImageUrl ?? "", placeHolderImage:UIImage.init(named: DCUIFImageView.IMAGE_CHANNEL_PLACEHODLDER, in: DCUIFramework.bundle , compatibleWith: nil))
        }
       
      
        self.addSubview(view)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.closerCancelClick = {() -> Void in}
        self.closerOkClick = {() -> Void in}
        super.init(coder: aDecoder);
        
    }
    public func show(){
        
        let  superView:UIView = UIApplication.shared.keyWindow!;
        self.frame = superView.bounds;
        self.backgroundColor = UIColor.rgbColor(red: 0, green: 0, blue: 0, alpha: 0.6);
        
        superView.addSubview(self);
        
    }
  

}

/*
extension DCFAlertCustomView: DCFAlertCustomViewProtocol
{
    func OkClick()
    {
        self.delegate?.OkClick()
    }
    
    func btnCancelClick() {
        self.delegate?.btnCancelClick()
    }
 
}
*/

