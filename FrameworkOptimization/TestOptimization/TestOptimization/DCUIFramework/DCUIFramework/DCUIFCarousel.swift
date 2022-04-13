//
//  DCUIFCarousel.swift
//  DCUtilFramework
//
//  Created by Anhinav Agarwal on 24/06/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit
import Kingfisher


public protocol DCUIFCarouselDelegate:class {
    
    func mediaTappedAtIndex(index:Int);
    func didScrollToIndex(index:Int);
    
}

public class DCUIFCarousel: UIView, AACarouselDelegate{
    @IBOutlet public  var carousel: AACarousel!
    public var carouselArray:NSArray = [];
    public var pathArray:NSMutableArray = [];
    public var imageArray:NSMutableArray = [];
    public var titleArray:NSMutableArray = [];
    public var modelArray:NSArray = [];
    @IBOutlet weak var imgView: DCUIFImageView!
  
    public  weak var   delegate:DCUIFCarouselDelegate?
    
    func commonInit(){
        
        imgView.image = UIImage.init(named: DCUIFImageView.IMAGE_PLACEHOLDER, in: DCUIFramework.bundle, compatibleWith: nil)!;
        imgView.isHidden = true;
        self.backgroundColor = UIColor.white;
        carousel.images = imageArray as! [UIImage];
        carousel.setDescriptionFont(font: DCUIFTextTheme.K_THEME_TEXT_TextStyleDescriptionLight.font!, color: DCUIFTextTheme.K_THEME_TEXT_TextStyleDescriptionLight.color!, size: DCUIFTextTheme.K_THEME_TEXT_TextStyleDescriptionLight.size!)
        carousel.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: true)
        carousel.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 2, pageIndicatorColor:DCUIFTheme.sharedInstance.appTheme?.buttonPriamryColor, describedTitleColor: UIColor.black, layerColor: nil)
       
        carousel.setCarouselData(paths: pathArray as! [String],  describedTitle: self.titleArray as! [String], isAutoScroll: false, timer: 5.0, defaultImage: DCUIFImageView.IMAGE_PLACEHOLDER);
        
        carousel.backgroundColor = UIColor.white;
        return
        
    }
    
    func downloadImages(_ url: String, _ index:Int) {
    

       
        weak var weakSelf:DCUIFCarousel? = self;
        weak var imageView = UIImageView()
        imageView?.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: weakSelf, action: #selector(imageTapped))
        imageView?.addGestureRecognizer(tapRecognizer)
        let updatedUrl = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        if self.carouselArray.count > index
        {
            
        
        if((self.carouselArray[index] as? DCUIFCarouselModel) != nil && (self.carouselArray[index] as! DCUIFCarouselModel).image != nil){
            
            self.carousel.images[index]  = (self.carouselArray[index] as! DCUIFCarouselModel).image!;
        
            imgView.isHidden = true;
            
        }
        else{
            if (updatedUrl?.range(of:"http") != nil){
            
               
                
                DCUIFImageView.downloadImage(link: updatedUrl!) { (image:UIImage) in
                    
                    weakSelf?.carousel.images[index] = image;
                    
                }
              
             /*
                imageView?.kf.setImage(with: URL(string: updatedUrl!)!, placeholder: UIImage.init(named: DCUIFImageView.IMAGE_PLACEHOLDER), options: [.transition(.none)], progressBlock: nil, completionHandler: { (downloadImage, error, cacheType, url) in
                   
                    if(downloadImage != nil){
                 
                        self.imgView.isHidden = true;
                 
                        imageView?.image = UIImage.init(data: UIImageJPEGRepresentation(downloadImage!, 0.3)!)!;
                 
                        self.carousel.images[index]  = UIImage.init(data: UIImageJPEGRepresentation(downloadImage!, 0.3)!)!;
                 
                       // weakSelf?.carousel.images[index]  = downloadImage!
                 
                      /*
                        weakSelf?.imgView.isHidden = true;
                        imageView?.image = downloadImage;
                 
                        weakSelf?.carousel.images[index]  = downloadImage!
                         */

                    }
                    else{
                       
                        weakSelf?.carousel.images[index]  = DCUIFImageView.PLACHOLDER_IMAGE
                    }
                    
                })
             */
                }
                else{
                
                    self.imgView.isHidden = true;
                    self.carousel.images[index]  = UIImage.init(contentsOfFile: updatedUrl!) ?? UIImage.init();
                
               
               }
            
            
           
        }
        
    }
       
        
    }
    @objc func imageTapped(gestureRecognizer: UITapGestureRecognizer)
    {
        //let tappedImageView = gestureRecognizer.view!
        //let imageView = tappedImageView as! UIImageView
    }
    @objc func didScrollToIndex(index: Int) {
        
        self.delegate?.didScrollToIndex(index: index)
        
    }
    
    //optional method (interaction for touch image)
    func didSelectCarouselView(_ view:AACarousel ,_ index:Int) {
        
        if(self.delegate != nil){
            self.delegate?.mediaTappedAtIndex(index: index);
            return;
        }

        if(!(pathArray[index] as! String).contains("http")){
            DCUIImage.shwowImagePreview(urlString: pathArray[index] as! String, vc: DCUIFViewController.getTopViewController());
            
        }
        else{
            let photos:NSMutableArray = [];
            let initialPhoto = INSPhoto.init(imageURL: URL.init(string: pathArray[index] as! String), thumbnailImageURL:  URL.init(string: pathArray[index] as! String),fileType:.FileTypeImage)
            
            for item in pathArray{
                
                photos.add(INSPhoto.init(imageURL: URL.init(string: item as! String), thumbnailImageURL:  URL.init(string: item as! String),fileType:.FileTypeImage))
            }
            
            
            let galleryPreview = INSPhotosViewController(photos: photos as! [INSPhotoViewable], initialPhoto: initialPhoto, referenceView: self)
            DCUIFViewController.getTopViewController().present(galleryPreview, animated: true, completion: nil)
            
        }
        
        
      
      
       
        
    }
    
    //optional method (show first image faster during downloading of all images)
    func callBackFirstDisplayView(_ imageView: UIImageView, _ url: [String], _ index: Int) {
        
        imageView.image = UIImage.init(named: DCUIFImageView.IMAGE_PLACEHOLDER);
        
        if self.carouselArray.count > index{
        if((self.carouselArray[index] as? DCUIFCarouselModel) != nil && (self.carouselArray[index] as! DCUIFCarouselModel).image != nil){
            
           

          imageView.image = (self.carouselArray[index] as! DCUIFCarouselModel).image!;

        }
        else{
            if (url[index].range(of:"http") != nil){
                
             
                let url:URL? = URL(string: url[index]);
                
                if(url != nil){
                    imageView.hnk_setImageFromURL(url!, placeholder: UIImage.init(named: DCUIFImageView.IMAGE_PLACEHOLDER))
                }
                else{
                    
                }
               
                
            
            }
            else{
                //if(imageView != nil){
                    
                    if url[index] != ""{
                        let image:UIImage? = UIImage.init(contentsOfFile: url[index]) ;
                        if(image != nil){
                            
                        
                            imageView.hnk_setImage(image!, key: UUID().uuidString)
                        }
                        else{
                            
                        }
                       
                    }
               // }
                
            }
        
        }
        }
        
        
        
    }
    
    public static func getView(owner:UIView,carouselArray:NSArray,isFill:Bool) -> UIView{
        
        let viewName = "DCUIFCarousel"
        
        let view: DCUIFCarousel =  DCUIFramework.bundle.loadNibNamed(viewName,
                                                            owner: owner, options: nil)![0] as! DCUIFCarousel
        if(isFill){
            view.carousel.crausalImageStyle = .fullCrausal
        }
        else{
             view.carousel.crausalImageStyle = .center
        }
        view.carousel.initWithImageView()
        view.frame = owner.bounds;
        view.carousel.delegate = view ;
        view.carouselArray=carouselArray;
        if((owner as? DCUIFCarouselDelegate) != nil){
            view.delegate = owner as? DCUIFCarouselDelegate;
        }

        for item in carouselArray{
            
            if((item as? DCUIFCarouselModel) != nil){
                view.pathArray .add((item as! DCUIFCarouselModel).imageUrl)
                view.titleArray .add((item as! DCUIFCarouselModel).text)
                if( (item as! DCUIFCarouselModel).imageUrl != nil){
                    
                    view.imageArray .add((item as! DCUIFCarouselModel).image as Any)
                    
                }
            }
            else{
                 view.pathArray .add(item)
            }
            
        }
        
        
        
        view.loadUrl()
        return view;
       
    }
    
    public func loadUrl(){
 
        commonInit();
    }
    
    
    deinit {
        // perform the deinitialization
        
         self.carousel = nil;
        
    }

}


public class DCUIFCarouselModel:NSObject{
    
    public var imageUrl:String! = "";
    public var text:String!;
    public var image:UIImage?;
   
    
}


