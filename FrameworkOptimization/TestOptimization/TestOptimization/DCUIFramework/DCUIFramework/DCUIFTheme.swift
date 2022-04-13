 //
//  DCUIFTheme.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 23/05/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit



public class DCUIFTheme: NSObject {
    
    
   @objc public static let sharedInstance: DCUIFTheme = { DCUIFTheme()} ()
    
   @objc  public var appTheme:DCUIFThemeInfo?;
    
    @objc public var imageOptimizationUrl :String  = "";
    @objc public var imageDefaultSourceUrl :String  = "";
    @objc public var videoMaxlimit :Int  = 0;
    
    public var defaultImgResolutionWidth: CGFloat = 1920;
    public var defaultImgResolutionHeight: CGFloat = 1080;
    public var defaultVideoResolution: CGFloat = 720;
    
    @objc public func setAppThemeWith(themeInfo:DCUIFThemeInfo){
        appTheme=themeInfo;
        IQKeyboardManager.shared.enable = true;
        DCUIFImageView.configureImageCatching();
        
    }
    
    

    

}

