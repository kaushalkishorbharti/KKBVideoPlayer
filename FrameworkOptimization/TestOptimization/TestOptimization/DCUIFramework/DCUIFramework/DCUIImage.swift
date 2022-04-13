//
//  DCUIImage.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 24/06/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit
import Kingfisher

public class DCUIImage: NSObject {
    
    
    
  @objc  public static func resizeImageWith(newSize: CGSize,image:UIImage) -> UIImage {
        
        let horizontalRatio = newSize.width / image.size.width
        let verticalRatio = newSize.height / image.size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: image.size.width * ratio, height: image.size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        image.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    static func from(color: UIColor,frame:CGRect) -> UIImage {
        let rect = frame;
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
   public static func fixOrientation(img: UIImage) -> UIImage {
        if (img.imageOrientation == .up) {
            return img
        }
        
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)
        
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return normalizedImage
    }

    public static func shwowImagePreview(urlString:String,vc:UIViewController){
        if(!urlString.isEmpty){
          
          
            if(urlString.range(of: "http") != nil){
                
              let imageUrl = DCUIFImageView.getOptimizedPath(path: urlString, isNeedOptimization: false, imageView: UIImageView.init())
              let agrume = Agrume(imageUrl: imageUrl,backgroundColor: .black)
              agrume.showFrom(vc)

//                if let imageUrl:URL = DCUIFImageView.getOptimizedPath(path: urlString, isNeedOptimization: false, imageView: UIImageView.init())  {
//                    let agrume = Agrume(imageUrl: imageUrl,backgroundColor: .black)
//                    agrume.showFrom(vc);
//
//                }else {
//                    let agrume = Agrume(imageUrl: URL(string: urlString)!,backgroundColor: .black)
//                    agrume.showFrom(vc);
//                }
            }
            else{
                if(UIImage.init(contentsOfFile: urlString) != nil){
                    let agrume =  Agrume(image: UIImage.init(contentsOfFile: urlString)!,backgroundColor: .black);
                    agrume.showFrom(vc);
                }
               
                
            }
            
        
        }
        else{
             NSLog("Blank Image String");
        }
    }
    
    

    public static func shwowImagesPreview(urlStringList:[String],selectedIndex: Int, vc:UIViewController){
        if(!urlStringList.isEmpty){
            
            var optimizedUrlList:[URL] = []
            for urlString in urlStringList {
                let imageUrl:URL = DCUIFImageView.getOptimizedPath(path: urlString, isNeedOptimization: false, imageView: UIImageView.init())
                   optimizedUrlList.append(imageUrl)
            }
            let agrume = Agrume(imageUrls: optimizedUrlList, startIndex: selectedIndex, backgroundColor: .black)
            agrume.showFrom(vc);
        }
        else{
            NSLog("Blank Image String");
        }
    }
}
