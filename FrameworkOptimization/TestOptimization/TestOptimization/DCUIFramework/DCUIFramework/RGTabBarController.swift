//
//  RGTabBarController.swift
//  DCUIFramework
//
//  Created by Manoj Shivhare on 09/02/21.
//  Copyright © 2021 Abhinav Agarwal. All rights reserved.
//

import UIKit
public enum RGTabAlertControllerEnum: String {
  case CreateEvent = "Create Event"
  case CreateMeeting = "Create Meeting"
  case CreateCommunity = "Create Community"
  case CreatePost = "Create Post"
  case Cancel = "Cancel"
}
public protocol RGTabBarControllerDelegate: class {
  func openCreateMeeting()
  func openCreateWebinar()
  func openCreateCommunity()
  func openCreatePost()

}
open class RGTabBarController: UITabBarController {
  // MARK: - -------------Variables--------------
  public static var currentSelectedTabIndex: Int = 0
  open var completionHandler: ((UIViewController)-> Bool)?
  open var openCreateMeeting: (()-> Void)?
  open var openCreateWebinar: (()-> Void)?
  open var openCreateCommunity: (()-> Void)?
  open var openCreatePost: (()-> Void)?

  open weak var rgDelegate: RGTabBarControllerDelegate?
  // MARK: - -------------Life Cycle--------------
  override public func viewDidLoad() {
    super.viewDidLoad()
    tabBar.backgroundColor = UIColor.white;
    tabBar.isTranslucent = false
    tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
    tabBar.layer.shadowRadius = 3
    tabBar.layer.shadowColor = UIColor.black.cgColor
    tabBar.layer.shadowOpacity = 0.4
  }
  override public func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  // MARK: - ----------Public method--------------------
  public func openAlertPickerView() {
    let otherAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
    
    let createEvent = UIAlertAction(title: RGTabAlertControllerEnum.CreateEvent.rawValue, style: UIAlertActionStyle.default) {[weak self] _ in
      self?.openCreateWebinar?()
      //print("We can run a block of code." )
    }
    let eventImage = UIImage(named: "alert-calendar-icon")?.withRenderingMode(.alwaysOriginal)
    createEvent.setValue(eventImage, forKey: "image")
    
    let createMeeting = UIAlertAction(title: RGTabAlertControllerEnum.CreateMeeting.rawValue, style: UIAlertActionStyle.default, handler: {[weak self]_ in
      self?.openCreateMeeting?()
    })
    let meetingImage = UIImage(named: "alert-meeting-icon")?.withRenderingMode(.alwaysOriginal)
    createMeeting.setValue(meetingImage, forKey: "image")
    
    let createCommunity = UIAlertAction(title: RGTabAlertControllerEnum.CreateCommunity.rawValue, style: UIAlertActionStyle.default, handler: {[weak self]_ in
      self?.openCreateCommunity?()
    })
    let communityImage = UIImage(named: "alert-meeting-icon")?.withRenderingMode(.alwaysOriginal)
    createCommunity.setValue(communityImage, forKey: "image")
    let createPost = UIAlertAction(title: RGTabAlertControllerEnum.CreatePost.rawValue, style: UIAlertActionStyle.default, handler: {[weak self]_ in
      self?.openCreatePost?()
    })
    let postImage = UIImage(named: "alert-meeting-icon")?.withRenderingMode(.alwaysOriginal)
    createPost.setValue(postImage, forKey: "image")
    
    let dismiss = UIAlertAction(title: RGTabAlertControllerEnum.Cancel.rawValue, style: UIAlertActionStyle.cancel, handler: nil)
    
    // relate actions to controllers
    otherAlert.addAction(createEvent)
    otherAlert.addAction(createMeeting)
    otherAlert.addAction(createCommunity)
    otherAlert.addAction(createPost)
    otherAlert.addAction(dismiss)
    
    present(otherAlert, animated: true, completion: nil)
  }
}
extension RGTabBarController: UITabBarControllerDelegate{
  public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    if completionHandler?(viewController) == true {
      openAlertPickerView()
      return false
    }
    return true
  }
  public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
   
  }
}
