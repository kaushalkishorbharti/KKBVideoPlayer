//
//  DCUFDocumentView.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 11/10/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit


class DCUFDocumentView: UIView {

    @IBOutlet weak var imgPreview: DCUIFImageView!
    @IBOutlet weak var imgIcon: DCUIFImageView!
    @IBOutlet weak var lblName: DCUIFLabel!
    
    var previewImage:String = "";
    var iconImage:UIImage?;
    var name:String = "";
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib();
       
        
        
    }
    override func draw(_ rect: CGRect) {
        
        self.imgPreview.dcLoadImageFromRemotePath(path: previewImage, placeHolderImage: DCUIFImageView.PDF_PLACEHOLDER);
        self.lblName.text =  name;
        self.imgIcon.image =  iconImage;
        
    }
    
    public static func getDocumentView(owner:UIView,previewImage:String,iconImage:UIImage,label:String) -> DCUFDocumentView {
       
        //let viewName = "DCUFDocumentView"
        let view: DCUFDocumentView =  UINib(nibName: "DCUFDocumentView", bundle: DCUIFramework.bundle).instantiate(withOwner: nil, options: nil)[0] as! DCUFDocumentView

            //DCUIFramework.bundle.loadNibNamed(viewName,owner: owner, options: nil)![0] as! DCUFDocumentView
        view.frame = owner.bounds;
        view.previewImage = previewImage;
        view.iconImage =  iconImage;
        view.name =  label;
        return view;
        
    }
    
}
