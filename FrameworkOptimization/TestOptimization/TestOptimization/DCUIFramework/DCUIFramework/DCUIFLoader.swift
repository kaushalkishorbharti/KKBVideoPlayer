//
//  DCUIFLoader.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 18/07/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit


public class DCUIFLoader {
    
    @objc public static var pagingSpinner:UIActivityIndicatorView?;
    
   
    @objc public static func spinner()->UIActivityIndicatorView{
        
        if (pagingSpinner == nil) {
            pagingSpinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            pagingSpinner?.frame = CGRect(x:0, y: 0, width:30, height:30)
            pagingSpinner?.autoresizingMask = (UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleRightMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleLeftMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleBottomMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleTopMargin.rawValue))))
            pagingSpinner?.hidesWhenStopped = true;
            pagingSpinner?.tag = 70001;
        }
        
        return pagingSpinner!;
        
        
    }
    
    
    public static func startLoaderWithText(message:String){
        
        
        HUD.show(HUDContentType.label(message))
        
    }
    public static func stopLoaderWithText(){
        
        HUD.hide()
        
    }

    @objc public static func startLoading(){
        /*
         PKHUD.sharedHUD.contentView = PKHUDRotatingImageView()
         PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = true
         HUD.show(.rotatingImage(UIImage(named: "progress", in: DCUIFramework.bundle, compatibleWith: nil)))
         return;
         let vc = DCUIFViewController.getTopViewController();
         if(vc != nil){
         
         startLoading(view: (vc.view)!);
         }
         else{
         HUD.show(.rotatingImage(UIImage(named: "progress", in: DCUIFramework.bundle, compatibleWith: nil)))
         }
         */
        
        
        
        let vc = DCUIFViewController.getTopViewController();
        
       // if(vc != nil){
            
            DispatchQueue.main.async {
                
                startLoading(view: (vc.view)!);
                
            }
       // }
        
    }
    
   @objc public static func startLoading(view:UIView){
       /*
        PKHUD.sharedHUD.contentView = PKHUDRotatingImageView()
        HUD.show(.rotatingImage(UIImage(named: "progress", in: DCUIFramework.bundle, compatibleWith: nil)),onView: view)
 */
    spinner().center = CGPoint(x:view.bounds.size.width/2.0,y: view.bounds.size.height/2.0);
    DispatchQueue.main.async {
   
        if spinner().isAnimating == false{
            
            spinner().startAnimating()
          view.addSubview(spinner())
        }
        
    }
    }
    
    
   @objc public static func stopLoading(){
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
        
        pagingSpinner?.stopAnimating();
        pagingSpinner?.isHidden = true;
        
        let vc = DCUIFViewController.getTopViewController();
        
        for view in vc.view.subviews{
            
            if view.tag == 70001{
                view.removeFromSuperview();
                
            }
            
        }
    })
      
    }
    

}
extension DCUIFLoader {
   
    public static func startLoading(viewController vc: UIViewController) {
            DispatchQueue.main.async {
                startLoading(view: (vc.view)!);
            }
    }
    
    public static func stopLoading(viewController vc: UIViewController) {
        DispatchQueue.main.async {
            pagingSpinner?.stopAnimating()
            pagingSpinner?.isHidden = true
            for view in vc.view.subviews{
                if view.tag == 70001{
                    view.removeFromSuperview()
                }
            }
        }
    }
}
