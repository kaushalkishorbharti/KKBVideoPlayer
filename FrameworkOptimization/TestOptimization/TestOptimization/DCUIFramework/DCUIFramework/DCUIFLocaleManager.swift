//
//  DCUIFLocaleManager.swift
//  DCUIFramework
//
//  Created by kaushal kishor on 13/11/18.
//  Copyright © 2018 Abhinav Agarwal. All rights reserved.
//

import UIKit

public class DCUIFLocaleManager: NSObject {

    public static let shared:DCUIFLocaleManager = DCUIFLocaleManager.init(languageKey: DCUIFramework.language)
    public var arrLanguageTxtFile: [DCUIFLocale]?;
    
    public init(languageKey: String){
        
    }
    
    var K1:DCUIFLocale?;
    var K2:DCUIFLocale?;
    var K3:DCUIFLocale?;
    var K4:DCUIFLocale?;
    var K5:DCUIFLocale?;
    var K6:DCUIFLocale?;

    public func initWithValue()
    {
        K1 = DCUIFLocale.getLocale(key: "K1");
        K2 = DCUIFLocale.getLocale(key: "K2");
        K3 = DCUIFLocale.getLocale(key: "K3");
        K4 = DCUIFLocale.getLocale(key: "K4");
        K5 = DCUIFLocale.getLocale(key: "K5");
        K6 = DCUIFLocale.getLocale(key: "K6");

    }
}
