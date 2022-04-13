//
//  DCUIFViewControllerVM.swift
//  DCUIFramework
//
//  Created by kaushal kishor on 06/12/18.
//  Copyright © 2018 Abhinav Agarwal. All rights reserved.
//

import UIKit


@objc public enum DCUIFViewControllerState :Int{
    
    case loading
    case error
    case success
    case noData
    case none
    
}

 open class DCUIFViewControllerVM: NSObject {
    
    public var loadingState:DCUIPlaceHolderItem?;
    public var errorState:DCUIPlaceHolderItem?;
    public var successState:DCUIPlaceHolderItem?;
    public var noDataState:DCUIPlaceHolderItem?;
    public var noneState:DCUIPlaceHolderItem?;
    
    public var state:DCUIFViewControllerState = DCUIFViewControllerState.none;
    
    
    public override init() {
        
        let image = UIImage.init(named: "icon-chat-search-placeholder", in: DCUIFramework.bundle, compatibleWith: nil);
        self.loadingState = DCUIPlaceHolderItem.setData(title: "Loading", msg: "sfsd", okBtnTitle: "OK", cancelBtnTitle: "Cancel", img: image, isShowLoader: true, okButtonImg: nil, cancelButtonImg: nil);
        self.errorState = DCUIPlaceHolderItem.setData(title: "Error", msg: "sfsddfsdfsdfdsfsdfdsfsdfdsfsdfdsfdsfsdfdsdfdsfddsfdsfdsfdsfsdfdsfdsfdsfs", okBtnTitle: "OK", cancelBtnTitle: "Cancel", img: image, isShowLoader: false, okButtonImg: nil, cancelButtonImg: nil);
        self.successState = DCUIPlaceHolderItem.setData(title: "Success", msg: "sfsd", okBtnTitle: "OK", cancelBtnTitle: "Cancel", img: image, isShowLoader: false, okButtonImg: nil, cancelButtonImg: nil);
        self.noDataState = DCUIPlaceHolderItem.setData(title: "No Data", msg: "sfsd", okBtnTitle: "OK", cancelBtnTitle: "Cancel", img: image, isShowLoader: false, okButtonImg: nil, cancelButtonImg: nil);
        self.noneState = DCUIPlaceHolderItem.setData(title: "None", msg: "sfsd", okBtnTitle: "OK", cancelBtnTitle: "Cancel", img: image, isShowLoader: false, okButtonImg: nil, cancelButtonImg: nil);
        
        //self.setViewState(state: .loading);
    }
    
}
