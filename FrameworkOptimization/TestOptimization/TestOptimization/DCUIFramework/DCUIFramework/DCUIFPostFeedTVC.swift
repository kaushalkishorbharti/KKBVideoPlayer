//
//  DCUIFPostFeedTVC.swift
//  DCUIFramework
//
//  Created by Docquity on 10/17/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit
//import DCUIFramework

public class DCUIFPostFeedTVC: UITableViewCell {
    
    @IBOutlet weak var lblTextWriteSomething: DCUIFLabel!
    @IBOutlet weak var imguserDefaultImage: DCUIFImageView!
    @IBOutlet weak var imgPostIconImage: DCUIFImageView!
    @IBOutlet weak var imgArrow: DCUIFImageView!
    
    @IBOutlet weak var imgViewUserDefaultWeidthConstraint: NSLayoutConstraint!
    
    var isHidePostIcon: Bool = false;
    
    
    @IBAction func tapUserProfile(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: Notification.Name("OpenProfileFromCard"), object: nil, userInfo: [:])

        
    }
    
    override public func awakeFromNib()
    {
        super.awakeFromNib()
        imguserDefaultImage.layer.cornerRadius = imguserDefaultImage.frame.width/2
        imguserDefaultImage.clipsToBounds = true
        imguserDefaultImage.layer.borderColor = UIColor.lightGray.cgColor
        //self.imgArrow.image = UIImage.init(named: DCUIFImageView.IMAGE_HOME_POST_RIGHT_ARROW, in: DCUIFramework.bundle, compatibleWith: nil);
        self.imgArrow.image = UIImage.init(named: DCUIFImageView.IMAGE_POST_FEED, in: DCUIFramework.bundle , compatibleWith: nil)!;
        self.imgArrow.image = self.imgArrow.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate);
        self.imgArrow.tintColor = UIColor.darkGray;
        
        self.lblTextWriteSomething.layer.cornerRadius = self.lblTextWriteSomething.frame.size.height/2;
        self.lblTextWriteSomething.layer.borderColor = UIColor.lightGray.cgColor;
        self.lblTextWriteSomething.textColor = UIColor.init(red: 118/255, green: 118/255, blue: 118/255, alpha: 1.0);
        self.lblTextWriteSomething.layer.borderWidth = 1;
       // imguserDefaultImage.layer.borderWidth = 2.0;
    
       // Initialization code
       // addGestureToView();
   }

    func addGestureToView(){
        
        let tapUserProfile = UITapGestureRecognizer(target: self, action: #selector(self.openProfile(sender:)))
        self.imguserDefaultImage.addGestureRecognizer(tapUserProfile)
        
    }
    
    @objc func openProfile(sender:UIView){
        
        NotificationCenter.default.post(name: Notification.Name("OpenProfileFromCard"), object: nil, userInfo: [:])

        
        
//
        
//        let vc = DCFCreateUserProfileVC.getView(userId: String.getString(DCFUser.sharedAppUser.userCustomId));
//        vc.hidesBottomBarWhenPushed = true
//    DCUIFViewController.getTopViewController().navigationController?.pushViewController(vc, animated: false);
//
        
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc public func setData(intiateText:String, userImage:String,isHidePostIcon: Bool = false)
    {
        self.lblTextWriteSomething.text = intiateText;
        self.lblTextWriteSomething.layer.cornerRadius = self.lblTextWriteSomething.frame.size.height/2;

        let image:UIImage = UIImage.init(named: DCUIFImageView.IMAGE_USER_POST, in: DCUIFramework.bundle, compatibleWith: nil)!
        
        if userImage == ""{
            imguserDefaultImage.image = image;
        }else{
        imguserDefaultImage.dcLoadImageFromRemotePath(path: userImage
                    , placeHolderImage:image)
        }
        
        self.isHidePostIcon = isHidePostIcon;
        if self.isHidePostIcon{
            self.imgViewUserDefaultWeidthConstraint.constant = 0;
        }else{
            self.imgViewUserDefaultWeidthConstraint.constant = 20;

        }
    }
    
    
    @objc public  class func getView() -> UITableViewCell {
        return UINib(nibName: "DCUIFPostFeedTVC", bundle:DCUIFramework.bundle ).instantiate(withOwner: nil, options: nil)[0] as! UITableViewCell
    }
    
    public  static func getNib() -> UINib{
        
        return UINib(nibName: "DCUIFPostFeedTVC", bundle:DCUIFramework.bundle);
    }
    
    @objc public  class func registerCellForTableView(tableView:UITableView){
        
        tableView.register(getNib(), forCellReuseIdentifier: cellIdentifier())
    }
    
    @objc  public class func cellIdentifier() -> String{
        return "DCUIFPostFeedTVC";
    }
    
    @objc internal class func getHeight() -> CGFloat{
        return UITableViewAutomaticDimension;
    }
    
}
