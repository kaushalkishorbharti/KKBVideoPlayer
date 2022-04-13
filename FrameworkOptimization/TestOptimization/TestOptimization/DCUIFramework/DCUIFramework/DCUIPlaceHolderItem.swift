//
//  DCUIPlaceHolderItem.swift
//  DCUIFramework
//
//  Created by kaushal kishor on 05/12/18.
//  Copyright © 2018 Abhinav Agarwal. All rights reserved.
//

import UIKit


public class DCUIPlaceHolderItem: NSObject {
   public var title:String = ""
   public var msg: String = ""
   public  var image:UIImage? = nil
   public var okButtonTitle = ""
   public var cancelbuttonTitle = ""
   public var okButtonImg:UIImage? = nil
   public var cancelButtonImg: UIImage? = nil
   public var target:Any? = nil
   public var isShowLoader: Bool = false
    
    public override init() {
        
    }
    
    public static func setData(title:String?,
                               msg: String?,
                               okBtnTitle: String?,
                               cancelBtnTitle: String?,
                               img: UIImage?,
                               isShowLoader: Bool,
                               okButtonImg: UIImage?,
                               cancelButtonImg: UIImage?) -> DCUIPlaceHolderItem{
        let model = DCUIPlaceHolderItem.init()
        model.title = title ?? ""
        model.msg = msg ?? ""
        model.okButtonTitle = okBtnTitle ?? ""
        model.cancelbuttonTitle = cancelBtnTitle ?? ""
        model.image = img
        model.isShowLoader = isShowLoader
        model.okButtonImg = okButtonImg
        model.cancelButtonImg = cancelButtonImg
        return model
    }
}
