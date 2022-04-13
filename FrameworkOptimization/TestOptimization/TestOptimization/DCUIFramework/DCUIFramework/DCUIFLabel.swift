    //
//  DCUIFLabel.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 23/05/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit
//import DCUtilFramework
//import DCUtilFramework

@IBDesignable  open class DCUIFLabel:ActiveLabel {
    
    @IBInspectable var isLocalizable:Bool = true
    @IBInspectable var topInset:Float = 0
    @IBInspectable var bottomInset:Float = 0
    @IBInspectable var leftInset:Float = 0
    @IBInspectable var rightInset:Float = 0
    @IBInspectable var roundRadius:Float = 0
    @IBInspectable var isEnableGenericLinkTap:Bool = true

   required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    @IBInspectable var labelTypeIB:String?{
        didSet{
            labelType = getLabelTypeFrom(string: (labelTypeIB)!)
        }
    }
    
    public enum DCUIFLabelType:String {
        case TextStyleMainHeading = "TextStyleMainHeading"
        case TextStyleHeading = "TextStyleHeading"
        case TextStyleParagraph = "TextStyleParagraph"
        case TextStyleSmallText = "TextStyleSmallText"

        case TextStyleTitleMedium = "TextStyleTitleMedium"
        case TextStyleDescriptionMedium = "TextStyleDescriptionMedium"
        case TextStyleTitleMediumGrey = "TextStyleTitleMediumGrey"
        case TextStyleHintBlackRegular = "TextStyleHintBlackRegular"
        case TextStyleBlackRegular =   "TextStyleBlackRegular"
        case TextStyleHeadingDescriptionRegular = "TextStyleHeadingDescriptionRegular"
        case TextStyleDescriptionLight = "TextStyleDescriptionLight"
        case TextStyleHintRegular = "TextStyleHintRegular"
        case TextStyleTitle = "TextStyleTitle"
        case TextStyleActivity  = "TextStyleActivity"
        case TextStyleName  = "TextStyleName"
        case TextStyleSponsered  = "TextStyleSponsered"
        case TextStlyeExtraLarge = "TextStlyeExtraLarge"
        case TextStlyeDefinition = "TextStlyeDefinition"
        case TextStlyeBlack = "TextStlyeBlack"
        case TextStyleTagSecondary = "TextStyleTagSecondary"
        case TextStyletextwhite = "TextStyletextwhite"
        case TextStlyeExtraLargePrimary = "TextStlyeExtraLargePrimary"
        case TextStyleLight = "TextStyleLight"
        case TextStyleBold = "TextStyleBold"
        case TextStylegrey = "TextStylegrey"
        case TextStyleGreen = "TextStyleGreen"
        case TextStyleGreyHeading = "TextStyleGreyHeading"
        case TextStyleSearch =   "TextStyleSearch"
        case TextStyleWhiteBold =   "TextStyleWhiteBold"
        case TextStyleBoldWhite =   "TextStyleBoldWhite"
        case TextStyleHintRegularSecondry = "TextStyleHintRegularSecondry"
        case TextStyleExtraLargeGreen =   "TextStyleExtraLargeGreen"
        case TextStyleDescriptionGreen =   "TextStyleDescriptionGreen"
        case TextStyleDescriptionWhite =   "TextStyleDescriptionWhite"
        case TextStyleHeadingBlue =        "TextStyleHeadingBlue"
        case TextStyleBottomBold =         "TextStyleBottomBold"

        case TextStyleBlackBold =  "TextStyleBlackBold"
        case TextStyleHeadingList = "TextStyleHeadingList"
        case TextStyleRedLink = "TextStyleRedLink"
        case TextStyleDetail = "TextStyleDetail"
       // case Textstyleredclick = "Textstyleredclick"
        
        //case TextStyleExtraLargeGreyHeading = "TextStyleGreyHeading"

    
        
        case DCUIFLabelTypeNone = "Wrong"
    }
    public var labelType:DCUIFLabelType=DCUIFLabelType.DCUIFLabelTypeNone{
        didSet{
        labelTextTheme=self.getFontThemeForLabelType(labelType: labelType)
    }
}
    
    private func getFontThemeForLabelType(labelType:DCUIFLabelType) -> DCUIFTextTheme {
        switch (labelType) {
        case DCUIFLabelType.TextStyleMainHeading:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleMainHeading
        case DCUIFLabelType.TextStyleHeading:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleHeading
        case DCUIFLabelType.TextStyleParagraph:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleParagraph
        case DCUIFLabelType.TextStyleSmallText:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleSmallText
            
        case DCUIFLabelType.TextStyleTitleMedium:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleTitleMedium
            
        case DCUIFLabelType.TextStyleDescriptionMedium:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleDescriptionMedium
            
        case DCUIFLabelType.TextStyleTitleMediumGrey:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleTitleMediumGrey
            
        case DCUIFLabelType.TextStyleHintBlackRegular:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleHintBlackRegular
            
        case DCUIFLabelType.TextStyleBlackRegular:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleBlackRegular
            
        case DCUIFLabelType.TextStyleHeadingDescriptionRegular:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleHeadingDescriptionRegular
            
        case DCUIFLabelType.TextStyleDescriptionLight:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleDescriptionLight
            
        case DCUIFLabelType.TextStyleHintRegular:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleHintRegular
            
        case DCUIFLabelType.TextStyleTitle:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleTitle
            
        case DCUIFLabelType.TextStyleName:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleName
            
        case DCUIFLabelType.TextStyleSponsered:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleSponsered
            
        case DCUIFLabelType.TextStlyeExtraLarge:
            return DCUIFTextTheme.K_THEME_TEXT_TextStlyeExtraLarge
            
        case DCUIFLabelType.TextStlyeDefinition:
            return DCUIFTextTheme.K_THEME_TEXT_TextStlyeDefinition
            
        case DCUIFLabelType.TextStlyeBlack:
            return DCUIFTextTheme.K_THEME_TEXT_TextStlyeBlack
            
        case DCUIFLabelType.TextStyleTagSecondary:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleTagSecondary
            
        case DCUIFLabelType.TextStyletextwhite:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyletextwhite
            
        case DCUIFLabelType.TextStlyeExtraLargePrimary:
            return DCUIFTextTheme.K_THEME_TEXT_TextStlyeExtraLargePrimary

        case DCUIFLabelType.TextStyleBold:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleBold
            
        case DCUIFLabelType.TextStyleLight:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleLight
            
        case DCUIFLabelType.TextStyleActivity:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleActivity
            
        case DCUIFLabelType.TextStyleGreyHeading:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleGreyHeading
            
        case DCUIFLabelType.TextStylegrey:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleGrey
   
        case DCUIFLabelType.TextStyleGreen:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleGreen
        
        case DCUIFLabelType.TextStyleWhiteBold:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleWhiteBold
            
        case DCUIFLabelType.TextStyleSearch:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleSearch
            
        case DCUIFLabelType.TextStyleHintRegularSecondry:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleHintRegularSecondry
            
        case DCUIFLabelType.TextStyleExtraLargeGreen:
         return DCUIFTextTheme.K_THEME_TEXT_TextStyleExtraLargeGreen
            
        case DCUIFLabelType.TextStyleDescriptionGreen:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleDescriptionGreen
            
        case DCUIFLabelType.TextStyleDescriptionWhite:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleDescriptionWhite
           
        case DCUIFLabelType.TextStyleBoldWhite:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleBoldWhite
            
        case DCUIFLabelType.TextStyleHeadingBlue:
            
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleHeadingBlue
            
        case DCUIFLabelType.TextStyleBottomBold:
            
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleBottomBold
           
        case DCUIFLabelType.TextStyleBlackBold:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleBlackBold
            
        case DCUIFLabelType.TextStyleHeadingList:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleHeadingList
            
        case DCUIFLabelType.TextStyleRedLink:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleRedLink
        
        case DCUIFLabelType.TextStyleDetail:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleDetail
            
       // case DCUIFLabelType.Textstyleredclick:
        //    return DCUIFTextTheme.
        
            default:
            return DCUIFTextTheme.K_THEME_TEXT_TextStyleNone
        }
    }

    public var labelTextTheme:DCUIFTextTheme = DCUIFTextTheme.K_THEME_TEXT_TextStyleNone{
        
        didSet{
           
            updateLabeTextTheme(textTheme:labelTextTheme, label: self)
        }
    }
    
    private func updateLabeTextTheme(textTheme:DCUIFTextTheme,label:DCUIFLabel){
        label.font=textTheme.font
        label.textColor=textTheme.color
     }
 
     //@available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'labelType' instead.")
    
    
    func getLabelTypeFrom(string:String) -> DCUIFLabelType {
        switch string {
        case DCUIFLabelType.TextStyleTitleMedium.rawValue:
            return DCUIFLabelType.TextStyleTitleMedium
            
        case DCUIFLabelType.TextStyleDescriptionMedium.rawValue:
            return DCUIFLabelType.TextStyleDescriptionMedium
            
        case DCUIFLabelType.TextStyleTitleMediumGrey.rawValue:
            return DCUIFLabelType.TextStyleTitleMediumGrey
            
        case DCUIFLabelType.TextStyleHintBlackRegular.rawValue:
            return DCUIFLabelType.TextStyleHintBlackRegular
            
        case DCUIFLabelType.TextStyleBlackRegular.rawValue:
            return DCUIFLabelType.TextStyleBlackRegular
            
        case DCUIFLabelType.TextStyleHeadingDescriptionRegular.rawValue:
            return DCUIFLabelType.TextStyleHeadingDescriptionRegular

        case DCUIFLabelType.TextStyleDescriptionLight.rawValue:
            return DCUIFLabelType.TextStyleDescriptionLight

        case DCUIFLabelType.TextStyleHintRegular.rawValue:
            return DCUIFLabelType.TextStyleHintRegular
            
        case DCUIFLabelType.TextStyleSponsered.rawValue:
            return DCUIFLabelType.TextStyleSponsered
            
        case DCUIFLabelType.TextStyleName.rawValue:
            return DCUIFLabelType.TextStyleName

        case DCUIFLabelType.TextStyleTitle.rawValue:
            return DCUIFLabelType.TextStyleTitle
            
        case DCUIFLabelType.TextStyleName.rawValue:
            return DCUIFLabelType.TextStyleName
            
        case DCUIFLabelType.TextStlyeExtraLarge.rawValue:
            return DCUIFLabelType.TextStlyeExtraLarge
            
        case DCUIFLabelType.TextStlyeDefinition.rawValue:
            return DCUIFLabelType.TextStlyeDefinition
            
        case DCUIFLabelType.TextStlyeBlack.rawValue:
            return DCUIFLabelType.TextStlyeBlack
            
        case DCUIFLabelType.TextStyleTagSecondary.rawValue:
            return DCUIFLabelType.TextStyleTagSecondary
            
        case DCUIFLabelType.TextStlyeExtraLargePrimary.rawValue:
            return DCUIFLabelType.TextStlyeExtraLargePrimary
            
        case DCUIFLabelType.TextStyleBold.rawValue:
            return DCUIFLabelType.TextStyleBold
            
        case DCUIFLabelType.TextStyleLight.rawValue:
            return DCUIFLabelType.TextStyleLight
            
        case DCUIFLabelType.TextStyleActivity.rawValue:
            return DCUIFLabelType.TextStyleActivity
            
        case DCUIFLabelType.TextStyleGreen.rawValue:
            return DCUIFLabelType.TextStyleGreen
            
        case DCUIFLabelType.TextStlyeBlack.rawValue:
            return DCUIFLabelType.TextStlyeBlack
            
        case DCUIFLabelType.TextStyleGreyHeading.rawValue:
            return DCUIFLabelType.TextStyleGreyHeading
            
        case DCUIFLabelType.TextStylegrey.rawValue:
            return DCUIFLabelType.TextStylegrey
            
        case DCUIFLabelType.TextStyletextwhite.rawValue:
            return DCUIFLabelType.TextStyletextwhite
        
        case DCUIFLabelType.TextStyleWhiteBold.rawValue:
            return DCUIFLabelType.TextStyleWhiteBold
            
        case DCUIFLabelType.TextStyleExtraLargeGreen.rawValue:
            return DCUIFLabelType.TextStyleExtraLargeGreen
            
        case DCUIFLabelType.TextStyleExtraLargeGreen.rawValue:
            return DCUIFLabelType.TextStyleExtraLargeGreen
            
        case DCUIFLabelType.TextStyleDescriptionGreen.rawValue:
            return DCUIFLabelType.TextStyleDescriptionGreen
            
        case DCUIFLabelType.TextStyleDescriptionWhite.rawValue:
            return DCUIFLabelType.TextStyleDescriptionWhite
            
        case DCUIFLabelType.TextStyleBoldWhite.rawValue:
            return DCUIFLabelType.TextStyleBoldWhite
            
        case DCUIFLabelType.TextStyleHeadingBlue.rawValue:
            return DCUIFLabelType.TextStyleHeadingBlue
            
        case DCUIFLabelType.TextStyleBottomBold.rawValue:
            return DCUIFLabelType.TextStyleBottomBold
            
        case DCUIFLabelType.TextStyleBlackBold.rawValue:
            return DCUIFLabelType.TextStyleBlackBold
            
        case DCUIFLabelType.TextStyleHeadingList.rawValue:
            return DCUIFLabelType.TextStyleHeadingList
            
        case DCUIFLabelType.TextStyleRedLink.rawValue:
            return DCUIFLabelType.TextStyleRedLink

        case DCUIFLabelType.TextStyleDetail.rawValue:
            return DCUIFLabelType.TextStyleDetail
            
        case DCUIFLabelType.TextStyleSearch.rawValue:
            return DCUIFLabelType.TextStyleSearch
            
        case DCUIFLabelType.TextStyleMainHeading.rawValue:
            return DCUIFLabelType.TextStyleMainHeading
            
        case DCUIFLabelType.TextStyleHeading.rawValue:
            return DCUIFLabelType.TextStyleHeading
            
        case DCUIFLabelType.TextStyleParagraph.rawValue:
            return DCUIFLabelType.TextStyleParagraph
            
        case DCUIFLabelType.TextStyleSmallText.rawValue:
            return DCUIFLabelType.TextStyleSmallText
            
        default:
            return DCUIFLabelType.DCUIFLabelTypeNone
        }
    }
    override public func drawText(in rect: CGRect) {
            let insets: UIEdgeInsets = UIEdgeInsets(top: CGFloat(topInset), left: CGFloat(leftInset), bottom: CGFloat(bottomInset), right: CGFloat(rightInset))
            super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
        }
        
    override public var intrinsicContentSize: CGSize {
            var intrinsicSuperViewContentSize = super.intrinsicContentSize
            intrinsicSuperViewContentSize.height += CGFloat(topInset) + CGFloat(bottomInset)
            intrinsicSuperViewContentSize.width += CGFloat(leftInset) + CGFloat(rightInset)
            return intrinsicSuperViewContentSize
        }
    
    func commonInit(){
        if (DCUIFTheme.sharedInstance.appTheme == nil){
            DCUIFramework.setTheme()
        }
        self.hashtagColor =  self.textColor
        self.mentionColor = self.textColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius=CGFloat(self.roundRadius)
        //self.sizeToFit()
        if (isLocalizable) {
            //  self.text = NSLocalizedString(self.text!, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        }
        
    }
    
    override public func prepareForInterfaceBuilder() {
       if ( DCUIFTheme.sharedInstance.appTheme == nil){
            DCUIFramework.setTheme()
        }
       // self.isInterfaceBuilder = true
    }
    
    func makeTagString(array:NSArray,seperator:String,color:UIColor) {
     /*   for item  in array{
            NSURL *URL = [NSURL URLWithString: @"whatsapp://app"]
            NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:item]
            [str addAttribute: NSLinkAttributeName value:URL range: NSMakeRange(0, str.length)]
            yourTextField.attributedText = str
        }
         */
    }
}

@IBDesignable
open class DCUIFThemeLabel: ActiveLabel {
    
    var style = DCUIFStyle()
    var color = DCUIFColor()
    var themeTextColor: UIColor?
    
    @IBInspectable var labelStyleIB: Int = DCUIFStyle.MainHeadingBold.rawValue {
        didSet {
            self.style = DCUIFStyle(value: self.labelStyleIB)
            self.setNeedsDisplay()
            self.updateLabel()
        }
    }
    
    @IBInspectable var labelColorIB: Int = DCUIFColor.PrimaryRed.rawValue {
        didSet {
            self.color = DCUIFColor(value: self.labelColorIB)
            self.setNeedsDisplay()
            self.updateLabel()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
    }
    
    private func commonInit(){
        if (DCUIFTheme.sharedInstance.appTheme == nil) {
            DCUIFramework.setTheme() 
        }
        self.hashtagColor =  self.textColor
        self.mentionColor = self.textColor
        self.layer.masksToBounds = true
    }
    
    private func updateLabel() {
        self.font = self.style.getFont().font
        self.textColor = self.color.getColor()
    }
    
}

public enum DCUIFStyle: Int {
    
    static let mainHeadingSize: CGFloat = 20
    static let headingSize: CGFloat = 15
    static let paragraphSize: CGFloat = 12
    static let paragraphSmallSize: CGFloat = 10
    
    case MainHeadingBold = 0
    case MainHeadingMedium = 1
    case MainHeadingRegular = 2
    case HeadingBold = 3
    case HeadingRegular = 4
    case HeadingMedium = 5
    case ParagraphMedium = 6
    case Small = 7
    case SmallParagraphBold = 8
    case SmallParagraphRegular = 9
    case SmallParagraphMedium = 10
    
    public init() {
        self = .MainHeadingBold
    }
    
    public init(value: Int) {
        var result: DCUIFStyle = DCUIFStyle()
        switch value {
        case DCUIFStyle.MainHeadingBold.rawValue:
            result = .MainHeadingBold
        case DCUIFStyle.MainHeadingMedium.rawValue:
            result = .MainHeadingMedium
        case DCUIFStyle.MainHeadingRegular.rawValue:
            result = .MainHeadingRegular
        case DCUIFStyle.HeadingBold.rawValue:
            result = .HeadingBold
        case DCUIFStyle.HeadingRegular.rawValue:
            result = .HeadingRegular
        case DCUIFStyle.HeadingMedium.rawValue:
            result = .HeadingMedium
        case DCUIFStyle.ParagraphMedium.rawValue:
            result = .ParagraphMedium
        case DCUIFStyle.Small.rawValue:
            result = .Small
        case DCUIFStyle.SmallParagraphBold.rawValue:
            result = .SmallParagraphBold
        case DCUIFStyle.SmallParagraphRegular.rawValue:
            result = .SmallParagraphRegular
        case DCUIFStyle.SmallParagraphMedium.rawValue:
            result = .SmallParagraphMedium
        default:
            result = .MainHeadingBold
        }
        self = result
    }
    
    public func getFont() -> (font :UIFont, cornerRadius: CGFloat) {
        switch self {
        case .MainHeadingBold:
            return (UIFont.systemFont(ofSize: DCUIFStyle.mainHeadingSize, weight: UIFont.Weight.bold), 8)
        case .MainHeadingMedium:
            return (UIFont.systemFont(ofSize: DCUIFStyle.mainHeadingSize, weight: UIFont.Weight.medium), 8)
        case .MainHeadingRegular:
            return (UIFont.systemFont(ofSize: DCUIFStyle.mainHeadingSize, weight: UIFont.Weight.regular), 8)
        case .HeadingBold:
            return (UIFont.systemFont(ofSize: DCUIFStyle.headingSize, weight: UIFont.Weight.bold), 6)
        case .HeadingMedium:
            return (UIFont.systemFont(ofSize: DCUIFStyle.headingSize, weight: UIFont.Weight.medium), 6)
        case .HeadingRegular:
            return (UIFont.systemFont(ofSize: DCUIFStyle.headingSize, weight: UIFont.Weight.regular), 6)
        case .ParagraphMedium:
            return (UIFont.systemFont(ofSize: DCUIFStyle.paragraphSize, weight: UIFont.Weight.medium), 4)
        case .Small:
            return (UIFont.systemFont(ofSize: DCUIFStyle.paragraphSize, weight: UIFont.Weight.regular), 4)
        case .SmallParagraphBold:
            return (UIFont.systemFont(ofSize: DCUIFStyle.paragraphSmallSize, weight: UIFont.Weight.bold), 2)
        case .SmallParagraphRegular:
            return (UIFont.systemFont(ofSize: DCUIFStyle.paragraphSmallSize, weight: UIFont.Weight.regular), 2)
        case .SmallParagraphMedium:
            return (UIFont.systemFont(ofSize: DCUIFStyle.paragraphSmallSize, weight: UIFont.Weight.medium), 2)
        }
    }
}

public enum DCUIFColor: Int {
    case PrimaryRed = 0
    case PrimaryGreen = 1
    case Gray = 4
    case MediumGray = 5
    case SuperLightGrayMedium = 6
    case SuperLightGray = 7
    case PrimaryBlack = 8
    case BluishYellow = 11
    case White = 12
    case Yellow = 13
    case Seperator = 14
    case TblBgColor = 15
    case SkyBlue = 16
    case ImageBgColor = 17

    case VeryLightPink = 18
    case CharcoalGrey = 19
    case GreenSeperator = 20
    case GradientColorTop = 21
    case GradientColorBottom = 22
    case SeperatorDark = 23


    
    public init() {
        self = .PrimaryRed
    }
    
    public init(value: Int) {
        var result: DCUIFColor = DCUIFColor()
        switch value {
        case DCUIFColor.PrimaryRed.rawValue:
            result = .PrimaryRed
        case DCUIFColor.PrimaryGreen.rawValue:
            result = .PrimaryGreen
        case DCUIFColor.Gray.rawValue:
            result = .Gray
        case DCUIFColor.MediumGray.rawValue:
            result = .MediumGray
        case DCUIFColor.SuperLightGrayMedium.rawValue:
            result = .SuperLightGrayMedium
        case DCUIFColor.SuperLightGrayMedium.rawValue:
            result = .SuperLightGrayMedium
        case DCUIFColor.SuperLightGray.rawValue:
            result = .SuperLightGray
        case DCUIFColor.PrimaryBlack.rawValue:
            result = .PrimaryBlack
        case DCUIFColor.BluishYellow.rawValue:
            result = .BluishYellow
        case DCUIFColor.White.rawValue:
            result = .White
        case DCUIFColor.Yellow.rawValue:
            result = .Yellow
        case DCUIFColor.Seperator.rawValue:
            result = .Seperator
        case DCUIFColor.TblBgColor.rawValue:
            result = .TblBgColor
        case DCUIFColor.SkyBlue.rawValue:
            result = .SkyBlue
        case DCUIFColor.ImageBgColor.rawValue:
            result = .ImageBgColor
        case DCUIFColor.CharcoalGrey.rawValue:
            result = .CharcoalGrey
        case DCUIFColor.GreenSeperator.rawValue:
           result = .GreenSeperator
        case DCUIFColor.GradientColorTop.rawValue:
          result = .GradientColorTop
        case DCUIFColor.GradientColorBottom.rawValue:
          result = .GradientColorBottom
        case DCUIFColor.SeperatorDark.rawValue:
          result = .SeperatorDark
        default:
            result = .PrimaryRed
        }
        self = result
    }
    
    public func getColorCode() -> String {
        switch self {
        case .PrimaryRed:
            return "#EE3B4C"
        case .PrimaryGreen:
            return "#4FAE59"
        case .BluishYellow:
            return "#F58C2A"
        case .PrimaryBlack:
            return "#444445"
        case .Gray:
            return "#737475"
        case .MediumGray:
            return "#A0A0A1"
        case .SuperLightGrayMedium:
            return "#CFD0D1"
        case .SuperLightGray:
            return "#F6F7F8"
        case .White:
            return "#FFFFFF"
        case .Yellow:
            return "#F58C2A"
        case .Seperator:
            return "#EAEAE9"
//        case .TblBgColor:
//            return "e8e7e7"
        case .TblBgColor:
          return "CFD0D1"
        case .SkyBlue:
            return "3486ca"
        case .ImageBgColor:
            return "444445"
        case .CharcoalGrey:
            return "353536"
        case .GreenSeperator:
            return "99D8A7"
        case .VeryLightPink:
            return "eaeaea"
        case .GradientColorTop:
          return "#CCCCCC"
        case .GradientColorBottom:
          return "#EAEAE9"
        case .SeperatorDark:
          return "#CFD0D1"
        }
    }
    
    public func getColor() -> UIColor {
        return UIColor.hexToUIColor(self.getColorCode())
    }
}

public enum DCUIFThemeLabelStyle:String {
    
    case mediumBlack20 = "mediumBlack20"
    case blodBlack15 =  "blodBlack15"
    case mediumBlack15 =  "mediumBlack15"
    case regularBlack15 = "regularBlack15"
    case mediumWhite15 = "mediumWhite15"
    case mediumDarkGrey15 = "mediumDarkGrey15"
    case mediumGreen15 = "mediumGreen15"
    case regularGrey15 = "regularGrey15"
    case boldBlack12 = "boldBlack12"
    case regularGrey12 = "regularGrey12"
    case mediumGrey12 = "mediumGrey12"
    case mediumWhite12 = "mediumWhite12"
    case mediumGreen12 = "mediumGreen12"
    case mediumYellow12 = "mediumYellow12"
    case mediumGrey10 = "mediumGrey10"
    case mediumCharcoalGrey10 = "mediumCharcoalGrey10"
    case regulaBlack12 = "regulaBlack12"
    case regularWhite15 = "regularWhite15"
    case DCUIFLabelTypeNone = "Wrong"
}

@IBDesignable
open class DCUIFActiveThemeLabel: DCUIFLabel {

    var labelThemeIB = DCUIFThemeLabelStyle.DCUIFLabelTypeNone.rawValue
    
    var padding: UIEdgeInsets
    
    // Create a new PaddingLabel instance programamtically with the desired insets
    required public init(padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        self.padding = padding
        super.init(frame: CGRect.zero)
    }
    
    override open func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, padding))
    }
    
    // Override `intrinsicContentSize` property for Auto layout code
    override open var intrinsicContentSize: CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
    
    // Override `sizeThatFits(_:)` method for Springs & Struts code
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSizeThatFits = super.sizeThatFits(size)
        let width = superSizeThatFits.width + padding.left + padding.right
        let heigth = superSizeThatFits.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
    
    required public init?(coder aDecoder: NSCoder) {
         padding = UIEdgeInsets.zero // set desired insets value according to your needs
        super.init(coder: aDecoder)!
        self.commonInit()
    }
    
    public override init(frame: CGRect) {
         padding = UIEdgeInsets.zero // set desired insets value according to your needs
        super.init(frame: frame)
        self.commonInit()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
    }
    
  internal override func commonInit(){
       super.commonInit()
        if (DCUIFTheme.sharedInstance.appTheme == nil) {
            DCUIFramework.setTheme()
        }
        self.hashtagColor =  self.textColor
        self.mentionColor = self.textColor
        //self.text = htmlEncodeString()
        self.layer.masksToBounds = true
        makeLableClickable()
    }

  private func makeLableClickable(){
       self.enabledTypes = [.url];
       self.isUserInteractionEnabled = true
       self.handleURLTap { [weak self](url: URL) in
        guard let weakSelf = self else {return}
        if weakSelf.isEnableGenericLinkTap == false {
          return
        }
         debugPrint("clicked url in active label ===== \(url)")
        DispatchQueue.main.async {
          NotificationCenter.default.post(name: Notification.Name("linkClicked"), object: nil, userInfo: ["url":url])
        }
       }
   }
  
    private func htmlEncodeString() -> String {
        
        let newString = text?.replacingOccurrences(of: "\n", with: "<br/>", options: .literal, range: nil)
        
        guard let data = newString?.data(using: .utf8) else {
            return "";
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.documentType.rawValue): NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.characterEncoding.rawValue): String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return ""
        }
        
        return attributedString.string;
    }

    
    private func updateLabelStyle() {
        switch self.labelThemeIB {
        case DCUIFThemeLabelStyle.mediumBlack20.rawValue:
            self.font = UIFont.systemFont(ofSize: DCUIFFontSize.mainHeading.getFontSize(), weight: DCUIFWeight.medium.getFontWeight())
            self.textColor = DCUIFColor.PrimaryBlack.getColor()
            break
        case DCUIFThemeLabelStyle.blodBlack15.rawValue:
            self.font = UIFont.systemFont(ofSize: DCUIFFontSize.heading.getFontSize(), weight: DCUIFWeight.bold.getFontWeight())
            self.textColor = DCUIFColor.PrimaryBlack.getColor()
            break
        case DCUIFThemeLabelStyle.mediumBlack15.rawValue:
          self.font = UIFont.systemFont(ofSize: DCUIFFontSize.heading.getFontSize(), weight: DCUIFWeight.medium.getFontWeight())
          self.textColor = DCUIFColor.PrimaryBlack.getColor()
          break
        case DCUIFThemeLabelStyle.regularBlack15.rawValue:
            self.font = UIFont.systemFont(ofSize: DCUIFFontSize.heading.getFontSize(), weight: DCUIFWeight.regular.getFontWeight())
            self.textColor = DCUIFColor.PrimaryBlack.getColor()
            break
        case DCUIFThemeLabelStyle.mediumWhite15.rawValue:
            self.font = UIFont.systemFont(ofSize: DCUIFFontSize.heading.getFontSize(), weight: DCUIFWeight.medium.getFontWeight())
            self.textColor = DCUIFColor.White.getColor()
            break
        case DCUIFThemeLabelStyle.mediumDarkGrey15.rawValue:
            self.font = UIFont.systemFont(ofSize: DCUIFFontSize.heading.getFontSize(), weight: DCUIFWeight.medium.getFontWeight())
            self.textColor = DCUIFColor.Gray.getColor()
            break
        case DCUIFThemeLabelStyle.mediumGreen15.rawValue:
            self.font = UIFont.systemFont(ofSize: DCUIFFontSize.heading.getFontSize(), weight: DCUIFWeight.medium.getFontWeight())
            self.textColor = DCUIFColor.PrimaryGreen.getColor()
            break
        case DCUIFThemeLabelStyle.regularGrey15.rawValue:
            self.font = UIFont.systemFont(ofSize: DCUIFFontSize.heading.getFontSize(), weight: DCUIFWeight.regular.getFontWeight())
            self.textColor = DCUIFColor.MediumGray.getColor()
            break
        case DCUIFThemeLabelStyle.boldBlack12.rawValue:
            self.font = UIFont.systemFont(ofSize: DCUIFFontSize.paragraph.getFontSize(), weight: DCUIFWeight.bold.getFontWeight())
            self.textColor = DCUIFColor.PrimaryBlack.getColor()
            break
        case DCUIFThemeLabelStyle.regularGrey12.rawValue:
            self.font = UIFont.systemFont(ofSize: DCUIFFontSize.paragraph.getFontSize(), weight: DCUIFWeight.regular.getFontWeight())
            self.textColor = DCUIFColor.MediumGray.getColor()
            break
        case DCUIFThemeLabelStyle.mediumGrey12.rawValue:
            self.font = UIFont.systemFont(ofSize: DCUIFFontSize.paragraph.getFontSize(), weight: DCUIFWeight.medium.getFontWeight())
            self.textColor = DCUIFColor.Gray.getColor()
            break
        case DCUIFThemeLabelStyle.mediumWhite12.rawValue:
            self.font = UIFont.systemFont(ofSize: DCUIFFontSize.paragraph.getFontSize(), weight: DCUIFWeight.medium.getFontWeight())
            self.textColor = DCUIFColor.White.getColor()
            break
        case DCUIFThemeLabelStyle.mediumGreen12.rawValue:
            self.font = UIFont.systemFont(ofSize: DCUIFFontSize.paragraph.getFontSize(), weight: DCUIFWeight.medium.getFontWeight())
            self.textColor = DCUIFColor.PrimaryGreen.getColor()
            break
        case DCUIFThemeLabelStyle.mediumYellow12.rawValue:
            self.font = UIFont.systemFont(ofSize: DCUIFFontSize.paragraph.getFontSize(), weight: DCUIFWeight.medium.getFontWeight())
            self.textColor = DCUIFColor.Yellow.getColor()
            break
        case DCUIFThemeLabelStyle.mediumGrey10.rawValue:
            self.font = UIFont.systemFont(ofSize: DCUIFFontSize.paragraphSmall.getFontSize(), weight: DCUIFWeight.medium.getFontWeight())
            self.textColor = DCUIFColor.Gray.getColor()
            break
        case DCUIFThemeLabelStyle.mediumCharcoalGrey10.rawValue:
            self.font = UIFont.systemFont(ofSize: DCUIFFontSize.paragraphSmall.getFontSize(), weight: DCUIFWeight.medium.getFontWeight())
            self.textColor = DCUIFColor.CharcoalGrey.getColor()
            break
        case DCUIFThemeLabelStyle.regulaBlack12.rawValue:
            self.font = UIFont.systemFont(ofSize: DCUIFFontSize.paragraph.getFontSize(), weight: DCUIFWeight.medium.getFontWeight())
            self.textColor = DCUIFColor.PrimaryBlack.getColor()
            break
          case DCUIFThemeLabelStyle.regularWhite15.rawValue:
            self.font = UIFont.systemFont(ofSize: DCUIFFontSize.heading.getFontSize(), weight: DCUIFWeight.regular.getFontWeight())
             self.textColor = DCUIFColor.White.getColor()
          break
        case DCUIFThemeLabelStyle.DCUIFLabelTypeNone.rawValue:
            break
        default:
            self.font = UIFont.systemFont(ofSize: DCUIFFontSize.heading.getFontSize(), weight: DCUIFWeight.regular.getFontWeight())
            self.textColor = DCUIFColor.PrimaryBlack.getColor()
            break
        }
    }
    
    @IBInspectable public var labelTemeStyle: String = DCUIFThemeLabelStyle.DCUIFLabelTypeNone.rawValue {
        didSet {
            self.labelThemeIB = labelTemeStyle
            self.updateLabelStyle()
        }
    }
}

public enum DCUIFWeight: Int {
    case medium = 0
    case regular = 1
    case bold = 2
    
    public init() {
        self = .regular
    }
    
    public init(value: Int) {
        var result: DCUIFWeight = DCUIFWeight()
        switch value {
        case DCUIFWeight.regular.rawValue:
            result = .regular
        case DCUIFWeight.medium.rawValue:
            result = .medium
        case DCUIFWeight.bold.rawValue:
            result = .bold
        default:
            result = .regular
        }
        self = result
    }
    
    public func getFontWeight() -> UIFont.Weight {
        switch self {
        case .regular:
            return .regular
        case .medium:
            return .medium
        case .bold:
            return .bold
        }
    }
}

public enum DCUIFFontSize: Int {
    case mainHeading = 0
    case heading = 1
    case paragraph = 2
    case paragraphSmall = 3

    public init() {
        self = .heading
    }
    
    public init(value: Int) {
        var result: DCUIFFontSize = DCUIFFontSize()
        switch value {
        case DCUIFFontSize.mainHeading.rawValue:
            result = .mainHeading
        case DCUIFFontSize.heading.rawValue:
            result = .heading
        case DCUIFFontSize.paragraph.rawValue:
            result = .paragraph
        case DCUIFFontSize.paragraphSmall.rawValue:
            result = .paragraphSmall
        default:
            result = .heading
        }
        self = result
    }
    
    public func getFontSize() -> CGFloat {
        switch self {
        case .mainHeading:
            return 20
        case .heading:
            return 15
        case .paragraph:
            return 12
        case .paragraphSmall:
            return 10
        }
    }
}

    extension UIColor {
        convenience init(hexString: String) {
            let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int = UInt32()
            Scanner(string: hex).scanHexInt32(&int)
            let a, r, g, b: UInt32
            switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (255, 0, 0, 0)
            }
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
        }
    }

    extension UILabel {
        
        func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat {
            let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.font = font
            label.text = text
            
            label.sizeToFit()
            return label.frame.height
        }
        
    }
