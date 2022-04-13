//
//  DCUIToastManage.swift
//  DCUIFramework
//
//  Created by Harsh Jaiswal on 30/10/20.
//  Copyright © 2020 Abhinav Agarwal. All rights reserved.
//

import Foundation
import SwiftMessages
public class DCUIToastManager:NSObject{

public static let shared:DCUIToastManager = DCUIToastManager()
  
  
  private override init() {
      super.init()
  }
    
    public func openToast(message: String, image: String) {
        SwiftMessages.sharedInstance.hide()
        let bundle = Bundle.init(identifier: "com.docquity.DCUIFramework")
        let view: DCUIToast = try! SwiftMessages.viewFromNib(named: "DCUIToast", bundle: bundle!)
//        let viewModel : DCUIToastVM = DCUIToastVM()
//        viewModel.title?.value = message
//        viewModel.image?.value = image
        view.bindViewModel(message: message, image: image)
        SwiftMessages.sharedInstance.defaultConfig.presentationStyle = .bottom
        SwiftMessages.sharedInstance.show(view: view)
    }
}
