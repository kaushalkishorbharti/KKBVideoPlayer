//
//  DCUIFAlert.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 04/08/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit

@objc public protocol DCUIFAlertProtocol{
    
    func OkClick()
}

@objc public class DCUIFAlert: NSObject {
   
    @objc public var delegate:DCUIFAlertProtocol?
    @objc public static var vc:DCFAlertCustomViewProtocol?;
    
    
    
@objc public static func showOkAlert(title:String,description:String,onViewCotroller:UIViewController){
        
        let alert = UIAlertController(title:title, message: description, preferredStyle: UIAlertControllerStyle.alert);
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:nil))
       // UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        onViewCotroller.present(alert, animated: true, completion: nil)
    
    
        
    }
  public static func showSingleOkAlert(title:String,description:String,onViewCotroller:UIViewController){
    if DCUIFViewController.getTopViewController().isKind(of: UIAlertController.self) {
      DCUIFViewController.getTopViewController().dismiss(animated: true) {
        DCUIFAlert.showOkAlert(title: "Alert", description: description, onViewCotroller: DCUIFViewController.getTopViewController())
      }
    } else {
      DCUIFAlert.showOkAlert(title: "Alert", description: description, onViewCotroller: DCUIFViewController.getTopViewController())
    }
  }
    @objc public static func showOkAlertWithComplition(buttonName:String?="",title:String,description:String,onViewCotroller:UIViewController,complition:@escaping () -> Void){
        
        let alert = UIAlertController(title:title, message: description, preferredStyle: UIAlertControllerStyle.alert);
        
        if buttonName == ""{
        alert.addAction(UIAlertAction(title: "OK_COMMON".localized(withComment:""), style: UIAlertActionStyle.default, handler:{ (action) in
            complition();
        }));
        }else{
            alert.addAction(UIAlertAction(title: buttonName, style: UIAlertActionStyle.default, handler:{ (action) in
                complition();
            }));
        }
        onViewCotroller.present(alert, animated: true, completion: nil)
  
    }
   
    @objc public static func showOkCancelAlertWithComplition(title:String,description:String,onViewCotroller:UIViewController, okButton:String = "",complition:@escaping () -> Void){
        
        var value:String = "";
        if(okButton == ""){
          value =  "OK_COMMON".localized(withComment:"")
        }
        else{
            value = okButton;
        }
       
        
        let alert = UIAlertController(title:title, message: description, preferredStyle: UIAlertControllerStyle.alert);
        
        alert.addAction(UIAlertAction(title: value, style: UIAlertActionStyle.default, handler:{ (action) in
           complition();
        }));

        alert.addAction(UIAlertAction(title:"CANCEL_COMMON".localized(withComment:""), style: UIAlertActionStyle.cancel, handler:{ (action) in
           // complition();
        }));
     onViewCotroller.present(alert, animated: true, completion: nil)
        
        
    }
  @objc public static func showGalaxyOkCancelAlertWithComplition(title:String,description:String,okTxt: String, cancelTxt: String,onViewCotroller:UIViewController, okButton:String = "",complition:@escaping () -> Void){
      
      let alert = UIAlertController(title:title, message: description, preferredStyle: UIAlertControllerStyle.alert);
      
      alert.addAction(UIAlertAction(title: okTxt, style: UIAlertActionStyle.default, handler:{ (action) in
         complition();
      }));

      alert.addAction(UIAlertAction(title: cancelTxt, style: UIAlertActionStyle.cancel, handler:{ (action) in
         // complition();
      }));
   onViewCotroller.present(alert, animated: true, completion: nil)
      
      
  }
    @objc public static func showOkCancelAlertWithComplitionStatus(title:String,description:String,onViewCotroller:UIViewController, okButton:String = "",cancelButton:String = "",complition:@escaping (_ status:Bool) -> Void){
        
        var value:String = "";
        var cancelButtonText = "";
        
        if(okButton == ""){
            value =  "OK_COMMON".localized(withComment:"")
        }
        else{
            value = okButton;
        }
        
        if(cancelButton == ""){
            cancelButtonText =  "CANCEL_COMMON".localized(withComment:"")
        }
        else{
            cancelButtonText = cancelButton;
        }
        
        
        let alert = UIAlertController(title:title, message: description, preferredStyle: UIAlertControllerStyle.alert);
        
        alert.addAction(UIAlertAction(title: value, style: UIAlertActionStyle.default, handler:{ (action) in
            complition(true);
        }));
        
        alert.addAction(UIAlertAction(title:cancelButtonText, style: UIAlertActionStyle.cancel, handler:{ (action) in
             complition(false);
        }));
        onViewCotroller.present(alert, animated: true, completion: nil)
        
        
    }
    
    @objc public static func showOkCustomAlertWithComplition(image:String?, description:String?, freeChannelStaticText:String?,termsCondtionsUrl:String?,channelPharmaName:String?, delegate:DCFAlertCustomViewProtocol,complition:@escaping (_ staus:Bool) -> Void)
    {
        
        let vc:UIViewController =  DCUIFViewController.getTopViewController();
        let alertView:DCFAlertCustomView =   DCFAlertCustomView.init(frame: CGRect(x: 0, y: 0, width: vc.view.frame.size.width-40, height: 300),delegate: delegate,descriptionText:description,tncURL:termsCondtionsUrl,freeChannelText:freeChannelStaticText,channelImageUrl:image,pharmaName:channelPharmaName);
        
        alertView.center = CGPoint(x:vc.view.frame.size.width/2, y: vc.view.frame.size.height/2 + 40);
       
        
        alertView.show();
        
    }
    
   @objc public static func showOkAlertWithCallAction(buttonName:String?="",title:String,description:String,onViewCotroller:UIViewController)
   {
    let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
    var titleName = "OK";
    if buttonName == ""{
        titleName = "OK";
    }else{
        titleName = title;
    }
    let OKAction = UIAlertAction(title: titleName, style: .default) { (action:UIAlertAction!) in
        
        onViewCotroller.dismiss(animated: true, completion: nil);
        
    }
    
    alertController.addAction(OKAction)
    
    onViewCotroller.present(alertController, animated: true, completion:nil);
    
   }
    
     public static func showActionSheet(_ actions: [DCUIActionSheetModel], _ title: String,comletion: @escaping (_ action: DCUIActionSheetModel, _ status: Bool) -> Void,onViewCotroller:UIViewController) {
        
        var style = UIAlertController.Style.actionSheet
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            style = UIAlertController.Style.alert
        }
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: style)
        for actionData in actions {
            let action = UIAlertAction(title: actionData.title
                , style: .default, handler: { (UIAlertAction) in
                    comletion(actionData, true)
            })
            action.setValue(DCUIFTheme.sharedInstance.appTheme?.colorBlack, forKey: "titleTextColor")
            action.setValue(0, forKey: "titleTextAlignment")
            action.setValue(DCUIFTheme.sharedInstance.appTheme?.colorBlack, forKey: "imageTintColor")
            if let icon = actionData.image {
                action.setValue(icon, forKey: "image")
            }
            alert.addAction(action)
        }
        let cancel = UIAlertAction(title: "Cancel".localized(withComment: ""), style: UIAlertActionStyle.cancel, handler: { (UIAlertAction)in
        })
        cancel.setValue(DCUIFColor.PrimaryGreen.getColor(), forKey: "titleTextColor")
        
        alert.addAction(cancel)
        onViewCotroller.present(alert, animated: true, completion: nil)
    }

}

open class DCUIActionSheetModel {
    public var title: String
    public var key: String
    public var image: UIImage?
    public var object: Any?
    public init(_ title: String,_ key: String, _ image: UIImage?) {
        self.title = title
        self.key = key
        self.image = image
    }
}
