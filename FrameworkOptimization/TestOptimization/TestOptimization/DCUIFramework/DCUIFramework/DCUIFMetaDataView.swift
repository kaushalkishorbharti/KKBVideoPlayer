//
//  DCUIFMetaDataView.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 12/10/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit
import WebKit

class DCUIFMetaDataView: UIView {

    @IBOutlet weak var imgPreview: DCUIFImageView!
    @IBOutlet weak var lblName: DCUIFLabel!
    @IBOutlet weak var lblDescription: DCUIFLabel!
    @IBOutlet weak var webView: UIWebView!
    
    var link:String = "";
    var title:String = "";
    var desc:String = "";
    var previewImageLink:String = "";
    var placeHolderImage:UIImage?;
    
    override func awakeFromNib() {
        super.awakeFromNib();
        
        
    }
    
    override func draw(_ rect: CGRect) {
        self.imgPreview.dcLoadImageFromRemotePath(path: previewImageLink, placeHolderImage: DCUIFImageView.PLACHOLDER_IMAGE);
        self.lblName.text = title;
        self.lblDescription.text = desc;
    }
    
    public static func setMetaView(owner:UIView,link:String, previewImage:String,title:String, description:String,placeHolderImage:UIImage) -> DCUIFMetaDataView{
        
        
        let view: DCUIFMetaDataView =  UINib(nibName: "DCUIFMetaDataView", bundle: DCUIFramework.bundle).instantiate(withOwner: nil, options: nil)[0] as! DCUIFMetaDataView
        
        
        view.frame = owner.bounds;
        view.previewImageLink = previewImage;
        view.placeHolderImage =  placeHolderImage;
        view.title =  title;
        view.desc = description;
        view.webView.isHidden = true;
        return view;
        
    }
    public static func setWebviewData(owner:UIView,string:String)-> DCUIFMetaDataView{
        
        
        let view: DCUIFMetaDataView =  UINib(nibName: "DCUIFMetaDataView", bundle: DCUIFramework.bundle).instantiate(withOwner: nil, options: nil)[0] as! DCUIFMetaDataView
        view.frame = owner.bounds;
        
        
        view.webView.loadHTMLString(NSString.init(format: "<html><head></head><body>%@</body></head></html>", string) as String, baseURL: nil)
          view.webView.isHidden = false;
        return view;
        
    }

}
