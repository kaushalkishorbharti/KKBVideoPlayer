//
//  RGUITheme.swift
//  DCUIFramework
//
//  Created by kaushal kishor on 03/02/21.
//  Copyright © 2021 Abhinav Agarwal. All rights reserved.
//

import UIKit
public class RGUITheme: NSObject {
  // MARK: - --------- Class Variable----------
   public static let sharedInstance: RGUITheme = { RGUITheme()} ()
   public var appTheme:RGUIThemeInfo?
  // MARK: - ---------Public Methods----------
   public func setAppThemeWith(themeInfo:RGUIThemeInfo){
        appTheme = themeInfo
        IQKeyboardManager.shared.enable = true
    }
  public func getThemeInfo() -> RGUIThemeInfo {
    let theme:RGUIThemeInfo = RGUIThemeInfo.init()
    // MARK: - ---------Color----------
    theme.primaryColor1 = UIColor.hexToUIColor("0066CC")
    theme.primaryColor2 = UIColor.hexToUIColor("3385D6")
    theme.primaryColor3 = UIColor.hexToUIColor("66A3E0")
    theme.primaryColor4 = UIColor.hexToUIColor("99C2EB")
    theme.primaryColor5 = UIColor.hexToUIColor("CCE0F5")
    theme.secondaryColor1 = UIColor.hexToUIColor("E40046")
    theme.secondaryColor2 = UIColor.hexToUIColor("E9336B")
    theme.secondaryColor3 = UIColor.hexToUIColor("EF6690")
    theme.secondaryColor4 = UIColor.hexToUIColor("F499B5")
    theme.secondaryColor5 = UIColor.hexToUIColor("FACCDA")
    theme.blackColor1 = UIColor.hexToUIColor("000000")
    theme.blackColor2 = UIColor.hexToUIColor("666666")
    theme.blackColor3 = UIColor.hexToUIColor("B1B3B3")
    theme.blackColor4 = UIColor.hexToUIColor("D1D1D1")
    theme.blackColor5 = UIColor.hexToUIColor("F8F9FA")
    theme.whiteColor = UIColor.hexToUIColor("FFFFFF")
    theme.whiteColor2 = UIColor.hexToUIColor("E8E8E8")
    theme.successColor = UIColor.hexToUIColor("70BF42")
    theme.warningColor = UIColor.hexToUIColor("FA8C16")
    theme.errorColor = UIColor.hexToUIColor("F5222D")
    theme.paleRose = UIColor.hexToUIColor("FACCDA")

    // MARK: - ---------Font----------
    theme.fontHeading1Bold = UIFont.systemFont(ofSize: 28, weight: .bold)
    theme.fontHeading1Regular = UIFont.systemFont(ofSize: 28, weight: .regular)
    theme.fontHeading2Bold = UIFont.systemFont(ofSize: 22, weight: .bold)
    theme.fontHeading2Regular = UIFont.systemFont(ofSize: 22, weight: .regular)
    theme.fontHeading3SemiBold = UIFont.systemFont(ofSize: 20, weight: .semibold)
    theme.fontHeading3Regular = UIFont.systemFont(ofSize: 20, weight: .regular)
    theme.fontSubHeadingSemiBold = UIFont.systemFont(ofSize : 17, weight: .semibold)
    theme.fontSubHeadingMedium = UIFont.systemFont(ofSize: 17, weight: .medium)
    theme.fontSubHeadingRegular = UIFont.systemFont(ofSize: 17, weight: .regular)
    theme.fontBodySemiBold = UIFont.systemFont(ofSize : 15, weight: .semibold)
    theme.fontBodyRegular = UIFont.systemFont(ofSize: 15, weight: .regular)
    theme.fontNotesSemiBold = UIFont.systemFont(ofSize : 12, weight: .semibold)
    theme.fontNotesRegular = UIFont.systemFont(ofSize: 12, weight: .regular)
    return theme
  }
}

