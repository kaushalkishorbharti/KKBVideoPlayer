//
//  DCUIFTextTheme.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 23/05/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit

public class DCUIFTextTheme: NSObject {
    
    var  color:UIColor? = nil;
    var  font:UIFont? = nil;
    var  size:Float? = nil;
  
    
    static func getTextTheme(color:UIColor,font:UIFont,size:Float) -> DCUIFTextTheme{
        
        let theme:DCUIFTextTheme=DCUIFTextTheme.init();
        theme.color=color;
        theme.font=font.withSize(CGFloat(size));
        theme.size=size;
        return theme;
 
    }
    
  
    static let K_THEME_TEXT_TextStyleMainHeading:DCUIFTextTheme = getTextTheme(
        color: DCUIFTheme.sharedInstance.appTheme!.colorBlack,
        font: DCUIFTheme.sharedInstance.appTheme!.fontMainHeadingBold,
        size: DCUIFTheme.sharedInstance.appTheme!.mainHeadingSize25);
    
    static let K_THEME_TEXT_TextStyleHeading:DCUIFTextTheme = getTextTheme(
        color: DCUIFTheme.sharedInstance.appTheme!.colorBlack,
        font: DCUIFTheme.sharedInstance.appTheme!.fontHeadingMedium,
        size: DCUIFTheme.sharedInstance.appTheme!.headingSize15);
    
    static let K_THEME_TEXT_TextStyleParagraph:DCUIFTextTheme = getTextTheme(
        color: DCUIFTheme.sharedInstance.appTheme!.colorBlack,
        font: DCUIFTheme.sharedInstance.appTheme!.fontParagraphMedium,
        size: DCUIFTheme.sharedInstance.appTheme!.paragraphSize12);
    
    static let K_THEME_TEXT_TextStyleSmallText:DCUIFTextTheme = getTextTheme(
        color: DCUIFTheme.sharedInstance.appTheme!.colorBlack,
        font: DCUIFTheme.sharedInstance.appTheme!.fontSmallTextMedium,
        size: DCUIFTheme.sharedInstance.appTheme!.smallTextSize10);
    
    
    static let K_THEME_TEXT_TextStyleTitleMedium:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.textHeadingColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontMedium,
        size: DCUIFTheme.sharedInstance.appTheme!.titleSize
    );
    
    static let K_THEME_TEXT_TextStyleDescriptionMedium:DCUIFTextTheme = getTextTheme(
        
       // color: DCUIFTheme.sharedInstance.appTheme!.primaryColor,
        //font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
        color: DCUIFTheme.sharedInstance.appTheme!.textHeadingColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontMedium,
        size: DCUIFTheme.sharedInstance.appTheme!.descriptionSize
    );
    
    static let K_THEME_TEXT_TextStyleTitleMediumGrey:DCUIFTextTheme = getTextTheme(
        
//        color: DCUIFTheme.sharedInstance.appTheme!.textHeadingColor,
//        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
//        size: DCUIFTheme.sharedInstance.appTheme!.hintSize
        color: DCUIFTheme.sharedInstance.appTheme!.extraColor_4,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontMedium,
        size: DCUIFTheme.sharedInstance.appTheme!.titleSize
        
    );
    
    static let K_THEME_TEXT_TextStyleHintBlackRegular:DCUIFTextTheme = getTextTheme(
        
        //color: DCUIFTheme.sharedInstance.appTheme!.primaryColor,
        color: DCUIFTheme.sharedInstance.appTheme!.extraColor_2,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
        size: DCUIFTheme.sharedInstance.appTheme!.hintSize
    );
    
    static let K_THEME_TEXT_TextStyleBlackRegular:DCUIFTextTheme = getTextTheme(
        
        //color: DCUIFTheme.sharedInstance.appTheme!.primaryColor,
        color: DCUIFTheme.sharedInstance.appTheme!.extraColor_2,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
        size: DCUIFTheme.sharedInstance.appTheme!.descriptionSize
    );
    
    
    static let K_THEME_TEXT_TextStyleHeadingDescriptionRegular:DCUIFTextTheme = getTextTheme(
        
//        color: DCUIFTheme.sharedInstance.appTheme!.textHintColor,
//        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
//        size: DCUIFTheme.sharedInstance.appTheme!.hintSize
        
        color: DCUIFTheme.sharedInstance.appTheme!.textHeadingColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
        size: DCUIFTheme.sharedInstance.appTheme!.headingSize
    );
    
    static let K_THEME_TEXT_TextStyleDescriptionLight:DCUIFTextTheme = getTextTheme(
        
//        color: DCUIFTheme.sharedInstance.appTheme!.secondaryColor,
//        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
//        size: DCUIFTheme.sharedInstance.appTheme!.hintSize
        
        color: DCUIFTheme.sharedInstance.appTheme!.textHeadingColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
        size: DCUIFTheme.sharedInstance.appTheme!.descriptionSize
    );
    
    static let K_THEME_TEXT_TextStyleHintRegular:DCUIFTextTheme = getTextTheme(
        
//        color: DCUIFTheme.sharedInstance.appTheme!.textHeadingColor,
//        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
//        size: DCUIFTheme.sharedInstance.appTheme!.descriptionSize
        
        color: DCUIFTheme.sharedInstance.appTheme!.primaryColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
        size: DCUIFTheme.sharedInstance.appTheme!.nameSize
    );
    
    static let K_THEME_TEXT_TextStyleTitle:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.textHeadingColor,
       // font: DCUIFTheme.sharedInstance.appTheme!.primaryFontMedium,
         font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
        size: DCUIFTheme.sharedInstance.appTheme!.titleSize
    );

    static let K_THEME_TEXT_TextStyleName:DCUIFTextTheme = getTextTheme(
        
//        color: DCUIFTheme.sharedInstance.appTheme!.secondaryColor,
//        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
//        size: DCUIFTheme.sharedInstance.appTheme!.headingSize
        
        color: DCUIFTheme.sharedInstance.appTheme!.textHeadingColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
        size: DCUIFTheme.sharedInstance.appTheme!.nameSize
    );
    
    static let K_THEME_TEXT_TextStyleSponsered:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.textHintColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
        size: DCUIFTheme.sharedInstance.appTheme!.hintSize

    );
    
    static let K_THEME_TEXT_TextStlyeExtraLarge:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.textHeadingColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontBold,
        size: DCUIFTheme.sharedInstance.appTheme!.titleLargeSize
    );
    
    static let K_THEME_TEXT_TextStlyeDefinition:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.textHeadingColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontMedium,
        size: DCUIFTheme.sharedInstance.appTheme!.descriptionSize
    );
    
    static let K_THEME_TEXT_TextStlyeBlack:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.textHeadingColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
        size: DCUIFTheme.sharedInstance.appTheme!.hintSize
    );

    static let K_THEME_TEXT_TextStyleTagSecondary:DCUIFTextTheme = getTextTheme(
        
//        color: DCUIFTheme.sharedInstance.appTheme!.textHeadingColor,
//        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
//        size: DCUIFTheme.sharedInstance.appTheme!.headingSize
        
                color: DCUIFTheme.sharedInstance.appTheme!.secondaryColor,
                font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
                size: DCUIFTheme.sharedInstance.appTheme!.hintSize
    );

    static let K_THEME_TEXT_TextStyletextwhite:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.bgPrimaryColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
        size: DCUIFTheme.sharedInstance.appTheme!.hintSize
    );
    
    static let K_THEME_TEXT_TextStlyeExtraLargePrimary:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.primaryColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontBold,
        size: DCUIFTheme.sharedInstance.appTheme!.titleLargeSize
    );
    
    static let K_THEME_TEXT_TextStyleLight:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.textHeadingColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
        size: DCUIFTheme.sharedInstance.appTheme!.titleSize
    );
    
    static let K_THEME_TEXT_TextStyleBold:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.textHeadingColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontBold,
        size: DCUIFTheme.sharedInstance.appTheme!.titleSize
    );
    
    static let K_THEME_TEXT_TextStyleGreen:DCUIFTextTheme = getTextTheme(
        
//        color: DCUIFTheme.sharedInstance.appTheme!.secondaryColor,
//        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontBold,
//        size: DCUIFTheme.sharedInstance.appTheme!.dateSizebold
        
        color: DCUIFTheme.sharedInstance.appTheme!.extraborderColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
        size: DCUIFTheme.sharedInstance.appTheme!.titleSize
    );
    
    
    static let K_THEME_TEXT_TextStyleActivity:DCUIFTextTheme = getTextTheme(
        
//        color: DCUIFTheme.sharedInstance.appTheme!.secondaryColor,
//        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
//        size: DCUIFTheme.sharedInstance.appTheme!.descriptionSize
        
        color: DCUIFTheme.sharedInstance.appTheme!.textHintColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
        size: DCUIFTheme.sharedInstance.appTheme!.activitySize
    );

    static let K_THEME_TEXT_TextStyleGreyHeading:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.textHintColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
        size: DCUIFTheme.sharedInstance.appTheme!.hintSize
    );
    
    
    static let K_THEME_TEXT_TextStyleGrey:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.textHintColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
        size: DCUIFTheme.sharedInstance.appTheme!.hintSize
    );
    
    static let K_THEME_TEXT_TextStyleWhiteBold:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.bgPrimaryColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontBold,
        size: DCUIFTheme.sharedInstance.appTheme!.lightLargeSize
    );
    
    
    static let K_THEME_TEXT_TextStyleSearch:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.extraColor_4,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
        size: DCUIFTheme.sharedInstance.appTheme!.headingSize
    );
    
    static let K_THEME_TEXT_TextStyleHintRegularSecondry:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.secondaryColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
        size: DCUIFTheme.sharedInstance.appTheme!.nameSize
    );
    
    static let K_THEME_TEXT_TextStyleExtraLargeGreen:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.secondaryColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontBold,
        size: DCUIFTheme.sharedInstance.appTheme!.dateSizebold
    );
    
  
    static let K_THEME_TEXT_TextStyleDescriptionGreen:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.secondaryColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontMedium,
        size: DCUIFTheme.sharedInstance.appTheme!.descriptionSize
    );
    
    static let K_THEME_TEXT_TextStyleDescriptionWhite:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.bgSecondryColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontMedium,
        size: DCUIFTheme.sharedInstance.appTheme!.descriptionSize
    );
 
    static let K_THEME_TEXT_TextStyleBoldWhite:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.bgPrimaryColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontBold,
        size: DCUIFTheme.sharedInstance.appTheme!.descriptionSize
    );

    static let K_THEME_TEXT_TextStyleHeadingBlue:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.activityColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
        size: DCUIFTheme.sharedInstance.appTheme!.hintSize
    );
    
    static let K_THEME_TEXT_TextStyleBottomBold:DCUIFTextTheme = getTextTheme(
        
        color: DCUIFTheme.sharedInstance.appTheme!.extraColor_2,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontBold,
        size: DCUIFTheme.sharedInstance.appTheme!.hintSize
    );
    
    static let K_THEME_TEXT_TextStyleBlackBold:DCUIFTextTheme = getTextTheme(
        color: DCUIFTheme.sharedInstance.appTheme!.textHeadingColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontMedium,
        size: DCUIFTheme.sharedInstance.appTheme!.hintSize);
    
    static let K_THEME_TEXT_TextStyleHeadingList:DCUIFTextTheme = getTextTheme(
        color: DCUIFTheme.sharedInstance.appTheme!.textHeadingColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontMedium,
        size: DCUIFTheme.sharedInstance.appTheme!.titleHeading);
    
    static let K_THEME_TEXT_TextStyleRedLink:DCUIFTextTheme = getTextTheme(
        color: DCUIFTheme.sharedInstance.appTheme!.primaryColorMain,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontMedium,
        size: DCUIFTheme.sharedInstance.appTheme!.titleSize);
    
    static let K_THEME_TEXT_TextStyleDetail:DCUIFTextTheme = getTextTheme(
        color: DCUIFTheme.sharedInstance.appTheme!.textHeadingColor,
        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontLight,
        size: DCUIFTheme.sharedInstance.appTheme!.titleSize16);

    
//   // static let K_THEME_TEXT_Textstyleredclick: DCUIFTextTheme = getTextTheme(
//        color: DCUIFTheme.sharedInstance.appTheme!,
//        font: DCUIFTheme.sharedInstance.appTheme!.primaryFontRegular,
//        size: DCUIFTheme.sharedInstance.appTheme?.primaryColor)
    
    
    static let K_THEME_TEXT_TextStyleNone:DCUIFTextTheme = getTextTheme(
        
        color: UIColor.red,
        font: UIFont.systemFont(ofSize: 10),
        size: 10
    );
    
}
