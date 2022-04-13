//
//  DCUIFVideoContent.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 12/10/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit

class DCUIFVideoContent: UIView {

    @IBOutlet weak var imgPreview: DCUIFImageView!
    var previewImageLink:String = "";
    var placeHolderImage:UIImage?;
    
    
    override func awakeFromNib() {
        super.awakeFromNib();
         self.imgPreview.dcLoadImageFromRemotePath(path: previewImageLink, placeHolderImage: DCUIFImageView.IMAGE_VIDEO_PLACEHODLDER);
        
    }
    
    override func draw(_ rect: CGRect) {
        self.imgPreview.dcLoadImageFromRemotePath(path: previewImageLink, placeHolderImage: DCUIFImageView.IMAGE_VIDEO_PLACEHODLDER);
    }
   
    public static func setVideoView(owner:UIView,link:String, previewImage:String,placeHolderImage:UIImage) -> DCUIFVideoContent{
        
        
        let view: DCUIFVideoContent =  UINib(nibName: "DCUIFVideoContent", bundle: DCUIFramework.bundle).instantiate(withOwner: nil, options: nil)[0] as! DCUIFVideoContent
        
      
        view.frame = owner.bounds;
        view.previewImageLink = previewImage;
        view.placeHolderImage =  placeHolderImage;
        if(view.imgPreview != nil){
             view.imgPreview.dcLoadImageFromRemotePath(path: previewImage, placeHolderImage: DCUIFImageView.IMAGE_VIDEO_PLACEHODLDER);
        }
       
        return view;
        
    }
    
    

}
