//
//  DCUIFCustomButtonView.swift
//  DCUIFramework
//
//  Created by kaushal kishor on 26/12/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit


public protocol DCUIFCustomButtonViewProtocol:class {
    
    func customViewClicked(data: Any);
    
}

public class DCUIFCustomButtonView: UIView {

    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imgView: DCUIFImageView!
    @IBOutlet weak var lblTitle: DCUIFLabel!
    public var viewObj:Any?
    
    public var delegate:DCUIFCustomButtonViewProtocol?;

    @IBInspectable public var titleText:String = "" {
        
        didSet{
            lblTitle.text = titleText;
              }
    };
    
    @IBInspectable public var image:UIImage? = nil  {
        
        didSet{
            imgView.image = image;
        }
    };
    
    override public init(frame: CGRect) {
        
        super.init(frame: frame)
        self.commonInit();
    }
    
    required public init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        self.commonInit();
    }
    
    func commonInit(){
        
        let viewName = "DCUIFCustomButtonView";
        DCUIFramework.bundle.loadNibNamed(viewName,owner: self, options: nil)
        addSubview(contentView);
        contentView.frame = self.bounds;
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth];
        setCustomButtonViewData(image:nil , title: nil,viewObj: self.viewObj as Any);
        let tapOnCustomView = UITapGestureRecognizer(target: self, action: #selector(self.callActionAccordingToTap));
        contentView.addGestureRecognizer(tapOnCustomView);
    }
    
    @objc private  func callActionAccordingToTap()
    {
    
        self.delegate?.customViewClicked(data: self.viewObj as Any);
    }
    
    @objc public func setCustomButtonViewData(image:UIImage?,title:String?,viewObj:Any = NSObject()){
        
        self.viewObj = viewObj;
        self.lblTitle.text = title;
        self.imgView.image = image;
    }
    
}
