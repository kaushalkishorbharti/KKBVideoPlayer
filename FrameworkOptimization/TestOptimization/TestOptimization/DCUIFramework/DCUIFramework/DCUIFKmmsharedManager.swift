//
//  DCUIFKmmsharedManager.swift
//  DCUIFramework
//
//  Created by kaushal kishor on 08/09/20.
//  Copyright © 2020 Abhinav Agarwal. All rights reserved.
//

import Foundation
//import kmmsharedmodule

public class DCUIFKmmsharedManager:NSObject{

//public static let shared:DCUIFKmmsharedManager = DCUIFKmmsharedManager()
 // public var afLoging: AFLoging?
  
  private override init() {
      super.init()
    
    
  }
  
  public func initializeWith(trackId id: String) {
    let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
   // afLoging = AFLoging.init(isLocalLoggingEnable: true, isRemoteLoggingEnable: true, trackId: id, appVersion: appVersion, host: "docquity.ios", serverAddess: "http://52.221.245.216:12201/gelf")
    
  }
  
  public func setTrackId(id: String) {
   // afLoging?.setTrackId(trackId: id)
  }
  
}
