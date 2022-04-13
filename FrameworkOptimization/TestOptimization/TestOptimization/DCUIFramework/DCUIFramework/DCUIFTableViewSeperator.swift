//
//  DCUIFTableViewSeperator.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 08/09/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit

@objc public class DCUIFTableViewSeperator: UIView {

    
    
  @objc public init(frame:CGRect,height:CGFloat,color:UIColor) {
        
        super.init(frame:CGRect(x: frame.origin.x, y: frame.size.height - height, width: frame.width, height: height));
        self.backgroundColor =  color;
       
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
