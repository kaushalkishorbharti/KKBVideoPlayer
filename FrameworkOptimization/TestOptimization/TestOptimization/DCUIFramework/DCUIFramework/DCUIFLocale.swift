//
//  DCUIFLocale.swift
//  DCUIFramework
//
//  Created by kaushal kishor on 05/11/18.
//  Copyright © 2018 Abhinav Agarwal. All rights reserved.
//

import UIKit

public class DCUIFLocale: NSObject{

    
    public  var key:String = "";
    public  var value:String = "";
    public  var keyDescription:String = "";
    
    
    override public init() {
        
    }
   
    public init(dict:Dictionary<String,Any>){
        
        self.key = (dict["key"]! as! String)
        self.value = (dict["value"]! as! String);
        
        
    }
    
    public static func modelArrayFromLocale(array:Array<Dictionary<String, Any>>) -> Array<DCUIFLocale>{
        
        var arrLocale:Array<DCUIFLocale> = Array();
        for locale in array{
            
            arrLocale.append(DCUIFLocale.init(dict: locale))
        }
        return arrLocale;
        
    }
    
    public static func getLocaleText(key: String)-> String
    {
        var text: String = "";
        
        if DCUIFLocaleManager.shared.arrLanguageTxtFile != nil{
            
            for (index,localeTxtModel) in ((DCUIFLocaleManager.shared.arrLanguageTxtFile)?.enumerated())!
        {
            
            if localeTxtModel.key == key{
    
                text = localeTxtModel.value;
                DCUIFLocaleManager.shared.arrLanguageTxtFile?.remove(at: index);
                break;
            }
        }
            
        }
        
        return text;
        
    }
    
    public static func getLocale(key: String)-> DCUIFLocale
    {
        
        var tempLocale: DCUIFLocale = DCUIFLocale.init();
        
        if DCUIFLocaleManager.shared.arrLanguageTxtFile != nil{
            
            for (index,localeTxtModel) in ((DCUIFLocaleManager.shared.arrLanguageTxtFile)?.enumerated())!
            {
                
                if localeTxtModel.key == key{
                    
                    tempLocale = localeTxtModel;
                    DCUIFLocaleManager.shared.arrLanguageTxtFile?.remove(at: index);
                    break;
                }
            }
            
        }
        
        return tempLocale;
        
    }
    
}
