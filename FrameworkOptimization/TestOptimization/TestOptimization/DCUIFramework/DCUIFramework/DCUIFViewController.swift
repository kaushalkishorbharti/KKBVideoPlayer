//
//  DCUIFViewController.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 23/05/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit
import Foundation

public protocol DCUIFViewControllerProtocol {
    func serviceCaller()
}



@objc open class DCUIFViewController: UIViewController, DCUIPlaceholderViewDelegate {

    open func okClicked() {
        self.customPlaceHolderUI?.removeFromSuperview()
    }

    open func cancelClicked() {
        self.customPlaceHolderUI?.removeFromSuperview()
    }

    
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
           
            let orient = UIApplication.shared.statusBarOrientation
            let dict = ["orientation":orient]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DeviceOrientationChnaged"), object: self, userInfo: dict)
//            switch orient {
//            case .Portrait:
//
//            case :
//
//            // Do something
//            default:
//               break
//            }
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            
           
        })
        
        super.viewWillTransition(to: size, with: coordinator)
        
    }
    
   

    @objc public var screenName: String = ""
    @objc public var eventScreenName: String = ""
    @objc public var visitEvent: Any?
    @objc public var goingForward: Bool = false
    //public var activeScrollView: UIScrollView?
    //public var activeFeild: UIView?
    public var visitStartTime: Double?
    public var screenIdentifier: String = ""
    public var customPlaceHolderUI: DCUIPlaceholderView?

    open var parentModel: DCUIFViewControllerVM?
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backItem?.title = ""
        parentModel = DCUIFViewControllerVM.init()
        self.customPlaceHolderUI = DCUIPlaceholderView.init(frame: self.view.frame)
        self.customPlaceHolderUI?.delegate = self
        registerBackgroundTask()
        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(screenshotDetected), name: Notification.Name.UIApplicationUserDidTakeScreenshot, object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("UpdateOnlineStatus"), object: nil, userInfo: nil);
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIApplicationUserDidTakeScreenshot, object: nil)
    }
    
    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
        assert(backgroundTask != UIBackgroundTaskInvalid)
    }

    func endBackgroundTask() {
       // print("Background task ended.")
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskInvalid
    }
    
    @objc func screenshotDetected() {
        
    }

    public func setViewState(state: DCUIFViewControllerState) {

        switch state {
        case .error:
            self.customPlaceHolderUI?.configureData(data: (parentModel?.errorState!)!)
            self.parentModel?.state = .error
            self.view.addSubview(self.customPlaceHolderUI!)
            break
        case .loading:
            self.customPlaceHolderUI?.configureData(data: (parentModel?.loadingState!)!)
            self.parentModel?.state = .loading
            self.view.addSubview(self.customPlaceHolderUI!)
            break
        case .success:
            self.customPlaceHolderUI?.configureData(data: (parentModel?.successState!)!)
            self.parentModel?.state = .success
            self.view.addSubview(self.customPlaceHolderUI!)
            break
        case .noData:
            self.customPlaceHolderUI?.configureData(data: (parentModel?.noDataState!)!)
            self.parentModel?.state = .noData
            self.view.addSubview(self.customPlaceHolderUI!)
            break
        case .none:
            self.customPlaceHolderUI?.configureData(data: (parentModel?.noneState!)!)
            self.parentModel?.state = .none
            self.view.addSubview(self.customPlaceHolderUI!)
            break
        default:
            break

        }

    }
    @objc func keyboardWasShown(_ aNotification: Notification) {
        return
//        let info = aNotification.userInfo
//        let kbSize: CGSize? = (info?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue?.size
//        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, (kbSize?.height)!, 0.0)
//        //UIScrollView.contentInset = contentInsets
//        activeScrollView?.scrollIndicatorInsets = contentInsets
//        // If active text field is hidden by keyboard, scroll it so it's visible
//        // Your app might not need or want this behavior.
//        var aRect: CGRect = view.frame
//        aRect.size.height -= (kbSize?.height)!
//        if !aRect.contains((activeFeild?.frame.origin)!) {
//            activeScrollView?.scrollRectToVisible((activeFeild?.frame)!, animated: true)
//        }
    }

    // Called when the UIKeyboardWillHideNotification is sent
    @objc func keyboardWillBeHidden(_ aNotification: Notification) {
//        return
//        let contentInsets = UIEdgeInsets.zero
//        activeScrollView?.contentInset = contentInsets
//        activeScrollView?.scrollIndicatorInsets = contentInsets
    }


    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    @objc public class func getTopViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController {
        if let navigationController = controller as? UINavigationController {
            return getTopViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return getTopViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return getTopViewController(controller: presented)
        }
        NSLog("%@", controller ?? "No Controller")
        if (controller == nil) {
            let windows = UIApplication.shared.windows
            if (windows.count > 1) {
                if(windows[0].rootViewController != nil) {
                    return windows[0].rootViewController!
                } else if (windows.last?.rootViewController != nil) {
                    return windows.last!.rootViewController!
                } else {
                    return UIViewController.init()
                }
            }
        }
        return controller!
    }
    
  @objc public class func removeControllerFromNavigation(controller: UIViewController) {
   guard let navigationController = controller.navigationController else { return }
    var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
    navigationArray.enumerated().forEach { (index,vc) in
      var previousVC: UIViewController?
      if vc == controller {
        if (index - 1) >= 0 {
           previousVC = navigationArray[index - 1]
        }
        navigationArray.remove(at: index) // To remove particular UIViewController
        previousVC?.navigationController?.setViewControllers(navigationArray, animated: false)
      }
    }
  }

  
  
    @objc public class func getTopViewControllerScreenName(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> String {
        if let topViewController = DCUIFViewController.getTopViewController() as? DCUIFViewController {
            return topViewController.eventScreenName
        }
        return ""
    }

    public static func presentAlertTypeViewVC(vc: UIViewController, isAnimated: Bool = false) {
        vc.definesPresentationContext = true
        if #available(iOS 10.0, *) {
            vc.view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.75)
        } else {
        }
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        if let tabBarController = self.getTopViewController().tabBarController {
            tabBarController.present(vc, animated: isAnimated, completion: nil)
        } else {
            self.getTopViewController().present(vc, animated: isAnimated, completion: nil)
        }
        
    }
}


