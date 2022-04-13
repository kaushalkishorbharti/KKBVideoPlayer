//
//  DCUIFNoDataView.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 25/05/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit

public class DCUIFNoDataView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var lblData: UILabel!
    public class  func getView(string:String) -> UIView {
    
    let view:DCUIFNoDataView = UINib(nibName: "NoDataView", bundle: DCUIFramework.bundle).instantiate(withOwner: nil, options: nil)[0] as! DCUIFNoDataView
        view.lblData.text = string;
    return view;
    }

}
