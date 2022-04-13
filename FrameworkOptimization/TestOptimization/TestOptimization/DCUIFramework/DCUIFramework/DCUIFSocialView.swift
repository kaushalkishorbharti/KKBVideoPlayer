//
//  DCUIFSocialView.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 12/06/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit


public protocol DCUIFSocialViewProtocol{
    
    func isLikeSelected(status:Bool);
    func commentClick();
    func shareClick();
    func isBookbarkSelected(status:Bool);
    
}

public class DCUIFSocialView: UIView {
    
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var btnBookmark: UIButton!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var btnCommentWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var constrainCommentLeading: NSLayoutConstraint!
    
    // delegate
    public var delegate :DCUIFSocialViewProtocol?
    
    var toShowComment:Bool = true;
    
      override public func awakeFromNib() {
        NSLog("Awake");
    }
    
    func commonInit(){
      
        if toShowComment{
            self.btnCommentWidthConstraint.constant = 30;
            self.constrainCommentLeading.constant = 14
        }else{
             self.btnCommentWidthConstraint.constant = 0;
             self.constrainCommentLeading.constant = 0
        }
        self.lineView.backgroundColor =  DCUIFTheme.sharedInstance.appTheme?.borderSecondry;
        let selectedLikeImage:UIImage = UIImage.init(named: "like-selected", in: DCUIFramework.bundle, compatibleWith: nil)!;
        let likeImage:UIImage = UIImage.init(named: "like", in: DCUIFramework.bundle, compatibleWith: nil)!;
        self.btnLike.setImage(likeImage, for: UIControlState.normal)
        self.btnLike.setImage(selectedLikeImage, for: UIControlState.selected)
        
        let commentImage:UIImage = UIImage.init(named: "comment", in: DCUIFramework.bundle, compatibleWith: nil)!;
        self.btnComment.setImage(commentImage, for: UIControlState.normal)
        
        let shareImage:UIImage = UIImage.init(named: "share", in: DCUIFramework.bundle, compatibleWith: nil)!;
        
        self.btnShare.setImage(shareImage, for: UIControlState.normal)
        
        let selectedBookmarkImage:UIImage = UIImage.init(named: "bookmark-selected", in: DCUIFramework.bundle, compatibleWith: nil)!;
        let bookmarkImage:UIImage = UIImage.init(named: "bookmark", in: DCUIFramework.bundle, compatibleWith: nil)!;
        self.btnBookmark.setImage(bookmarkImage, for: UIControlState.normal)
        self.btnBookmark.setImage(selectedBookmarkImage, for: UIControlState.selected)
     }
    
    public static func getView(showComment:Bool) -> DCUIFSocialView {

        let view:DCUIFSocialView=UINib(nibName: "DCUIFSocialView", bundle: DCUIFramework.bundle).instantiate(withOwner: nil, options: nil)[0] as! DCUIFSocialView;
       view.toShowComment = showComment;

        view.commonInit();
        return view;
    }
    
    

    @IBAction func likeButtonClick(_ sender: UIButton) {
      
        self.delegate?.isLikeSelected(status: sender.isSelected)
        if(sender.isSelected==false)
        {
        sender.isSelected = !sender.isSelected
        let selectedLikeImage:UIImage = UIImage.init(named: "like-selected", in: DCUIFramework.bundle, compatibleWith: nil)!
        self.btnLike.setImage(selectedLikeImage, for: UIControlState.selected)
       // self.btnLike.isEnabled = false
        }
        else{
            
        }
    }
    
    @IBAction func commentButtonClick(_ sender: Any)
    {
        self.delegate?.commentClick()
    }
    
    @IBAction func shareButtonClick(_ sender: Any) {
        
        self.delegate?.shareClick()
    }
    
    @IBAction func bookmarkButtonClick(_ sender: UIButton) {
        self.delegate?.isBookbarkSelected(status: true)
         sender.isSelected = !sender.isSelected
           
    }
}
