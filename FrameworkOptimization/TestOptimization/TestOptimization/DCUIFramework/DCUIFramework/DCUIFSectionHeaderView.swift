//
//  DCUIFSectionHeaderView.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 29/06/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit

public class DCUIFSectionHeaderView: UIView {

    @IBOutlet weak var view: DCUIFView!
    @IBOutlet weak var lblLeft: DCUIFLabel!
    @IBOutlet weak var rightView: DCUIFLabel!

    @IBOutlet weak var viewFeed: DCUIFView!
    @IBOutlet weak var lblLeftSide: DCUIFActiveThemeLabel!
    @IBOutlet weak var btnRightSide: DCUIFButton!

    @IBOutlet weak var headerView: DCUIFView!
    @IBOutlet weak var headerLbl: DCUIFLabel!
    @IBOutlet weak var headerSepLbl: DCUIFLabel!
    @IBOutlet weak var footerView: DCUIFView!
    @IBOutlet weak var fotterBtn: DCUIFButton!

    @IBOutlet weak var cmeSepraterView: DCUIFView!
    @IBOutlet weak var contrainTitleLeading: NSLayoutConstraint!
    @IBOutlet weak var viewCenterText: UIView!
    @IBOutlet weak var lblCenterText: DCUIFActiveThemeLabel!
    @IBOutlet weak var viewBottomSeperator: UIView!

    public enum HeaderFooterType: Int {
        /// check enum type for view
        case TitleDescription = 1,
            Title = 2,
            Button = 3,
            Blank = 4,
            TitleAnotherDescription = 5,
            NoContentFooter = 6,
            WhiteBackground = 7,
            NoContentFooterWithWhiteBackground = 8,
            WhiteBackgroundCenterAlign = 9
    }

    override public func awakeFromNib() {
        self.lblLeftSide.textColor = DCUIFTheme.sharedInstance.appTheme!.extraColor_2
        self.btnRightSide.backgroundColor = UIColor.clear
        self.btnRightSide.titleLabel?.textColor = DCUIFTheme.sharedInstance.appTheme?.buttonPriamryColor
        commonInit()
    }
    
    func commonInit() {
        self.viewFeed.backgroundColor = DCUIFTheme.sharedInstance.appTheme?.bgPrimaryColor
        self.view.backgroundColor = DCUIFTheme.sharedInstance.appTheme?.extraColor_1
        self.cmeSepraterView.backgroundColor = DCUIFTheme.sharedInstance.appTheme?.bgPrimaryColor
        self.headerView.backgroundColor = DCUIFTheme.sharedInstance.appTheme?.bgSecondryColor
    }

    func makeNoContentView(text: String) {
        self.viewCenterText.isHidden = false
        self.lblCenterText.text = text
        if(text == "NO_CME_DASHBOARD_LIST_MSG".localized(withComment: "")) {
            self.viewCenterText.backgroundColor = UIColor.white
        }
    }

    func makeNoContentViewWhiteBackground(text: String) {
        self.viewCenterText.isHidden = false
        self.lblCenterText.text = text
        if(text == "NO_CME_DASHBOARD_LIST_MSG".localized(withComment: "")) {
            self.viewCenterText.backgroundColor = UIColor.white
        }
        self.viewCenterText.backgroundColor = UIColor.white
    }
    
    @objc public static func getView(type: Int,
                                     primaryText: String,
                                     secondryText: String,
                                     verticalLine: Bool,
                                     target: UIViewController?,
                                     selector: Selector?,
                                     isShowBottomSeperator: Bool = false) -> DCUIFSectionHeaderView {
        let view: DCUIFSectionHeaderView = (UINib(nibName: "DCUIFSectionHeaderView", bundle: DCUIFramework.bundle).instantiate(withOwner: nil, options: nil)[0] as? DCUIFSectionHeaderView)!
        view.backgroundColor = UIColor.red
        view.layer.borderWidth = 0
        view.viewFeed.isBorder = false
        view.footerView.isBorder = false
        view.commonInit()
        view.makeAllHidden()

        if((selector) != nil) {
            view.btnRightSide.addTarget(target, action: selector!, for: UIControlEvents.touchUpInside)
        }
        if isShowBottomSeperator {
            view.viewBottomSeperator.isHidden = false
        } else {
            view.viewBottomSeperator.isHidden = true
        }
        
        switch type {
        case HeaderFooterType.TitleDescription.rawValue:
            view.makeTitleDescription(leftText: primaryText, rightText: secondryText)
            break
        case HeaderFooterType.NoContentFooter.rawValue:
            view.makeNoContentView(text: primaryText)
            break
        case HeaderFooterType.Title.rawValue:
            view.makeTitle(headerTitleText: primaryText, showVerticalLine: verticalLine)
            break
        case HeaderFooterType.Blank.rawValue:
            view.makeBlank()
            break
        case HeaderFooterType.TitleAnotherDescription.rawValue:
            view.makeTitleAnotherDescription(leftText: primaryText, rightText: secondryText)
            break
        case HeaderFooterType.WhiteBackground.rawValue:
            view.makeWhiteBackgroundWithTitle(leftText: primaryText)
            break
        case HeaderFooterType.NoContentFooterWithWhiteBackground.rawValue:
            view.makeNoContentViewWhiteBackground(text: primaryText)
            break
        case HeaderFooterType.WhiteBackgroundCenterAlign.rawValue:
            view.makeWhiteBackgroundWithTitleCenterAllign(leftText: primaryText)
            break
        default:
            break
        }
        return view
    }

    func makeTitleDescription(leftText: String, rightText: String) {
        lblLeft.text = leftText
        rightView.text = rightText
        self.view.isHidden = false
    }

    func makeTitle(headerTitleText: String, showVerticalLine: Bool) {
        if (showVerticalLine == true) {
        } else {
            self.contrainTitleLeading.constant = -6
            self.updateConstraints()
        }
        self.headerLbl.text = headerTitleText
        self.headerView.isHidden = false
    }

    func makeBlank() {
        self.cmeSepraterView.isHidden = false
        self.cmeSepraterView.backgroundColor = DCUIFTheme.sharedInstance.appTheme?.bgPrimaryColor
        self.cmeSepraterView.isBorder = false
    }

    func makeTitleAnotherDescription(leftText: String, rightText: String) {
        lblLeftSide.text = leftText
        self.btnRightSide.setTitle(rightText, for: UIControlState.normal)
        self.viewFeed.isHidden = false
        self.viewFeed.backgroundColor = UIColor.white
    }

    func makeWhiteBackgroundWithTitle(leftText: String) {
        lblLeftSide.text = leftText
        self.btnRightSide.isHidden = true
        self.viewFeed.isHidden = false
        self.viewFeed.backgroundColor = UIColor.white
    }

    func makeWhiteBackgroundWithTitleCenterAllign(leftText: String) {
        lblLeftSide.text = leftText
        lblLeftSide.textAlignment = .center
        self.btnRightSide.isHidden = true
        self.viewFeed.isHidden = false
        self.viewFeed.backgroundColor = UIColor.white
    }

    func makeAllHidden() {
        self.view.isHidden = true
        self.headerView.isHidden = true
        self.footerView.isHidden = true
        self.cmeSepraterView.isHidden = true
        self.viewFeed.isHidden = true
        self.viewCenterText.isHidden = true
    }

    @IBAction func clickButton(_ sender: Any) {
    }
}

