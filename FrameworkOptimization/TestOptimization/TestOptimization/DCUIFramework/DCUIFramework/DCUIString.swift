//
//  DCUIString.swift
//  DCUIFramework
//
//  Created by Arimardan Singh on 11/08/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit

internal extension String {
    
    func localized(withComment:String) -> String {
        
        var lang:String = "Base";
//        UserDefaults.standard.object(forKey: "currentLanguage")
       let returnlangValue:String = (UserDefaults.standard.object(forKey: "currentLanguage") as?String)!
//        let returnlangValue:String = DCUIFramework.language;
        if returnlangValue .isEqual("in"){
            lang = "id"
        } else if returnlangValue .isEqual("th"){
            lang = "th"
        }else if returnlangValue .isEqual("fr"){
            lang = "fr"
        }else if returnlangValue .isEqual("vi"){
            lang = "vi"
        }

        else{
            lang = "Base"
        }
        
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: withComment)
        
    }
    
    
}


