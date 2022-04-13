//
//  DCUIBannerView.swift
//  DCUIFramework
//
//  Created by Docquity on 11/21/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit

public class DCUIBannerView: UIView {
    
@IBOutlet weak var bannerView: UIView!

    public override func awakeFromNib() {
        super.awakeFromNib();
        self.layer.borderWidth = 1;
        self.layer.borderColor = DCUIFTheme.sharedInstance.appTheme?.bgPrimaryColor.cgColor;
        
    }
    
    public func setView(bannerArray:Array<String>){
        
        let banner:UIView = DCUIFCarousel.getView(owner: self,carouselArray:bannerArray as NSArray ) as! DCUIFCarousel;
      
        self.addSubview(banner);
        
    }
    
    

}
