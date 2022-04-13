//
//  DCUIFPostCommentView.swift
//  DCUIFramework
//
//  Created by Arimardan Singh on 14/06/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit

@objc public protocol DCUIFPostCommentViewProtocol{

    func commentPostClick();
    
}

public class DCUIFPostCommentView: UIView {
    
    @IBOutlet weak public var textview_comment: DCUIFPlaceHolderTextView!
    @IBOutlet weak var btn_postComment: UIButton!
    
    
    // delegate
    public var delegate :DCUIFPostCommentViewProtocol?

    
    override public func awakeFromNib() {
        NSLog("Awake");
        
    }
    
    func commonInit(){
        
        //let senderImage:UIImage = UIImage.init(named: "PostComment", in: DCUIFramework.bundle, compatibleWith: nil)!;
       let senderImage:UIImage =  DCUIFImageView.ICON_POST_ARROW_RED_IMAGE;
        self.btn_postComment.setImage(senderImage, for: UIControlState.normal)
        
    }
    public static func getView() -> DCUIFPostCommentView {
        
        let view:DCUIFPostCommentView=UINib(nibName: "DCUIFPostCommentView", bundle: DCUIFramework.bundle).instantiate(withOwner: nil, options: nil)[0] as! DCUIFPostCommentView
        view.commonInit();
        return view;
    }
    
    @IBAction func sendPostComment(_ sender: Any)
    {
        
        self.delegate?.commentPostClick()
        self.textview_comment.resignFirstResponder();
       
    }

}
