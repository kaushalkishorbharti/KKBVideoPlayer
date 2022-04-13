//
//  DCUIFMediaView.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 11/10/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit
import AVFoundation

@objc public protocol DCUIFMediaViewDelegate {
    
    @objc func didScrollToIndex(index:Int);
    @objc func hideYouTubePlayIcon();
     @objc  func openDetail();
}

public class DCUIFMediaView: UIView,DCUIFCarouselDelegate,INSPhotosViewControllerDelegate {
//    var view:YTPlayerView?;
    
    var audioPlayer: AVAudioPlayer?;
    var hasBeenPaused: Bool = false;
    
//    public func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
//         playerView.playVideo();
//         self.addSubview(playerView);
//         self.bringSubview(toFront: playerView)
//
//    }
    
    
    
    public func imageTappedAtIndex(index: Int) {
        
        
        
        
        let media:DCFMedia = self.mediaArray[index];
        
        switch media.fileType! {
        case "video":
            DCUIVideoPlayer.playVideo(pathString:media.fileUrl! as NSString, currentVC:DCUIFViewController.getTopViewController(), isTempPath: false);
            break;
        case "image":
            
           
            break;
        case "document":
            let webview:DCUIWebView = DCUIWebView.getView(link: media.fileUrl!, pageTitle: "",isZoomEnable: true);
            webview.hidesBottomBarWhenPushed = true;
            let nav = DCUIFNavigationController.init(rootViewController: webview)
            nav.addBackButtonToNavigation();
            webview.navigationItem.leftBarButtonItem = DCUIFNavigationController.addBackButtonToNavigation(selctor: #selector(nav.closeNavigation), target: nav)
            DCUIFViewController.getTopViewController().present(nav, animated: true, completion: {
                
            })
          //
           // nav.pushViewController(webview, animated: true);
            break;
        case "audio":
            
            if !DCUIFViewController.getTopViewController().isKind(of: DCUIAudioPlayerVC.self)
            {
            let audioVC = DCUIAudioPlayerVC.getView(media: media);
            DCUIFViewController.getTopViewController().present(audioVC, animated: true, completion: nil);
            }
             break;
        default:
            break;
        }
       
        
    }
    
    
    @objc public func closeNav(){
        
    }
   
    
    
    public func didScrollToIndex(index: Int) {
        
        self.delegate?.didScrollToIndex(index: index)
        
    }
    
    
    
    
    
   
    
    @IBOutlet weak var btnMedia: UIButton!
    @IBOutlet weak var mediaContentView: UIView!
    
    @IBOutlet weak var viewAudioPlayPause: UIView!
    
    @IBOutlet weak var btnPlayPause: UIButton!
    
    @IBOutlet weak var seekBar: UIProgressView!
    
    @IBOutlet weak var lblDuration: UILabel!
    
    public var mediaArray:Array<DCFMedia> = []
    public var imageArray:Array<String> = []
    public var isMediaModel:Bool = false;
    public var delegate:DCUIFMediaViewDelegate?;
    public var isYouTubePlayEnable:Bool = false;
        
    public override func awakeFromNib() {
        super.awakeFromNib();
        self.layer.borderWidth = 1;
        self.layer.borderColor = DCUIFTheme.sharedInstance.appTheme?.bgPrimaryColor.cgColor;
        
        return;
       
    }
    
    
  
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
       
    }
    
    
    @IBAction func btnPlayPauseClicked(_ sender: UIButton) {
    }
    
    
    public func playAudioFile(path: String) {
        
        if (audioPlayer != nil) && (audioPlayer?.isPlaying)!{
            audioPlayer?.pause();
            hasBeenPaused = true;
            
        }else{
            if hasBeenPaused{
                audioPlayer?.play()
                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateAudioProgressView), userInfo: nil, repeats: true)
               // progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
            
                
            }else{
                
                let url = URL(fileURLWithPath: path)
                
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer?.play()
                    Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateAudioProgressView), userInfo: nil, repeats: true)
                } catch {
                    // couldn't load file
                }
            }
        }
    }



    @objc public func updateAudioProgressView()
{
    if (audioPlayer?.isPlaying)!
    {
        // Update progress
        //progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: true)
        
        DCUIFLogs.info("current time   ====\(String(describing: audioPlayer?.currentTime))")
        DCUIFLogs.info("current duration   ====\(String(describing: audioPlayer?.duration))")

    }
}

    public func mediaTappedAtIndex(index: Int) {
        
        
        //self.youtubePlayer.load(withVideoId: "M7lc1UVf-VE")
            //= YTPlayerView.init(frame: self.frame);
        
        
        
    
        if(isMediaModel == false){
            
            DCUIImage.shwowImagePreview(urlString: (imageArray[index] as NSString) as String, vc: DCUIFViewController.getTopViewController());
            return;
        }
    
        if self.mediaArray.count > index {
        let media:DCFMedia = self.mediaArray[index];
        
        let photos:NSMutableArray = [];
        for item in self.mediaArray{
            
            if(item.fileType == "video" || item.fileType == "document"){
                if(item.fileType == "document"){
                    photos.add(INSPhoto.init(imageURL: URL.init(string: item.previewUrl!), thumbnailImageURL:  URL.init(string:item.previewUrl!),fileType:.FileTypeDocument))
                }
                else{
                     photos.add(INSPhoto.init(imageURL: URL.init(string: item.previewUrl!), thumbnailImageURL:  URL.init(string:item.previewUrl!),fileType:.FileTypeVideo))
                }
                
                
            }else if(item.fileType == "audio" ){
                
                photos.add(INSPhoto.init(imageURL: URL.init(string: item.previewUrl!), thumbnailImageURL:  URL.init(string:item.previewUrl!),fileType:.FileTypeAudio))
                
              
                //playAudioFile(path: item.fileUrl!);
            }
            else{
                photos.add(INSPhoto.init(imageURL: URL.init(string: item.fileUrl!), thumbnailImageURL:  URL.init(string:item.fileUrl!),fileType:.FileTypeImage))
            }
            
        }
        
        
        switch media.fileType! {
        case "video":
            DCUIVideoPlayer.playVideo(pathString:media.fileUrl! as NSString, currentVC:DCUIFViewController.getTopViewController(), isTempPath: false);
            break;
        case "image":
            
            let initialPhoto = photos[index];
            let galleryPreview = INSPhotosViewController(photos: photos as! [INSPhotoViewable], initialPhoto: initialPhoto as? INSPhotoViewable, referenceView: self.mediaContentView);
            galleryPreview.delegate = self;
            DCUIFViewController.getTopViewController().present(galleryPreview, animated: true, completion: nil)
            return;
           // DCUIImage.shwowImagePreview(urlString: (media.fileUrl! as NSString) as String, vc: DCUIFViewController.getTopViewController());
           // break;
        case "audio":
            DCUIVideoPlayer.shared.delegate?.togglePlayPauseButton(false);
            if !DCUIFViewController.getTopViewController().isKind(of: DCUIAudioPlayerVC.self)
            {
            let audioVC = DCUIAudioPlayerVC.getView(media: media);
            DCUIFViewController.getTopViewController().present(audioVC, animated: true, completion: nil);
            }
            break;
        case "document":
            let webview:DCUIWebView = DCUIWebView.getView(link: media.fileUrl!, pageTitle: "",isZoomEnable: true);
            webview.hidesBottomBarWhenPushed = true; DCUIFViewController.getTopViewController().navigationController?.pushViewController(webview, animated: true);
            break;
        case "youtube":
            if(isYouTubePlayEnable == true){
                
                if((self.delegate) != nil){
                
                    self.delegate?.hideYouTubePlayIcon()
                }
               
//                view = YTPlayerView.init(frame: self.bounds)
//                view?.backgroundColor = UIColor.red;
//                view?.delegate = self;
//                let playvarsDic = ["controls": 1, "playsinline": 1, "autohide": 1, "showinfo": 1, "autoplay": 1, "modestbranding": 1]
//                view?.load(withVideoId:media.fileUrl!, playerVars: playvarsDic)
                
                
               
               
                
                
            }
            else{
                self.delegate?.openDetail();
            }
            
            break;
        default:
            break;
        }
        }else{
            return;
        }
        //print("Media");
    }
    
    
    
    
    
    public func setView(mediaArray:[DCFMedia],imageArray:[String]){
        
      
        isMediaModel = true;
        self.mediaArray = mediaArray;
        let banner:UIView = DCUIFCarousel.getView(owner: self,carouselArray:imageArray as NSArray, isFill: true ) as! DCUIFCarousel;
        self.removeAllSubview();
        self.addSubview(banner);
        return;
        
        
    }
    
    public func setView(imageArray:Array<String>){
        
       let banner:DCUIFCarousel = DCUIFCarousel.getView(owner: self,carouselArray:imageArray as NSArray, isFill: true ) as! DCUIFCarousel;
        self.imageArray = imageArray;
       self.removeAllSubview();
       self.addSubview(banner);
        
    }
    public func setView(documentName:String,previewImage:String,link:String,icon:UIImage){
        
        let documentView:UIView =  DCUFDocumentView.getDocumentView(owner: self, previewImage: previewImage, iconImage: icon, label: documentName);
        self.removeAllSubview();
        self.addSubview(documentView);
        
    }
    
    public func setViewForMetaData(link:String, previewImage:String,title:String, description:String,placeHolderImage:UIImage,htmlContent:String) {
       
        var documentView:UIView;
        
        if(link != nil && link != ""){
            
             documentView = DCUIFMetaDataView.setMetaView(owner: self, link: link, previewImage: previewImage, title: title, description: description, placeHolderImage: placeHolderImage)
            
        }
        else{
            
             documentView = DCUIFMetaDataView.setWebviewData(owner:self,string:htmlContent);
            
        }
      
        
        self.removeAllSubview();
        self.addSubview(documentView);
        
        
    }
    
    public func setView(previewImage:String,link:String){
        
        let documentView:UIView = DCUIFVideoContent.setVideoView(owner: self, link: link, previewImage: previewImage, placeHolderImage: DCUIFImageView.IMAGE_VIDEO_PLACEHODLDER);
        self.removeAllSubview();
        self.addSubview(documentView);
        
    }
    public func setView(){
        
        
        self.removeAllSubview();
       
        
    }
    
    public func removeAllSubview(){
        
//        for subview in self.subviews as [UIView]   {
//            let view:UIView? = subview
//            if(subview.tag != 1){
//                if ((subview as? DCUIFCarousel) != nil){
//
//
//                }
//                  subview.removeFromSuperview()
//                  view  = nil;
//            }
//
//        }
    }
    
   public  init (frame: CGRect,imageArray:Array<String>) {
        super.init(frame: frame);
 
    }
    
    public  init (frame: CGRect,videoLink:String,videoPreview:String){
         super.init(frame: frame);
    }
    
    public  init (frame: CGRect,medtaTitle:String,metaDesc:String,metaUrl:String){
         super.init(frame: frame);
    }
    
    public init (frame: CGRect,doctumentName:String,previewImage:String,link:String){
         super.init(frame: frame);
    }
    
    
    
}
