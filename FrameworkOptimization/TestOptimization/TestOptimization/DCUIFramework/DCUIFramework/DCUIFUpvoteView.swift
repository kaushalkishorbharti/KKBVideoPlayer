//
//  DCUIFUpvoteView.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 26/08/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit


@objc public protocol DCUIFUpvoteViewProtocol{
    
    func upvoteClick();
    
}


public class DCUIFUpvoteView: DCUIFView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @objc public var delegateUpvote :DCUIFUpvoteViewProtocol?
    var isEnable:Bool = false;
    
    @IBOutlet weak var lblUpvote: DCUIFLabel!
    
    @IBOutlet weak var parentView: DCUIFView!
    @IBOutlet var containerView: UIView!
    
    
    @IBAction func tapGesture(_ sender: Any)
    {
     
        self.delegateUpvote?.upvoteClick()
    
    }
    
    public func setData(label:String,value:String,isEnable:Bool){
  
        self.setEnable(status: isEnable,value: value);
        if(isEnable ==  false){
            self.lblUpvote.text =  label ;
        }
        else{
          if(value == "0")
          {
               self.lblUpvote.text =  label ;
            }
          else {
             self.lblUpvote.text =  label + " ("+value+") ";
            }
        }

        self.updateConstraints();
        self.layoutSubviews();
 
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit();
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit();
    }
    override func commonInit(){
        
        let viewName = "DCUIFUpvoteView";
        DCUIFramework.bundle.loadNibNamed(viewName,owner: self, options: nil)
        addSubview(containerView);
        containerView.frame = self.bounds;
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth];
 
    }
    
    func setEnable(status:Bool,value:String){
        
        if(value .isEmpty)
        {
           
        }
        else{
            
        }
        
        if(status){
            
            self.parentView.backgroundColor = UIColor.rgbColor(red: 202.0, green: 238.0, blue: 234.0, alpha: 1)
                //DCUIFTheme.sharedInstance.appTheme?.secondaryColor;
            self.lblUpvote.labelTextTheme = .K_THEME_TEXT_TextStyleBold;
            self.parentView.layer.borderColor =  DCUIFTheme.sharedInstance.appTheme?.extraborderColor.cgColor;
           //self.lblUpvote.textColor =   DCUIFTheme.sharedInstance.appTheme?.secondaryColor
       
        }
        else{
            
            self.parentView.backgroundColor = UIColor.rgbColor(red: 224, green: 224, blue: 224, alpha: 1)
                //DCUIFTheme.sharedInstance.appTheme?.extraColor_2;
            self.lblUpvote.labelTextTheme = .K_THEME_TEXT_TextStyleBold;
            self.parentView.layer.borderColor =  UIColor.clear.cgColor;
            
        }
    }
}
