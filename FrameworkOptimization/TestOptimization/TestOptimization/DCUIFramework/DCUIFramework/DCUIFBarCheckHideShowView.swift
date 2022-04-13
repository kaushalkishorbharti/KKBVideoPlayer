//
//  DCUIFBarCheckHideShowView.swift
//  DCUIFramework
//
//  Created by Abhinav Agarwal on 1/17/18.
//  Copyright © 2018 Abhinav Agarwal. All rights reserved.
//

import UIKit


public protocol DCUIFBarCheckHideShowViewDelegate {
    
    func optionClicked(sender:DCUIFBarCheckHideShowView);
    
}

public class DCUIFBarCheckHideShowView: UIView {

   
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var lblTitle: DCUIFLabel!
    @IBOutlet var contentView: UIView!
    public var isSelected:Bool = false;
    public var identifier:String = "";
    public var delegate:DCUIFBarCheckHideShowViewDelegate?;
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit();
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit();
    }
    @IBInspectable public var displayText:String = "" {
        didSet{
            lblTitle.text = displayText;
            // self.lblName.font = UIFont.init(name: "Montserrat-Medium", size: 15)
            
        }
    };
    
  public func commonInit(){
        
        let viewName = "DCUIFBarCheckHideShowView";
       DCUIFramework.bundle.loadNibNamed(viewName,owner: self, options: nil)
        addSubview(contentView);
        contentView.frame = self.bounds;
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth];
      // btnCheckBox.setImage(UIImage.init(named: DCUIFImageView.IMAGE_CHECK_BOX_UNSELECTED, in: DCUIFramework.bundle, compatibleWith: nil), for: UIControlState.normal);
    
    btnCheckBox.setImage(UIImage.init(named: DCUIFImageView.IMAGE_ICON_SQUARE_RED_UNSELECTED, in: DCUIFramework.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal), for: UIControlState.normal);
    btnCheckBox.tintColor = DCUIFTheme.sharedInstance.appTheme?.primaryColor;
    }
    @IBAction public func btnClick(_ sender: Any) {
        
        
        if(!isSelected){
            
           
             //btnCheckBox.setImage(UIImage.init(named: DCUIFImageView.IMAGE_CHECK_BOX_SELECTED, in: DCUIFramework.bundle, compatibleWith: nil), for: UIControlState.normal);
            
            
            
            btnCheckBox.setImage(UIImage.init(named: DCUIFImageView.IMAGE_ICON_SQUARE_RED_SELECTED, in: DCUIFramework.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal), for: UIControlState.normal);

        }
        else{
             // btnCheckBox.setImage(UIImage.init(named: DCUIFImageView.IMAGE_CHECK_BOX_UNSELECTED, in: DCUIFramework.bundle, compatibleWith: nil), for: UIControlState.normal);
            btnCheckBox.setImage(UIImage.init(named: DCUIFImageView.IMAGE_ICON_SQUARE_RED_UNSELECTED, in: DCUIFramework.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal), for: UIControlState.normal);
        }
         self.isSelected = !self.isSelected;
        self.delegate?.optionClicked(sender: self);
        
    }
    

}
