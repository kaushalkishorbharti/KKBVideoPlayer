//
//  DCUITabBarController.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 13/10/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit

@objc public class DCUITabBarController: UITabBarController, UITabBarControllerDelegate {

    var middleButtonIndex:Int = 0;
    public static var currentSelectedTabIndex: Int = 0;

    var menuButton:UIButton!;
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = UIColor.white;
        self.tabBar.isTranslucent = false;
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
    }
    
    

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    @objc public func setupMiddleButton(image:UIImage, middleButtonIndex:Int) {
         menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        self.middleButtonIndex =  middleButtonIndex;
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = self.tabBar.bounds.origin.y - menuButtonFrame.height/3
        menuButtonFrame.origin.x = self.tabBar.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        
        menuButton.backgroundColor = UIColor.white
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        self.tabBar.addSubview(menuButton)
        
        menuButton.setImage(image, for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        makeShadow();
        view.layoutIfNeeded()
    }
    
    func makeBrezierPath(){
        
        let path:UIBezierPath = UIBezierPath(arcCenter: CGPoint(x: self.menuButton.frame.size.width/2, y: self.menuButton.frame.size.height/2),
                            radius: self.menuButton.frame.size.height/2,
                            startAngle: (CGFloat(160) * 22/7)/180 ,
                            endAngle: (CGFloat(20) * 22/7)/180,
                            clockwise: true)
        self.menuButton.layer.shadowColor = UIColor.black.cgColor
        self.menuButton.layer.shadowOpacity = 0.7
        self.menuButton.layer.shadowOffset = CGSize.zero
        self.menuButton.layer.shadowRadius = 3
        self.menuButton.layer.shadowPath = path.cgPath;
    }
    
     func makeShadow()
    {
        
        let rect:CGRect = self.tabBar.bounds;
        let path = UIBezierPath()
        path.move(to: CGPoint.init(x: rect.origin.x, y:  rect.origin.y))
        path.addLine(to:  CGPoint.init(x: rect.size.width, y: 0))
        path.addLine(to:  CGPoint.init(x: rect.size.width, y: 10))
        path.addLine(to:  CGPoint.init(x: rect.origin.x, y: 10))
        path.addLine(to:  CGPoint.init(x: rect.origin.x, y: rect.origin.y))
        path.close();
        self.tabBar.layer.shadowColor = UIColor.black.cgColor
        self.tabBar.layer.shadowOpacity = 0.4
        self.tabBar.layer.shadowOffset = CGSize.zero
        self.tabBar.layer.shadowRadius = 4
        self.tabBar.layer.shadowPath = path.cgPath;
        self.tabBar.layer.borderWidth = 0.0;
        self.tabBar.layer.borderColor = UIColor.clear.cgColor;
        makeBrezierPath();
        return;
        
    }
    
    // MARK: - Actions
    
    @objc private func menuButtonAction(sender: UIButton) {
        selectedIndex = middleButtonIndex;
       
     
          self.menuButton.setImage(UIImage.init(named: DCUIFImageView.IMAGE_EXPLORE_SELECTED_ICON_TAB, in: DCUIFramework.bundle, compatibleWith: nil)!, for: .normal)
 
    }
  
  
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let selectedIndex = DCUIFViewController.getTopViewController().tabBarController?.selectedIndex {
            DCUITabBarController.currentSelectedTabIndex = selectedIndex

            NotificationCenter.default.post(name: Notification.Name("SelectedTab"), object: nil, userInfo: ["selectedIndex":selectedIndex])
        }
    }
}
