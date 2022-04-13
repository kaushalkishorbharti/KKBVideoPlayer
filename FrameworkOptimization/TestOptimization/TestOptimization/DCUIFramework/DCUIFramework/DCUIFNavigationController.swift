//
//  DCUIFNavigationController.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 06/06/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//


import UIKit
//import DCUIFramework

public class DCUIFNavigationController: UINavigationController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
    }
    
    public static func goToAppRootScreen(_ selectedIndex: Int) {
        DCUIFViewController.getTopViewController().navigationController?.popToRootViewController(animated: false)
        DCUIFViewController.getTopViewController().navigationController?.tabBarController?.selectedIndex = selectedIndex
        DCUIFViewController.getTopViewController().navigationController?.popToRootViewController(animated: false)
    }
   
    override public func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: true)
        configNavigationBar()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc public static func rotationButton() -> UIBarButtonItem {
        let rotationImage:DCUIFImageView = DCUIFImageView()
        let moreImage:DCUIFImageView = DCUIFImageView()
        rotationImage.image = UIImage.init(named: DCUIFImageView.IMAGE_SCREEN_ROTATION_ICON, in: DCUIFramework.bundle, compatibleWith: nil)
        rotationImage.frame = CGRect.init(x: 0, y: 0, width: 25, height: 25)
        rotationImage.layer.masksToBounds = true
        
        rotationImage.image = rotationImage.image?.withRenderingMode(.alwaysTemplate)
        rotationImage.tintColor = UIColor.white
        
        moreImage.image = UIImage.init(named: DCUIFImageView.IMAGE_MORE_ICON, in: DCUIFramework.bundle, compatibleWith: nil)
        
        moreImage.image = moreImage.image?.withRenderingMode(.alwaysTemplate)
        moreImage.tintColor = UIColor.white
        
        moreImage.frame = CGRect.init(x: 0, y: 0, width: 25, height: 25)
        moreImage.layer.masksToBounds = true
        
        let tapviewRotationIcon = UITapGestureRecognizer(target: self,
                                                         action: #selector(changeScreenRotation(sender:)))
        rotationImage.addGestureRecognizer(tapviewRotationIcon)
         let barButton1 = UIBarButtonItem(customView: rotationImage)
        return barButton1   
    }
    
    @objc public static func notificationButton(target:AnyObject,
                                                selctor:Selector,
                                                notificationCount:String) -> UIBarButtonItem {
        let image = UIImage.init(named: "nav-tab-notification-black-small", in: DCUIFramework.bundle, compatibleWith: nil)
        let buttonFrame: CGRect = CGRect(x: 0, y: 0, width: 35, height: 35)
        let barButton = BadgedBarButtonItem(startingBadgeValue:notificationCount,frame:buttonFrame,image: image)
          barButton.tintColor = DCUIFTheme.sharedInstance.appTheme?.bgSecondryColor
        barButton.addTarget(target, action: selctor)
       return barButton
    }
   
    @objc public static func barButtonItemWithBadge(target:AnyObject,
                                                selctor:Selector,
                                                badgeCount:String,
                                                imageName: String) -> UIBarButtonItem {
        let image = UIImage.init(named: imageName, in: DCUIFramework.bundle, compatibleWith: nil)
        let buttonFrame: CGRect = CGRect(x: 0, y: 0, width: 35, height: 35)
        let barButton = BadgedBarButtonItem(startingBadgeValue:badgeCount,frame:buttonFrame,image: image)
        barButton.tintColor = DCUIFTheme.sharedInstance.appTheme?.bgSecondryColor
        barButton.addTarget(target, action: selctor)
        return barButton
    }
    
    @objc public static func filterButton(target:UIViewController,
                                          selctor:Selector) -> UIBarButtonItem {
        let button = UIBarButtonItem.init(image:UIImage.init(named: DCUIFImageView.IMAGE_NAV_TAB_FILTER, in: DCUIFramework.bundle, compatibleWith: nil), style:UIBarButtonItemStyle.plain , target:target, action:selctor)
        button.imageInsets = UIEdgeInsetsMake(0, 20, 0, -20)
        return button
    }
    
    @objc public static func removeViewControllerFromNaviation(vc:UIViewController,nav:UINavigationController){
        
        for i in 0..<nav.viewControllers.count{
            
            if(nav.viewControllers[i] == vc){
                nav.viewControllers.remove(at: i)
                break;
            }
            
        }
    }

    @objc public static func changeScreenRotation(sender:UITapGestureRecognizer) {
        let orientation = UIDevice.current.orientation
        if(orientation == .portrait ||
            orientation == .portraitUpsideDown) {
            let value = UIInterfaceOrientation.landscapeRight.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
            return
        }
        
        if (orientation == .landscapeLeft ||
            orientation == .landscapeRight ||
            orientation == .faceUp ||
            orientation == .unknown ){
            let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
            return
        }
    }
    
    @objc public static func changeOrientationToPortrait() {
        let orientation = UIDevice.current.orientation
        if(orientation == .landscapeLeft ||
            orientation == .landscapeRight){
            let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
            return
        }
    }
    
    public func configNavigationBar(){
        /* Setting Navigation Colour */
        
      self.navigationBar.barTintColor = RGUITheme.sharedInstance.appTheme?.primaryColor1
        self.navigationBar.tintColor = RGUITheme.sharedInstance.appTheme?.primaryColor1
        self.navigationBar.barTintColor = UIColor.white
        self.navigationBar.isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : DCUIFColor.PrimaryBlack.getColor()]
        
    }
    
    @objc public func closeNavigation() {
        self.dismiss(animated: true) {
        }
    }
    
    public func addCloseButton() -> Void {
        self.viewControllers[0].navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "cross_white", in: DCUIFramework.bundle, compatibleWith: nil), style: UIBarButtonItemStyle.plain, target: self, action: #selector(closeNavigation))
    }
    
    public func addBackButtonToNavigation() -> Void {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: DCUIFImageView.IMAGE_BACK_BUTTON, in: DCUIFramework.bundle, compatibleWith: nil), style: UIBarButtonItemStyle.plain, target: self, action: #selector(closeNavigation))
    }

    public static func addButtonToNavigation(buttonImage:UIImage,selctor:Selector,target:Any) -> UIBarButtonItem {
        let btn:UIBarButtonItem = UIBarButtonItem.init(title: "ADD", style: UIBarButtonItemStyle.plain, target: target, action: selctor)
        return btn
    }
    
    public static func addBackButtonToNavigation(selctor:Selector,target:Any) -> UIBarButtonItem {
     return UIBarButtonItem.init(image: UIImage.init(named: DCUIFImageView.IMAGE_BACK_BUTTON, in: DCUIFramework.bundle, compatibleWith: nil), style: UIBarButtonItemStyle.plain, target: target, action: selctor)
    }
    
    public static func addMoreButtonToNavigation(selctor:Selector,target:Any) -> UIBarButtonItem {
        return UIBarButtonItem.init(image: UIImage.init(named: "journal_more", in: DCUIFramework.bundle, compatibleWith: nil), style: UIBarButtonItemStyle.plain, target: target, action: selctor)
    }
    
    @objc public static func checkAndRemoveVCIfInStack(vc: AnyClass,nav:UINavigationController) -> Bool {
        var index:Int = 0
        for element in nav.viewControllers {
            if (element.isKind(of: vc)) {
                if(index == nav.viewControllers.count-1){
                    index = index + 1
                    continue;
                }
                nav.viewControllers.remove(at: index)
                break
            }
            index = index + 1
        }
        return false
    }
    
    @objc public static func isNavigationControllerInStack(vc: AnyClass,
                                                           nav:UINavigationController) -> Bool{
        for element in nav.viewControllers {
            if (element.isKind(of: vc)) {
                return true
            }
        }
        return false
    }
    
   @objc public static func backToViewController(vc: AnyClass,
                                                 nav:UINavigationController) {
        // iterate to find the type of vc
        for element in nav.viewControllers {
            if (element.isKind(of: vc)) {
                nav.popToViewController(element, animated: true)
                break
            }
        }
    }
    
    @objc public static func backToViewController(vc: AnyClass,
                                                  nav:UINavigationController, animated: Bool) {
        // iterate to find the type of vc
        for element in nav.viewControllers {
            if (element.isKind(of: vc)) {
                nav.popToViewController(element, animated: animated)
                break
            }
        }
    }
    
    @objc public static func checkViewControllerInStack(vc: AnyClass,
                                                        nav:UINavigationController) -> Bool {
        // iterate to find the type of vc
        for element in nav.viewControllers {
            if (element.isKind(of: vc)) {
               return true
            }
        }
        return false
    }

    @objc public static func infoButton(target:UIViewController,
                                        selctor:Selector,
                                        image:UIImage) -> UIBarButtonItem {
        let button = UIBarButtonItem.init(image:image, style:UIBarButtonItemStyle.plain , target:target, action:selctor)
        return button
    }
    
    @objc public static func buttonWithTitleAndImage(target:UIViewController,
                                                     selctor:Selector,
                                                     image:UIImage,
                                                     title:String) -> UIBarButtonItem {
        let button = UIBarButtonItem.init(image:image, style:UIBarButtonItemStyle.plain , target:target, action:selctor)
        button.title = title
        return button
    }

    @objc public static func countryButton(target:UIViewController,
                                           selctor:Selector,
                                           image:UIImage) -> UIBarButtonItem {
        let button = UIBarButtonItem.init(image:image, style:UIBarButtonItemStyle.plain , target:target, action:selctor)
        button.imageInsets = UIEdgeInsetsMake(0, 20, 0, -20)
        return button
    }
}



public protocol DCFUINavigationProtocol where Self: UIViewController {
    
}

public extension DCFUINavigationProtocol {
    
    func getProfileBarButtomItemImage(_ image: UIImage,
                                      _ bgColor: UIColor?,
                                      _ selector: Selector) -> UIBarButtonItem {
        let rubricButton  = UIButton(type: UIButtonType.system)
        rubricButton.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        rubricButton.backgroundColor = bgColor ?? UIColor.clear
        rubricButton.setImage(image.withRenderingMode(.alwaysOriginal), for: UIControlState())
        rubricButton.tintColor = UIColor.red
        rubricButton.addTarget(self, action: selector, for: .touchUpInside)
        rubricButton.setBorderWith(0, 15, UIColor.clear)
       // rubricButton.layer.cornerRadius = 15
        rubricButton.layer.masksToBounds = true
        return UIBarButtonItem(customView: rubricButton)
        
    }
    
    func getTextBarButtomItem(_ text: String,
                              _ textColor: UIColor = UIColor.black) -> UIBarButtonItem {
        let longTitleLabel = UILabel()
        longTitleLabel.text = text
        longTitleLabel.textColor = textColor
        longTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        longTitleLabel.sizeToFit()
        return UIBarButtonItem(customView: longTitleLabel)
    }
    
    func getTextBarButtomItemWithSelector(_ text: String,
                              _ textColor: UIColor = UIColor.black,
                              _ selector: Selector) -> UIBarButtonItem {
        
        return UIBarButtonItem.init(title: text, style: .plain, target: self, action: selector)
    }
    
    func showNavigation() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func getImageAndTextBarButton(_ image: UIImage, _ title: String,
                                  _ selector: Selector, _ isImgRight: Bool) -> UIBarButtonItem {
        let tempButton = UIButton.init(type: .system);
        tempButton.setImage(image, for: .normal);
        tempButton.setTitle(title, for: UIControlState())
        tempButton.addTarget(self, action:selector, for: .touchUpInside);
        tempButton.semanticContentAttribute = .forceRightToLeft
        tempButton.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        let barItem = UIBarButtonItem.init(customView: tempButton)
        return barItem
    }
    
    func getImageBarButton(_ image: UIImage,
                           _ selector: Selector) -> UIBarButtonItem {
//        let tempButton = UIButton.init(type: .system);
//        tempButton.setImage(image, for: .normal);
//        tempButton.addTarget(self, action:selector, for: .touchUpInside);
        
       
        
        let barbutton = UIBarButtonItem.init(image:image, style: UIBarButtonItemStyle.plain, target:self, action: selector)
        barbutton.tintColor = UIColor.black;
       
        
        
        
//        let barItem = UIBarButtonItem.init(image:  image.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: selector)
        return barbutton
    }
    
    func getImageBarButtonWithoutView(_ image: UIImage,
                           _ selector: Selector,
                           _ target: Any?) -> UIBarButtonItem {
//        let tempButton = UIButton.init(type: .system);
//        tempButton.setImage(image, for: .normal);
//        tempButton.addTarget(self, action:selector, for: .touchUpInside);
//        let barItem = UIBarButtonItem.init(customView: tempButton)
//
        
         let barItem = UIBarButtonItem.init(image:  image, style: .plain, target: target, action: selector)
        return barItem
    }
    
    func setBackButton(_ backSelector: Selector?) {
        self.navigationItem.hidesBackButton = true
        let backItem = UIBarButtonItem.init(image:  UIImage.init(named: "nav-back-blue", in: DCUIFramework.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: backSelector)
        self.navigationItem.setLeftBarButton(backItem, animated: true)
    }
    
    func setBackButtonWithCrossButton(_ backSelector: Selector?, _ imageName: String? = nil) {
        self.navigationItem.setRightBarButton(nil, animated: true)
        self.navigationItem.hidesBackButton = true
        var image = UIImage.init(named: "icon-cross-black", in: DCUIFramework.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
        if let imageName = imageName {
            image = UIImage.init(named: imageName, in: DCUIFramework.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
        }
        let backItem = UIBarButtonItem.init(image: image, style: .plain, target: self, action: backSelector)
        self.navigationItem.setLeftBarButton(backItem, animated: true)
    }
    
    func setBackButtonWithCrossButtonAndRightRotateBtn(_ backSelector: Selector?, _ imageName: String? = nil,_ rightSelector: Selector?, _ rightImageName: String? = nil) {
        self.navigationItem.hidesBackButton = true
        var image = UIImage.init(named: "icon-cross-black", in: DCUIFramework.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
        if let imageName = imageName {
            image = UIImage.init(named: imageName, in: DCUIFramework.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
        }
        let backItem = UIBarButtonItem.init(image: image, style: .plain, target: self, action: backSelector)
        self.navigationItem.setLeftBarButton(backItem, animated: true)
        
        let rotateImg = UIImage.init(named: "roatate_image", in: DCUIFramework.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
        
        let rotateItem = UIBarButtonItem.init(image: rotateImg, style: .plain, target: self, action: rightSelector)
        self.navigationItem.setRightBarButton(rotateItem, animated: true)
    }
    
    func setBackButtonWithTitle(_ title: String,_ backSelector: Selector?) {
        self.navigationItem.hidesBackButton = true
        let backItem = UIBarButtonItem.init(title: title, style: .plain, target: self, action: backSelector)
        backItem.tintColor = UIColor.black
        self.navigationItem.setLeftBarButton(backItem, animated: true)
    }
    
    func setRightButtonWithTitle(_ title: String,_ backSelector: Selector?, color: UIColor? = UIColor.black) {
        self.navigationItem.hidesBackButton = true
        let backItem = UIBarButtonItem.init(title: title, style: .plain, target: self, action: backSelector)
        backItem.tintColor = color
        backItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor :UIColor.black], for: UIControlState.normal)
        self.navigationItem.setRightBarButton(backItem, animated: true)
    }
    
    func removeBottomHairLine() {
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    func addBottomHairLine() {
        self.navigationController?.navigationBar.setValue(false, forKey: "hidesShadow")
    }

}
