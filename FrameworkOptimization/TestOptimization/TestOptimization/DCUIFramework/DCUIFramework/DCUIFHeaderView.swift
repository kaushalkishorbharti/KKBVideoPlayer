//
//  DCUIFHeaderView.swift
//  DCUIFramework
//
//  Created by kaushal kishor on 08/01/19.
//  Copyright © 2019 Abhinav Agarwal. All rights reserved.
//

import UIKit

public enum DCUIFHeaderViewType: String {
    case OnlyTitle = "OnlyTitle",
    TitleWithBtn = "TitleWithBtn",
    OnlyTitleWithLeftPadding = "OnlyTitleWithLeftPadding",
    SeperatorStrip = "SeperatorStrip"
}

public class DCUIFHeaderView: UIView {

    @IBOutlet weak var viewRoot: UIView!
    @IBOutlet weak var viewTopHeader: UIView!
    //Only Title Outlet
    @IBOutlet weak var viewOnlyTitle: UIView!
    @IBOutlet weak var lblTitle: DCUIFActiveThemeLabel!
    @IBOutlet weak var viewSeperator: UIView!
    @IBOutlet weak var lblCounter: DCUIFActiveThemeLabel!
    //TitleWithBtnOutlet
    @IBOutlet weak var viewTitleWithBtn: UIView!
    @IBOutlet weak var twbTitle: DCUIFActiveThemeLabel!
    @IBOutlet weak var twbSubtitle: DCUIFActiveThemeLabel!
    @IBOutlet weak var twbBtnAction: DCUIFThemeButton!
    
    @IBAction func twbBtnActionClicked(_ sender: DCUIFThemeButton) {
    }
    
    @IBOutlet weak var viewOnlyTitleWithExtrLeftPadding: UIView!
    @IBOutlet weak var lblTitleWithExtrLeftPadding: DCUIFActiveThemeLabel!
    
    @IBOutlet weak var viewStrip: UIView!
    
    public override func awakeFromNib() {
        commonInit()
    }
    
    func commonInit() {
        viewSeperator.backgroundColor = DCUIFColor.Seperator.getColor()
        lblCounter.padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        lblCounter.layer.cornerRadius = 5
    }
    
  public static func getView(title titleText: String,subtitle subTitleText: String = "",isShowSeperator showSeperator: Bool, totalNo count: Int = 0, counterBGColor bgColor: UIColor = DCUIFColor.PrimaryRed.getColor(),bwtImg btnImg: String = "",btnTitle bwtTitle: String = "",viewType type: DCUIFHeaderViewType, topStripColor stripColor: UIColor = DCUIFColor.TblBgColor.getColor()) -> DCUIFHeaderView  {
        let view:DCUIFHeaderView = (UINib(nibName: "DCUIFHeaderView", bundle: DCUIFramework.bundle).instantiate(withOwner: nil, options: nil)[0] as? DCUIFHeaderView)!
        
        view.viewSeperator.isHidden = true
        if showSeperator {
            view.viewSeperator.isHidden = false
        }
        view.viewTopHeader.backgroundColor = stripColor
          //DCUIFColor.TblBgColor.getColor()
        view.lblCounter.isHidden = true
        switch type {
        case .OnlyTitle:
            view.viewOnlyTitle.isHidden = false
            view.viewTitleWithBtn.isHidden = true
            view.viewOnlyTitleWithExtrLeftPadding.isHidden = true
            view.viewStrip.isHidden = true

            view.lblTitle.text = titleText
            if count > 0 {
                view.lblCounter.isHidden = false
                view.lblCounter.backgroundColor = bgColor
                view.lblCounter.text = "\(count)"
            }
            break
        case .TitleWithBtn:
            view.viewOnlyTitle.isHidden = true
            view.viewTitleWithBtn.isHidden = false
            view.viewOnlyTitleWithExtrLeftPadding.isHidden = true
            view.viewStrip.isHidden = true
            view.twbTitle.text = titleText
            view.twbSubtitle.text = subTitleText
            view.twbBtnAction.setImage(UIImage.init(named: btnImg, in: DCUIFramework.bundle, compatibleWith: nil), for: UIControlState())
            view.twbBtnAction.setTitle(bwtTitle, for: UIControlState())
            view.twbBtnAction.titleLabel?.lineBreakMode = .byTruncatingTail
            //view.twbBtnAction.sizeToFit()
            view.layoutSubviews()
            view.layoutIfNeeded()
            view.twbBtnAction.tintColor = DCUIFColor.Gray.getColor()
            break
        case .OnlyTitleWithLeftPadding:
            view.viewOnlyTitle.isHidden = true
            view.viewTitleWithBtn.isHidden = true
            view.viewStrip.isHidden = true
            view.viewOnlyTitleWithExtrLeftPadding.isHidden = false
            view.lblTitleWithExtrLeftPadding.text = titleText
            view.viewOnlyTitleWithExtrLeftPadding.backgroundColor = DCUIFColor.SuperLightGray.getColor()
            view.viewTopHeader.backgroundColor = DCUIFColor.SuperLightGray.getColor()
            view.viewSeperator.backgroundColor = DCUIFColor.SuperLightGray.getColor()
            break
        case .SeperatorStrip:
            view.viewOnlyTitle.isHidden = true
            view.viewTitleWithBtn.isHidden = true
            view.viewOnlyTitleWithExtrLeftPadding.isHidden = true
            view.viewStrip.isHidden = false
            view.viewStrip.backgroundColor = DCUIFColor.TblBgColor.getColor()
            break
        }
       return view
    }
}
