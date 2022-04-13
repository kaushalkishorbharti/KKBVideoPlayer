//
//  DCUIFramework.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 25/05/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit
func print(items: Any..., separator: String = " ", terminator: String = "\n") {
    
    #if DEBUG
    
    var idx = items.startIndex
    let endIdx = items.endIndex
    
    repeat {
        Swift.print(items[idx], separator: separator, terminator: idx == (endIdx - 1) ? terminator : separator)
        idx += 1
    }
        while idx < endIdx
    
    #endif
}

public class DCUIFramework: NSObject {
    
    static public var bundle:Bundle=Bundle.init(identifier: "com.docquity.DCUIFramework")!
    @objc static public var language:String!="en";
    static public var releaseVersion = "8"

   @objc public static func setTheme(){
    
    let theme:DCUIFThemeInfo=DCUIFThemeInfo.init();
    
    //Color
    theme.colorPrimary = UIColor.rgbColor(red: 80, green: 160, blue: 68, alpha: 1)
    theme.colorSecondary = UIColor.rgbColor(red: 79.0, green: 175.0, blue: 89.0, alpha: 1)
    theme.colorError = UIColor.rgbColor(red: 246.0, green: 140.0, blue: 43.0, alpha: 1)
    theme.colorBlack = UIColor.rgbColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
    theme.colorGrey75 = UIColor.rgbColor(red: 114.0, green: 114.0, blue: 114.0, alpha: 1)
    theme.colorGrey50 = UIColor.rgbColor(red: 161.0, green: 161.0, blue: 162.0, alpha: 1)
    theme.colorGrey25 = UIColor.rgbColor(red: 208.0, green: 208.0, blue: 209.0, alpha: 1)
    theme.colorLightGrey = UIColor.rgbColor(red: 247.0, green: 248.0, blue: 249.0, alpha: 1)
    theme.colorBlackPrimary = UIColor.rgbColor(red: 68.0, green: 68.0, blue: 69.0, alpha: 1)
    theme.colorExtra1 = UIColor.rgbColor(red: 58.0, green: 176.0, blue: 229.0, alpha: 1)
    theme.colorExtra2 = UIColor.rgbColor(red: 106.0, green: 198.0, blue: 180.0, alpha: 1)
    theme.colorExtra3 = UIColor.rgbColor(red: 255.0, green: 204.0, blue: 6.0, alpha: 1)
    
   //Font
    theme.fontMainHeadingBold = UIFont.systemFont(ofSize: 20, weight: .bold)
    theme.fontMainHeadingMedium = UIFont.systemFont(ofSize: 20, weight: .medium)
    theme.fontMainHeadingRegular = UIFont.systemFont(ofSize: 20, weight: .regular)
    theme.fontHeadingMedium = UIFont.systemFont(ofSize: 15, weight: .medium)
    theme.fontHeadingBold = UIFont.systemFont(ofSize: 15, weight: .bold)
    theme.fontHeadingRegular = UIFont.systemFont(ofSize: 15, weight: .regular)
    theme.fontParagraphMedium = UIFont.systemFont(ofSize: 12, weight: .medium)
    theme.fontSmallTextMedium = UIFont.systemFont(ofSize: 10, weight: .medium)
    
   //Size
    theme.mainHeadingSize25 = 20;
    theme.headingSize15 = 15;
    theme.paragraphSize12 = 12;
    theme.smallTextSize10 = 10;
    
    theme.primaryColorMain = UIColor.rgbColor(red: 186, green: 0, blue: 0, alpha: 1);
    theme.primaryColor = UIColor.rgbColor(red: 108.0, green: 5.0, blue: 5.0, alpha: 1)
    theme.primaryAlternate = UIColor.rgbColor(red: 108.0, green: 5.0, blue: 5.0, alpha: 1);
    
    theme.buttonPriamryColor = UIColor.hexToUIColor("EE3B4C")
    
    theme.secondaryColor=UIColor.rgbColor(red: 45, green: 186, blue: 170, alpha: 1)
    theme.bgPrimaryColor = UIColor.rgbColor(red: 236, green: 236, blue: 236, alpha: 1)
    theme.bgSecondryColor = UIColor.rgbColor(red: 235, green: 235, blue: 235, alpha: 1)
        //UIColor.rgbColor(red: 249, green: 251, blue:255, alpha: 1)
    theme.textDescriptionColor=UIColor.rgbColor(red: 141, green: 141, blue: 141, alpha: 1)
    theme.textHeadingColor=UIColor.rgbColor(red: 0, green: 0, blue: 0, alpha: 1)
    theme.textHintColor=UIColor.rgbColor(red: 138, green: 138, blue: 138, alpha: 1)
    theme.borderPrimary=UIColor.rgbColor(red: 220, green: 220, blue: 220, alpha: 1)
    //theme.borderSecondry=UIColor.rgbColor(red: 221, green: 220, blue: 220, alpha: 1)
    theme.borderSecondry=UIColor.rgbColor(red: 222, green: 222, blue: 222, alpha: 1)

    theme.extraborderColor=UIColor.rgbColor(red: 122, green: 201, blue: 163, alpha: 1)
    theme.extraColor_1=UIColor.rgbColor(red: 250, green: 250, blue: 250, alpha: 1)
    theme.extraColor_2=UIColor.rgbColor(red: 87, green: 87, blue: 87, alpha: 1)  // upvote btn grey color
    theme.extraColor_3=UIColor.rgbColor(red: 110, green: 110, blue: 110, alpha: 1) // upvoted btn green color
    theme.extraColor_4=UIColor.rgbColor(red: 180, green: 180, blue: 180, alpha: 1)
     //theme.extraColor_4=UIColor.rgbColor(red: 220, green: 223, blue: 226, alpha: 1)
     theme.extraColor_5 = UIColor.rgbColor(red: 180, green: 180, blue: 180, alpha: 1)
    
    theme.activityColor = UIColor.rgbColor(red: 64, green: 99, blue: 200, alpha: 1)
    theme.grayColor =  UIColor.rgbColor(red: 118, green: 118, blue: 118, alpha: 1)

    theme.primaryFontRegular = UIFont.systemFont(ofSize: 10.0);
        
        //UIFont.init(name: "Montserrat-Regular", size: 13.0)
    
    //
    //UIFont(name: UIFont.fontNames(forFamilyName:
    // "Montserrat-Regular")[0], size: 10.0)
    
    theme.primaryFontMedium = UIFont.systemFont(ofSize: 10.0, weight: UIFont.Weight.medium);
    //UIFont.init(name: "Montserrat-Medium", size: 14.0)
    //
    theme.primaryFontBold  = UIFont.systemFont(ofSize: 10.0, weight: UIFont.Weight.bold);
        
        //UIFont.init(name: "Montserrat-Medium", size: 10.0)
        
    theme.primaryFontLight = UIFont.systemFont(ofSize: 10.0);
        //UIFont.init(name: "Montserrat-Light", size: 10.0)
    
    theme.headingSize = 13 //14;
    theme.hintSize=12;
    theme.titleSize=15;
    theme.titleLargeSize = 24;
    theme.descriptionSize = 16;
    theme.subHeadingSize=13;
    theme.dateSizebold=37;
    theme.lightLargeSize=28;
    theme.buttonSize = 11;
    theme.nameSize = 14;
    theme.activitySize = 10;
    theme.titleHeading = 16;
    theme.titleSize16 = 14;
    
//    theme.headingSize=16;
//    theme.hintSize=13;
//    theme.titleSize=14;
//    theme.titleLargeSize = 28;
//    theme.descriptionSize=15;
//    theme.subHeadingSize=16;
//    theme.dateSizebold=40;
//    theme.lightLargeSize=24;
//    theme.buttonSize = 11;
//    theme.nameSize = 14;
//    theme.activitySize = 10;

    DCUIFTheme.sharedInstance.setAppThemeWith(themeInfo: theme);
    
    /*
        theme.primaryColor = UIColor.rgbColor(red: 7.0, green: 150.0, blue: 214.0, alpha: 1)
        theme.primaryAlternate = UIColor.rgbColor(red: 7.0, green: 150.0, blue: 214.0, alpha: 1);
        theme.secondaryColor=UIColor.rgbColor(red: 43.0, green: 181.0, blue: 115.0, alpha: 1)
        theme.bgPrimaryColor=UIColor.rgbColor(red: 255, green: 255, blue: 255, alpha: 1)
        theme.bgSecondryColor=UIColor.rgbColor(red: 230, green: 230, blue:230, alpha: 1)
        theme.textDescriptionColor=UIColor.rgbColor(red: 141, green: 141, blue: 141, alpha: 1)
        theme.textHeadingColor=UIColor.rgbColor(red: 0, green: 0, blue: 0, alpha: 1)
        theme.textHintColor=UIColor.rgbColor(red: 138, green: 138, blue: 138, alpha: 1)
        theme.borderPrimary=UIColor.rgbColor(red: 220, green: 222, blue: 227, alpha: 1)
        theme.borderSecondry=UIColor.rgbColor(red: 221, green: 220, blue: 220, alpha: 1)
        theme.extraborderColor=UIColor.rgbColor(red: 122, green: 201, blue: 163, alpha: 1)
        theme.extraColor_1=UIColor.rgbColor(red: 17, green: 49, blue: 131, alpha: 1)
        theme.extraColor_2=UIColor.rgbColor(red: 224, green: 224, blue: 224, alpha: 1)  // upvote btn grey color
        theme.extraColor_3=UIColor.rgbColor(red: 226, green: 247, blue: 237, alpha: 1) // upvoted btn green color
        theme.extraColor_4=UIColor.rgbColor(red: 221, green: 222, blue: 227, alpha: 1)
        theme.primaryFontRegular = UIFont.systemFont(ofSize: 10.0);
    theme.primaryFontMedium = UIFont.systemFont(ofSize: 10.0, weight: UIFont.Weight.medium);
    theme.primaryFontBold  =   UIFont.systemFont(ofSize: 10.0, weight: UIFont.Weight.bold);
        theme.primaryFontLight =  UIFont.systemFont(ofSize: 10.0);
        theme.headingSize=16;
        theme.hintSize=13;
        theme.titleSize=14;
        theme.titleLargeSize = 28;
        theme.descriptionSize=15;
        theme.subHeadingSize=16;
        theme.dateSizebold=40;
        theme.lightLargeSize=24;
        DCUIFTheme.sharedInstance.setAppThemeWith(themeInfo: theme);
 */
        
    }
    
}
