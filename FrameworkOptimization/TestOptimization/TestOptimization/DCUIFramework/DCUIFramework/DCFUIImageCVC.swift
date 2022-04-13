//
//  DCFUIImageCVC.swift
//  DCFramework
//
//  Created by Rajiv Mishra on 12/5/17.
//  Copyright © 2017 Docquity. All rights reserved.
//

import UIKit



public class DCFUIImageCVC: UICollectionViewCell {
    
    @IBOutlet weak var viewParent: DCUIFView!
    @IBOutlet weak var imgCheck: DCUIFImageView!
    @IBOutlet weak var lblAssosiation: DCUIFLabel!
    @IBOutlet weak var imgAssosiation: DCUIFImageView!
    @IBOutlet weak var btnZoomImage: UIButton!
    public  var imageUrl:String?;
    @IBOutlet weak var checkBoxCenter: DCUIFImageView!
    @IBOutlet weak var constrainWidthParent: NSLayoutConstraint!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        btnZoomImage.setImage(UIImage.init(named: DCUIFImageView.IMAGE_RESIZE, in: DCUIFramework.bundle, compatibleWith: nil), for: UIControlState.normal)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false;
        let screenWidth =  UIScreen.main.bounds.size.width;
        constrainWidthParent.constant = screenWidth/2 - 20;
        //imgAssosiation.layer.cornerRadius = 5;
       // imgAssosiation.clipsToBounds = true;
       
    }
    
    public func setCellData(image:String,label:String,isSelected:Bool,isMultiSelect:Bool){
        
        
        
        self.imgAssosiation.dcLoadImageFromRemotePath(path: image, placeHolderImage: DCUIFImageView.PLACHOLDER_IMAGE);
        if(label == ""){
            self.imgCheck.isHidden = true;
            self.checkBoxCenter.isHidden = false;
        }
        else{
         
            
            self.imgCheck.isHidden = false;
            self.checkBoxCenter.isHidden = true;
            
        }
        self.lblAssosiation.numberOfLines = 0;
        self.lblAssosiation.text = label;
        

        imageUrl = image;
        
        
        if(isMultiSelect == true){
            if isSelected == true{
                
                imgCheck.dcLoadImageWithImage(image: UIImage.init(named: DCUIFImageView.IMAGE_CHECK_BOX_SELECTED, in: DCUIFramework.bundle, compatibleWith: nil)!);
                
                checkBoxCenter.dcLoadImageWithImage(image: UIImage.init(named: DCUIFImageView.IMAGE_CHECK_BOX_SELECTED, in: DCUIFramework.bundle, compatibleWith: nil)!);
            }
            else{
                imgCheck.dcLoadImageWithImage(image: UIImage.init(named: DCUIFImageView.IMAGE_CHECK_BOX_UNSELECTED, in: DCUIFramework.bundle, compatibleWith: nil)!);
                 checkBoxCenter.dcLoadImageWithImage(image: UIImage.init(named: DCUIFImageView.IMAGE_CHECK_BOX_UNSELECTED, in: DCUIFramework.bundle, compatibleWith: nil)!);
            }
        }
        else{
            if isSelected == true{
                
                imgCheck.dcLoadImageWithImage(image: UIImage.init(named: DCUIFImageView.IMAGE_RADIO_BOX_SELECTED, in: DCUIFramework.bundle, compatibleWith: nil)!);
                checkBoxCenter.dcLoadImageWithImage(image: UIImage.init(named: DCUIFImageView.IMAGE_RADIO_BOX_SELECTED, in: DCUIFramework.bundle, compatibleWith: nil)!);
            }
            else{
                imgCheck.dcLoadImageWithImage(image: UIImage.init(named: DCUIFImageView.IMAGE_RADIO_BOX_UNSELECTED, in: DCUIFramework.bundle, compatibleWith: nil)!);
                checkBoxCenter.dcLoadImageWithImage(image: UIImage.init(named: DCUIFImageView.IMAGE_RADIO_BOX_UNSELECTED, in: DCUIFramework.bundle, compatibleWith: nil)!);
            }
        }
        
        
      
    }
    
    @IBAction func btnZoomImageClick(_ sender: Any) {
        
        DCUIImage.shwowImagePreview(urlString: imageUrl!, vc: DCUIFViewController.getTopViewController());
        
        
    }
    

  /*  override public var isSelected: Bool {
        didSet {
            if(isSelected == true){
                
                self.imgCheck.dcLoadImageWithImage(image: UIImage.init(named: DCUIFImageView.IMAGE_ASSOCIATION_UNSELECTED, in: DCUIFramework.bundle, compatibleWith: nil)!)
                self.viewParent.layer.borderWidth = 1
                self.viewParent.layer.borderColor = UIColor.white.cgColor

               
            }
            else{
                self.imgCheck.dcLoadImageWithImage(image: UIImage.init(named: DCUIFImageView.IMAGE_ASSOCIATION_SELECTED, in: DCUIFramework.bundle, compatibleWith: nil)!)
                self.viewParent.layer.borderWidth = 1
                self.viewParent.layer.borderColor = DCUIFTheme.sharedInstance.appTheme?.secondaryColor.cgColor
            }
           
        }
    }*/
    

    
    func setSelectedColor(int : Int) {
        switch int {
        case 0:
            self.imgCheck.dcLoadImageWithImage(image: UIImage.init(named: DCUIFImageView.IMAGE_ASSOCIATION_UNSELECTED, in: DCUIFramework.bundle, compatibleWith: nil)!)
            self.viewParent.layer.borderWidth = 1
            self.viewParent.layer.borderColor = UIColor.white.cgColor
        case 1:
            self.imgCheck.dcLoadImageWithImage(image: UIImage.init(named: DCUIFImageView.IMAGE_ASSOCIATION_SELECTED, in: DCUIFramework.bundle, compatibleWith: nil)!)
            self.viewParent.layer.borderWidth = 1
            self.viewParent.layer.borderColor = DCUIFTheme.sharedInstance.appTheme?.secondaryColor.cgColor
        default:
            self.imgCheck.dcLoadImageWithImage(image: UIImage.init(named: DCUIFImageView.IMAGE_ASSOCIATION_UNSELECTED, in: DCUIFramework.bundle, compatibleWith: nil)!)
            self.viewParent.layer.borderWidth = 1
            self.viewParent.layer.borderColor = UIColor.white.cgColor
            return
        }
    }
    
    
}
