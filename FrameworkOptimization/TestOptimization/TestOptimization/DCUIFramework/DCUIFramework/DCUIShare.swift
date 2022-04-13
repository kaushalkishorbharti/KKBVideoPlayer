//
//  DCUIShare.swift
//  DCUIFramework
//
//  Created by Abhinav Agarwal on 6/18/18.
//  Copyright © 2018 Abhinav Agarwal. All rights reserved.
//

import UIKit

class DCUIShare: NSObject,UIActivityItemSource {

    
    
    static private var emailBody:String = "";
    static private var emailSubject:String = "";
    static private var otherContent:String = ""
    
    public func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        
        return "";
        
        
    }
    
    public func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivityType?) -> Any? {
        
        if activityType == UIActivityType.mail {
            return DCUIShare.emailBody
        } else {
            return DCUIShare.otherContent
        }
        
    }
    
    func activityViewController(activityViewController: UIActivityViewController, subjectForActivityType activityType: String?) -> String {
        
        if activityType == UIActivityType.mail .rawValue{
            return DCUIShare.emailSubject;
        } else {
            return ""
        }
        
        
    }
    
    
    @objc public static func shareBtnClick(fromVC:UIViewController, shareTitle:String, shareContent:String, shareEmailContent:String)
    {
        
        emailBody = "<html><body>" + shareEmailContent + "</body></html>";
        emailSubject = shareTitle;
        otherContent = shareContent;
        
        
        
        let activityViewController = UIActivityViewController(activityItems: [DCUIShare()], applicationActivities: nil)
        activityViewController .setValue(emailSubject, forKey: "subject")
        fromVC.present(activityViewController, animated: true, completion: {})
        
        
    }
}
