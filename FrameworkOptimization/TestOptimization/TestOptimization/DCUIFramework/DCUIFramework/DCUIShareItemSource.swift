//
//  MyStringItemSource.swift
//  DCUIFramework
//
//  Created by Arimardan Singh on 16/08/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit


public class DCUIShareItemSource: UIActivity
{

    
    public static var share_message_default:String?;
    public static var share_message_email:String?;

       public static func  showActionSheet(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivityType) -> Any? {
        if (activityType.rawValue as String == "com.google.Gmail.ShareExtension") || (activityType as UIActivityType == UIActivityType.mail) {
            return DCUIShareItemSource.share_message_email
        }
        else if (activityType.rawValue as String == "net.whatsapp.WhatsApp.ShareExtension") || (activityType as UIActivityType == UIActivityType.message) {
            return DCUIShareItemSource.share_message_default
        }
        else {
            return DCUIShareItemSource.share_message_default
        }
        
      
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return "place"
    }

}
