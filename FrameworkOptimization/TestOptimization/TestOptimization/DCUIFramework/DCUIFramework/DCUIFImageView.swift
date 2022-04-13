//
//  DCUIFImageView.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 25/05/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit
import Kingfisher
import CoreGraphics



public enum  DCFImageResolution: String {
    
    case resol60X60 = "160x160"
    case resol240X240  = "540x540"
    case resol1280X1280 = "1280x1280"
    case resol720X720 = "720x720"
    case auto = "auto"
    
    
}

var imageResolution = DCFImageResolution.self


public class DCUIFImageView: UIImageView {
    
    public static let ADD_IMAGE:UIImage = UIImage.init(named: "add", in: DCUIFramework.bundle, compatibleWith: nil)!;
    
    public static let ARROW_RIGHT_IMAGE:UIImage = UIImage.init(named: "arrow-right", in: DCUIFramework.bundle, compatibleWith: nil)!;
    public static let IMAGE_DEFAULT_SPONSERED:UIImage = UIImage.init(named: "defulat-sponsered", in: DCUIFramework.bundle, compatibleWith: nil)!;
    public static let CROSS_IMAGE:UIImage = UIImage.init(named: "cross-icon", in: DCUIFramework.bundle, compatibleWith: nil)!;
    public static let ROTATE_SCREEN_IMAGE:UIImage = UIImage.init(named: "roatate_image", in: DCUIFramework.bundle, compatibleWith: nil)!;

    public static let CALENDER_IMAGE:UIImage = UIImage.init(named: "calender", in: DCUIFramework.bundle, compatibleWith: nil)!;
    public static let PDF_PLACEHOLDER:UIImage = UIImage.init(named: "pdf-placeholder", in: DCUIFramework.bundle, compatibleWith: nil)!;
    public static let AVATAR_IMAGE:UIImage = UIImage.init(named: "AvatarImage", in: DCUIFramework.bundle, compatibleWith: nil)!;
    public static let ARROW_FWD_IMAGE:UIImage = UIImage.init(named: "arrow-fwd", in: DCUIFramework.bundle, compatibleWith: nil)!;
    public static let OPTIONAL_CHECK_IMAGE:UIImage = UIImage.init(named: "optional-icon", in: DCUIFramework.bundle, compatibleWith: nil)!;
   // public static let PLACHOLDER_IMAGE:UIImage = UIImage.init(named: "placeholder-image", in: DCUIFramework.bundle, compatibleWith: nil)!;
   public static let PLACHOLDER_IMAGE:UIImage = UIImage.init(named: "galaxy-placeholder-image", in: DCUIFramework.bundle, compatibleWith: nil)!;
  
    public static let PLACHOLDER_BANNER_IMAGE:UIImage = UIImage.init(named: "banner_plac-eholder", in: DCUIFramework.bundle, compatibleWith: nil)!;
    public static let PLACHOLDER_THREE_BY_ONE:UIImage = UIImage.init(named: "600by200", in: DCUIFramework.bundle, compatibleWith: nil)!;
    public static let PLACHOLDER_ONE_BY_ONE:UIImage = UIImage.init(named: "400by400", in: DCUIFramework.bundle, compatibleWith: nil)!;
    public static let PDF_ICON_IMAGE:UIImage = UIImage.init(named: "pdf-icon", in: DCUIFramework.bundle, compatibleWith: nil)!;
    public static let IMAGE_VIDEO_PLACEHODLDER:UIImage = UIImage.init(named: "video-placeholder", in: DCUIFramework.bundle, compatibleWith: nil)!;
    public static let ICON_POST_ARROW_RED_IMAGE:UIImage = UIImage.init(named: "sendbutton", in: DCUIFramework.bundle, compatibleWith: nil)!;
        
    public static let ICON_VIEW_PDF_IMAGE:UIImage = UIImage.init(named: "view-pdf", in: DCUIFramework.bundle, compatibleWith: nil)!;
    public static let IMAGE_SCREEN_ROTATION_ICON:String =  "rotation-icon";
    public static let IMAGE_AVATAR:String =      "AvatarImage";
    public static let IMAGE_PLACEHOLDER:String = "placeholder-image";
    public static let IMAGE_NAME_INSIGHT:String =            "Insights";
    public static let IMAGE_NAME_MY_DOWNLOAD:String =        "MyDownload";
    public static let IMAGE_NAME_MY_BOOKMARK:String =        "MyBookMark";
    public static let IMAGE_NAME_BUG_REPORT:String =         "BugReport";
    public static let IMAGE_NAME_NOTIFICATION:String =       "Notification";
    public static let IMAGE_NAME_LANGUAGE:String =           "Language";
    public static let IMAGE_NAME_EDIT_INTEREST:String =      "EditInterest";
    public static let IMAGE_NAME_TERMS_CONDITIONS:String =    "terms-conditions";
    public static let IMAGE_BOOKMARK:String =                "bookmark";
    public static let IMAGE_BOOKMARK_SELECTED:String =       "bookmark-selected";
    public static let IMAGE_SHARE:String =                   "share";
    public static let IMAGE_COMMENT:String =                 "comment";
    public static let IMAGE_POST_FEED:String =              "feed-post";
    public static let IMAGE_DOWNLOAD_ICON:String =        "download";
    public static let IMAGE_DEFAULT_CONFIGURE:String =        "error-default";
    public static let IMAGE_CHAT_ICON_TAB:String  =         "chat-tab";
    public static let IMAGE_EXPLORE_SELECTED_ICON_TAB:String  =  "exploreselected-tab";
    public static let IMAGE_PROFILE_SELECTED_ICON_TAB:String  =       "profile-selected-tab";
    public static let IMAGE_MORE_ICON:String =  "more_select";
    public static let IMAGE_HOME_ICON_TAB:String  =         "home_select";
    public static let IMAGE_CME_ICON_TAB:String  =          "learn_select";
    public static let IMAGE_EXPLORE_ICON_TAB:String  =         "explore_select";
    public static let IMAGE_PROFILE_ICON_TAB:String  =       "profile-selected-tab";
    public static let IMAGE_REFERRAL_ICON_TOOLS:String =         "tool-reward";
    public static let IMAGE_CHECK_BOX_SELECTED:String =         "checkbox-selected";
    public static let IMAGE_CHECK_BOX_UNSELECTED:String =         "checkbox_unselected";
    public static let IMAGE_ASSOCIATION_UNSELECTED:String =     "association-unselected";
    public static let IMAGE_ASSOCIATION_SELECTED:String =     "association-selected";
    public static let IMAGE_RADIO_BOX_SELECTED:String =         "radiobutton-checked";
    public static let IMAGE_RADIO_BOX_UNSELECTED:String =         "radiobutton-uncheck";
    public static let IMAGE_CHANNEL_PLACEHODLDER:String =         "channel-default";
        
    public static let IMAGE_NAV_TAB_FILTER:String =   "navtab-filter";
    public static let IMAGE_RESIZE:String =   "resize";
    public static let IMAGE_BACK_BUTTON:String =   "back-arrow";
    public static let IMAGE_ONBOARDING_TUTORIAL_FIRST:String =   "onboarding-first";
    public static let IMAGE_ONBOARDING_TUTORIAL_SECOND:String =   "onboarding-second";
    public static let IMAGE_ONBOARDING_TUTORIAL_THIRD:String =   "onboarding-third";
            
    public static let IMAGE_USER_POST:String =    "user-post-icon";
    public static let IMAGE_FLAG_DEFAULT:String =   "flag-default";
    public static let IMAGE_ASSOCIATION_DEFAULT:String =   "association-default";
    
    public static let IMAGE_HEART_WHITE:String = "icon_heart_white";
    public static let IMAGE_HEART_GREEN:String = "icon_heard_green";
    public static let IMAGE_POST_ARROW_RED:String = "sendbutton";
    public static let IMAGE_INJECTION_WHITE:String = "medicalCase";
    public static let IMAGE_ICON_SQUARE_RED_SELECTED:String = "icon-square-red-selected";
    public static let IMAGE_ICON_SQUARE_RED_UNSELECTED:String = "icon-square-red-unselected";
        
    public static let IMAGE_NEW_SEARCH_GREY_LENCE:String = "search-grey-lence";
    
    public static let IMAGE_ICON_TICK:String = "icon-tick";
    
    public static let IMAGE_SETTING_WHITE:String = "setting_white";
    
    public static func getOptimizedPath(path:String?,isNeedOptimization:Bool,imageView:UIImageView,resol:DCFImageResolution = .auto) -> URL{
        
        var bucketPath:String = DCUIFTheme.sharedInstance.imageOptimizationUrl;
        var defaultPath:String = DCUIFTheme.sharedInstance.imageDefaultSourceUrl
        var resolution :String;
        if(resol == .auto){
            resolution = DCUIFImageView.calculateOptimisedImageResolution(imageView: imageView).rawValue;
        }
        else{
            resolution = resol.rawValue;
        }
        if bucketPath.isEmpty {
            bucketPath = "https://d1h1hd24ytsr6y.cloudfront.net/fit-in/"
        }
        
        if defaultPath.isEmpty {
            defaultPath = "https://s3-ap-southeast-1.amazonaws.com/bucket.docquity.com/"
        }
        
        let relativePath :String = (path?.replacingOccurrences(of: defaultPath, with: ""))!
        
        var newPath:String = "";
        
        
        
        
        
        if (path?.contains(defaultPath))!
        {
            newPath = "\(bucketPath)\(resolution)/\(relativePath)";
        }else{
            newPath = path!;
        }
        
        var imageUrl:URL?;
        
        if isNeedOptimization{
            if let nImageUrl = URL(string:newPath) {
                imageUrl = nImageUrl
            }
            //            imageUrl = URL(string:newPath)!;
        }else{
            if let nImageUrl = URL(string:path ?? "") {
                imageUrl = nImageUrl
            }
            //            imageUrl = URL(string:path!)!;
        }
        return imageUrl!
        
    }
    
    public enum  DCUIFImageAspectRatio:String{
        
        case RatioYXY = "/YxY/"
        case Ratio3X1 = "/3x1/"
        case Ratio1X1 = "/1x1/"
        case Ratio3X2 = "/3x2/"
        
    }
    
    public func getAspectResolPath(path:String, aspectRation:DCUIFImageAspectRatio) -> String? {
        do {
            return try path.replace("/YxY/", replacement: aspectRation.rawValue)
        } catch {
            return nil
        }
    }
    
    public func dcLoadImageFromRemotePath(path:String?,placeHolderImage:UIImage?,isNeedOptimization: Bool = true,resol:DCFImageResolution = .auto,_ aspectRatio:DCUIFImageAspectRatio? = nil) {
        
        // Handel New
        
        let isFromAsset = (path?.split(separator: ".").count ?? 0) > 1 ? false : true
        
        
        if(DCUIFImageView.isValidUrl(path: path ?? "") == false && isFromAsset && path != "") {
            
            
            self.image = UIImage.init(named: path ?? "", in: DCUIFramework.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
            return
        }
        
        
        var imgPath = path;
        
        if let aspectRatio = aspectRatio, let tempPath = path {
            if let aspectPath = self.getAspectResolPath(path: tempPath, aspectRation: aspectRatio) {
                imgPath = aspectPath
            }
        }
        
        if(imgPath == ""){
            if let placeHolderImage = placeHolderImage {
                dcLoadImageWithImage(image: placeHolderImage)
            }
            
        }
        else if(imgPath != nil && imgPath?.range(of: "http") == nil){
            // Handel New
            let path = DCUIVideoPlayer.localPathForFile(name: imgPath! as NSString)
            self.image = UIImage.init(contentsOfFile: path as String);
        }
        else if (imgPath != nil && URL(string:imgPath!) != nil) {
            
            let imageUrl:URL? = DCUIFImageView.getOptimizedPath(path: imgPath, isNeedOptimization: isNeedOptimization, imageView: self,resol: resol);
            
            if(imageUrl != nil){
                
                if isNeedOptimization{
                    
                    let resource = ImageResource(downloadURL:imageUrl!, cacheKey: imageUrl?.absoluteString)
                    
                    
                    
                    self.kf.setImage(with: resource, placeholder: placeHolderImage, options: nil, progressBlock: nil) { (image:Image?, error:NSError?, catcheType:CacheType, url:URL?) in
                        
                        
                        
                    }
                    
                    //                    self.kf.setImage(with: resource, placeholder: placeHolderImage){(Image?, NSError?, CacheType, URL?) in
                    //
                    //                    }
                }else{
                    let resource = ImageResource(downloadURL: imageUrl!, cacheKey: imageUrl?.absoluteString)

                    self.kf.setImage(with: resource, placeholder: placeHolderImage)
                }
                
            }
            else{
                dcLoadImageWithImage(image: placeHolderImage!);
            }
            
            
        }
        else{
            dcLoadImageWithImage(image: placeHolderImage!);
        }
    }
  
    public func dcLoadImageWithImage(image:UIImage) {
        self.image=image;
    }
    
    public static func downloadImage(link:String,downloaded:@escaping (_ image:UIImage)->Void){
        if(link == ""){
            return;
        }
        let imageUrl:URL? = getOptimizedPath(path: link, isNeedOptimization: true, imageView: UIImageView.init());
        ImageDownloader.downloadImage(imageUrl!) { (image) in
            if((image) != nil){
                downloaded(image!);
            }
        }
    }
    
    public static func configureImageCatching(){
        ImageCache.default.maxDiskCacheSize = 100 * 1024 * 1024 // 100m mb
        ImageCache.default.maxMemoryCost = 30 * 1024 * 1024 //30 mb
    }
    
    public static func addPlayIconToImage(topImage: UIImage, bottomImage: UIImage, scaleForTop: CGFloat = 1.0) -> UIImage{
        
        let size = bottomImage.size
        let container = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 2.0)
        UIGraphicsGetCurrentContext()!.interpolationQuality = .high
        bottomImage.draw(in: container)
        
        let topWidth = size.width / scaleForTop
        let topHeight = size.height / scaleForTop
        let topX = (size.width / 2.0) - (topWidth / 2.0)
        let topY = (size.height / 2.0) - (topHeight / 2.0)
        
        topImage.draw(in: CGRect(x: topX, y: topY, width: topWidth, height: topHeight), blendMode: .normal, alpha: 1.0)
        
        return UIGraphicsGetImageFromCurrentImageContext()!
        
    }
    
    
    public func makeCircle(){
        self.layoutIfNeeded()
        self.layer.borderWidth = 0.0
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
    
    static func calculateOptimisedImageResolution(imageView:UIImageView?) -> DCFImageResolution  {
        
        let screenHeight = Double(UIScreen.main.bounds.height)
        let height = Double((imageView?.frame.size.height) ?? 0) 
        
        if(height == 0){
            return imageResolution.resol1280X1280
        }
        if (height <= 120) {
            return imageResolution.resol60X60
        }
        else  if (height <= (screenHeight-240)) {
            
            return imageResolution.resol240X240
        }
        else {
            return imageResolution.resol1280X1280
        }
        
    }
    
    public static func getImageFromTextOrUrl(_ title: String?, _ url: String?, _ width: CGFloat) -> UIImage {
        if (url != "") && (url != nil) {
            
            
            
            let imgView = DCUIFImageView()
            imgView.dcLoadImageFromRemotePath(path: url, placeHolderImage: DCUIFImageView.PLACHOLDER_IMAGE)
            return imgView.image ?? DCUIFImageView.PLACHOLDER_IMAGE
        }else {
            let name = title ?? ""
            return UIImage.imageFromTextView(msg: name, size: CGSize.init(width: width, height: width), cornerRadius: Int(width/2), textColor: UIColor.white, ViewBgColor: DCUIFImageView.getRandomColorType(name: name))
        }
    }
  public static func getImageFromTextOrUrlForRoche(_ title: String?, _ url: String?, _ width: CGFloat, imgView: DCUIFImageView) -> UIImage {
     let name = title ?? ""
     let placeHolderImage = UIImage.imageFromTextView(msg: name, size: CGSize.init(width: width, height: width), cornerRadius: Int(width/2), textColor: UIColor.white, ViewBgColor: DCUIFImageView.getRandomColorType(name: name))
      if (url != "") && (url != nil) {
         
          //let imgView = DCUIFImageView()
          imgView.dcLoadImageFromRemotePath(path: url, placeHolderImage: placeHolderImage)

          return imgView.image ?? placeHolderImage
      }else {
          imgView.image = placeHolderImage
          return placeHolderImage
      }
  }
    public static func getRandomColorType(name:String)->UIColor{
        
        var firstAlphbet:String! = " "
        var secondAlphabet = ""
        
        let array =  name.split(separator:" ");
        if(array.count > 0){
            firstAlphbet = String(name.split(separator:" ")[0])
        }
        if(array.count > 1){
            secondAlphabet = String(name.split(separator:" ")[1])
        }
        
        let RANDOM_COLOR_6:String="#7c8e9b"
        let RANDOM_COLOR_1:String="#749c47"
        let RANDOM_COLOR_2:String="#e1732c"
        let RANDOM_COLOR_3:String="#775cbc"
        let RANDOM_COLOR_4:String="#3486ca"
        let RANDOM_COLOR_5:String="#dc507a"
        
        
        var firstPos=0
        var secondPos=0
        
        let alphabets = " abcdefghijklmnopqrstuvwxyz"
        
        let firstInput = String(firstAlphbet!.lowercased().first!)
        //let secondInput = String(secondAlphabet!.lowercased().first!)
        
        
        let range: Range<String.Index> = alphabets.range(of: firstInput) ?? alphabets.range(of:" ")!
        firstPos = alphabets.distance(from: alphabets.startIndex, to: range.lowerBound)
        
        
       // let range2: Range<String.Index> = alphabets.range(of: secondInput)  ?? alphabets.range(of:" ")!
        secondPos = alphabets.distance(from: alphabets.startIndex, to: range.lowerBound)
        
        
        
        let sumOfAlphabetPosiions=firstPos+secondPos
        var colour:String = RANDOM_COLOR_5;
        
        if(sumOfAlphabetPosiions<5){
            colour = RANDOM_COLOR_1
        }else if(sumOfAlphabetPosiions>5 && sumOfAlphabetPosiions<=10){
            colour = RANDOM_COLOR_2
        }else if(sumOfAlphabetPosiions>10 && sumOfAlphabetPosiions<=15){
            colour = RANDOM_COLOR_3
        }else if(sumOfAlphabetPosiions>15 && sumOfAlphabetPosiions<=20){
            colour = RANDOM_COLOR_4
        }else if(sumOfAlphabetPosiions>20 && sumOfAlphabetPosiions<=25){
            colour = RANDOM_COLOR_5
        }else if(sumOfAlphabetPosiions>25 && sumOfAlphabetPosiions<=30){
            colour = RANDOM_COLOR_6
        }else if(sumOfAlphabetPosiions>30 && sumOfAlphabetPosiions<=35){
            colour = RANDOM_COLOR_1
        }else if(sumOfAlphabetPosiions>35 && sumOfAlphabetPosiions<=40){
            colour = RANDOM_COLOR_2
        }else if(sumOfAlphabetPosiions>40 && sumOfAlphabetPosiions<=45){
            colour = RANDOM_COLOR_3
        }else if(sumOfAlphabetPosiions>45 && sumOfAlphabetPosiions<=50){
            colour = RANDOM_COLOR_4
        }else {
            colour = RANDOM_COLOR_5
        }
        return UIColor.hexToUIColor(colour)
    }
    
    public static func getselfimage(_ title: String?, _ url: String?, _ width: CGFloat,image:UIImage?) -> UIImage {
        if (image != nil) {
            
            
            
            return image ?? DCUIFImageView.PLACHOLDER_IMAGE
        }else {
            let name = title ?? ""
            return UIImage.imageFromTextView(msg: name, size: CGSize.init(width: width, height: width), cornerRadius: Int(width/2), textColor: UIColor.white, ViewBgColor: DCUIFColor.PrimaryRed.getColor())
        }
    }
    
    public static func isValidUrl(path: String) -> Bool {
        
        let string = path
        let types: NSTextCheckingResult.CheckingType = [.link]
        let detector = try? NSDataDetector(types: types.rawValue)
        guard (detector != nil && string.count > 0) else { return false }
        if detector!.numberOfMatches(in: string, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, string.count)) > 0 {
            return true
        }
        return false;
        
    }
}
public extension UIImage {
    
     func fixedOrientation() -> UIImage {
        
        if imageOrientation == .up {
            return self
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: .pi)
            break
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
            break
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: -(.pi / 2))
            break
        case .up, .upMirrored:
            break
        }
        
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform.translatedBy(x: size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
        case .leftMirrored, .rightMirrored:
            transform.translatedBy(x: size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        }
        
        let ctx: CGContext = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: (self.cgImage?.colorSpace)!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
            break
        default:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }
        
        let cgImage: CGImage = ctx.makeImage()!
        
        return UIImage(cgImage: cgImage)
    }
    
    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
    
    class func imageFromTextView(msg: String, size: CGSize,cornerRadius: Int) -> UIImage {
        
        let lblNameInitialize = UILabel()
        lblNameInitialize.frame.size = size;
        lblNameInitialize.textColor = UIColor.white
        lblNameInitialize.text = String(describing: msg.first!);
        lblNameInitialize.textAlignment = NSTextAlignment.center
        lblNameInitialize.backgroundColor = DCUIFTheme.sharedInstance.appTheme?.buttonPriamryColor;
        lblNameInitialize.layer.cornerRadius = CGFloat(cornerRadius)
        
        UIGraphicsBeginImageContext(lblNameInitialize.frame.size)
        lblNameInitialize.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? DCUIFImageView.AVATAR_IMAGE;
    }
    
    
    
    
    class func imageFromTextView(msg: String, size: CGSize,cornerRadius: Int,textColor: UIColor,ViewBgColor: UIColor) -> UIImage {
        
        let lblNameInitialize = UILabel()
        lblNameInitialize.frame.size = size
        lblNameInitialize.textColor = textColor
        lblNameInitialize.text = msg
        lblNameInitialize.textAlignment = .center
        lblNameInitialize.adjustsFontSizeToFitWidth = true
        lblNameInitialize.minimumScaleFactor = 0.1
        lblNameInitialize.allowsDefaultTighteningForTruncation = true
        lblNameInitialize.backgroundColor = ViewBgColor
        lblNameInitialize.layer.cornerRadius = CGFloat(cornerRadius)
        
        UIGraphicsBeginImageContext(lblNameInitialize.frame.size)
        if let graphicsGetCurrentContext = UIGraphicsGetCurrentContext() {
            lblNameInitialize.layer.render(in: graphicsGetCurrentContext)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image ?? DCUIFImageView.AVATAR_IMAGE
        }else {
            return DCUIFImageView.AVATAR_IMAGE
        }
    }
    
    
     func compressImage(width: CGFloat, height: CGFloat, completion: @escaping (_ success: UIImage) -> Void,failure:@escaping (_ error:UIImage?)->Void){
        
        /*
         var actualHeight: CGFloat = self.size.height;
         var actualWidth: CGFloat = self.size.width;
         let maxHeight: CGFloat = height;
         let maxWidth: CGFloat = width;
         var imgRatio: CGFloat = actualWidth/actualHeight;
         let maxRatio: CGFloat = maxWidth/maxHeight;
         var compressionQuality: CGFloat = 0.5;
         
         if actualHeight > maxHeight || actualWidth > maxWidth {
         if imgRatio < maxRatio {
         //adjust width according to maxHeight
         imgRatio = maxHeight / actualHeight;
         actualWidth = imgRatio * actualWidth;
         actualHeight = maxHeight;
         } else if imgRatio > maxRatio {
         //adjust height according to maxWidth
         imgRatio = maxWidth / actualWidth;
         actualHeight = imgRatio * actualHeight;
         actualWidth = maxWidth;
         } else {
         actualHeight = maxHeight;
         actualWidth = maxWidth;
         compressionQuality = 1;
         }
         }
         let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight);
         UIGraphicsBeginImageContext(rect.size)
         self.draw(in: rect)
         guard let img = UIGraphicsGetImageFromCurrentImageContext() else {
         return nil
         }
         UIGraphicsEndImageContext()
         guard let imageData = UIImageJPEGRepresentation(img, compressionQuality) else {
         return nil
         }
         return UIImage(data: imageData)
         */
        
        DispatchQueue.global(qos: .background).async {
            
            var actualHeight: CGFloat = self.size.height;
            var actualWidth: CGFloat = self.size.width;
            let maxHeight: CGFloat = height;
            let maxWidth: CGFloat = width;
            var imgRatio: CGFloat = actualWidth/actualHeight;
            let maxRatio: CGFloat = maxWidth/maxHeight;
            var compressionQuality: CGFloat = 1.0;
            
            if actualHeight > maxHeight || actualWidth > maxWidth {
                if imgRatio < maxRatio {
                    //adjust width according to maxHeight
                    imgRatio = maxHeight / actualHeight;
                    actualWidth = imgRatio * actualWidth;
                    actualHeight = maxHeight;
                } else if imgRatio > maxRatio {
                    //adjust height according to maxWidth
                    imgRatio = maxWidth / actualWidth;
                    actualHeight = imgRatio * actualHeight;
                    actualWidth = maxWidth;
                } else {
                    actualHeight = maxHeight;
                    actualWidth = maxWidth;
                    compressionQuality = 1;
                }
            }
            let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight);
            UIGraphicsBeginImageContext(rect.size)
            self.draw(in: rect)
            guard let img = UIGraphicsGetImageFromCurrentImageContext() else {
                DispatchQueue.main.async {
                    failure(nil);
                }
                
                return;
                
            }
            UIGraphicsEndImageContext()
            guard let imageData = UIImageJPEGRepresentation(img, compressionQuality) else {
                
                DispatchQueue.main.async {
                    failure(nil);
                }
                
                return;
            }
            if UIImage(data: imageData) != nil{
                DispatchQueue.main.async {
                    completion(UIImage(data: imageData)!);
                }
                
                
            }else{
                DispatchQueue.main.async {
                    failure(nil);
                }
                
            }
            
        }
    }
    
     func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        newSize = targetSize;
        // This is the rect that we've calculated out and this is what is actually used below
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

extension UIImage {
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImageOrientation.up {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        } else {
            return self
        }
    }
}
