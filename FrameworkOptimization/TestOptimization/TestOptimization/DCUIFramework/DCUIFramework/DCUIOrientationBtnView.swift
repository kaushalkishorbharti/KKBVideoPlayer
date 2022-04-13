//
//  JournalOrientationBtnView.swift
//  DCUIFramework
//
//  Created by Arimardan Singh on 30/08/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit

public class DCUIOrientationBtnView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    @IBOutlet weak var btnMoreImg:DCUIFImageView!
   
    public static func getView() -> DCUIOrientationBtnView
    {
        let view: DCUIOrientationBtnView = (UINib(nibName: "DCUIOrientationBtnView", bundle: DCUIFramework.bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView)! as! DCUIOrientationBtnView
        view.frame = CGRect(x: 0, y: 0, width: 70, height: 45);
       // view.btnMoreImg = UIImage.init(named: DCUIFImageView.IMAGE_AVATAR, in: DCUIFramework.bundle, compatibleWith: nil)!
        
        return view;
    }


}
