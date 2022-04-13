//
//  DCUIReferralNavItem.swift
//  DCUIFramework
//
//  Created by Arimardan Singh on 22/08/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit


public class DCUIReferralNavItem: UIView
{

    @IBOutlet weak var lblNoOfPoints: UILabel!
    @IBOutlet weak var pointsLbl: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
   @objc public static func getView(noOfPoints:String, point:String) -> DCUIReferralNavItem
    {
        let view: DCUIReferralNavItem = (UINib(nibName: "DCUIReferralNavItem", bundle: DCUIFramework.bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView)! as! DCUIReferralNavItem
        view.frame = CGRect(x: 0, y: 0, width: 70, height: 45);
        view.lblNoOfPoints.text = noOfPoints;
        view.lblNoOfPoints.textColor =  DCUIFTheme.sharedInstance.appTheme?.secondaryColor;
        view.pointsLbl.text = point;
        view.backgroundColor = UIColor.clear;
        return view;
    }
    
}
