//
//  DCUIFPermission.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 25/05/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit
//import DCUIFramework
import AVFoundation
//import PermissionScope

public class DCUIFPermission: NSObject {
    
    @objc public static func requestPermission(view:UIViewController,complition:@escaping (_ status:Bool)->Void){
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)

        
        switch cameraAuthorizationStatus {
        case .denied:
            DCUIFAlert.showOkAlertWithComplition(title: "Alert", description: "Please check permission from device setting.", onViewCotroller: DCUIFViewController.getTopViewController()) {
                if let url = NSURL(string: UIApplicationOpenSettingsURLString) as URL? {
                    UIApplication.shared.openURL(url)
                }
            }
//            DCUIFAlert.showOkAlert(title: "Alert", description: "Please check permission from device setting.", onViewCotroller: DCUIFViewController.getTopViewController())
             complition(false);
            break
        case .authorized:
             complition(true);
            break
        case .restricted:
            DCUIFAlert.showOkAlertWithComplition(title: "Alert", description: "Please check permission from device setting.", onViewCotroller: DCUIFViewController.getTopViewController()) {
                if let url = NSURL(string: UIApplicationOpenSettingsURLString) as URL? {
                    UIApplication.shared.openURL(url)
                }
            }
//             DCUIFAlert.showOkAlert(title: "Alert", description: "Please check permission from device setting.", onViewCotroller: DCUIFViewController.getTopViewController())
             complition(false);
            break
            
        case .notDetermined:
            // Prompting user for the permission to use the camera.
            AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
                if granted {
                      complition(true);
                } else {
                     complition(false);
                   // print("Denied access to \(cameraMediaType)")
                }
            }
        }
        
        
        
        
        
//        if(cameraAuthorizationStatus == .authorized){
//            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
//                // Already Authorized
//
//                complition(true);
//
//            } else {
//                AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
//                    if granted == true {
//                        // User granted
//                         complition(true);
//                    } else {
//                        // User Rejected
//
//                        let alert = UIAlertController(title: "Alert", message: "CAMERA_PERMISSION_MSG".localized(withComment:""), preferredStyle: UIAlertControllerStyle.alert)
//                        alert.addAction(UIAlertAction(title: "OK_COMMON".localized(withComment:""), style: UIAlertActionStyle.default, handler: nil))
//                        view.present(alert, animated: true, completion: nil)
//                         complition(false);
//                    }
//                })
//            }
//
//        }
//
//    }
    
}
    
    public static func isCameraPermissionEnable()->Bool{
        
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch status {
        case .notDetermined:
            return true
        case .restricted:
            return false
        case .denied:
            return false
        case .authorized:
            return true
        }
    }
    
    public static func isMicPermissionEnable()->Bool{
         
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
        switch status {
        case .notDetermined:
            return true
        case .restricted:
            return false
        case .denied:
            return false
        case .authorized:
            return true
        }
        
    }
}
    


