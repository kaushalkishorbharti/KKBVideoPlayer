//
//  DCUIFHLSPlayerVC.swift
//  DCUIFramework
//
//  Created by Abhinav Agarwal on 9/10/18.
//  Copyright © 2018 Abhinav Agarwal. All rights reserved.
//

import UIKit
import AVKit







public class DCUIFHLSPlayerVC: UIViewController,AVPlayerViewControllerDelegate {
    
    
    public func playerViewController(_ playerViewController: AVPlayerViewController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        
        
    }
    
    @IBAction func tapGesture(_ sender: Any) {
   }
    
    public func playerViewController(_ playerViewController: AVPlayerViewController, failedToStartPictureInPictureWithError error: Error) {
        
    }

    
    @IBOutlet weak var btnChnageQuality: UIButton!
    public var videoUrl:URL? = nil;
    public var player:AVPlayer? = nil;
    
    public var vc = AVPlayerViewController()
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    var videosQuality:Array<String> = [];
    var playlists = [MediaPlaylist]()
    var selectedPlayObject : MediaPlaylist?
    var playerObserver: Any?
    override public func viewDidLoad() {
        super.viewDidLoad()
        btnChnageQuality.setImage(UIImage.init(named: DCUIFImageView.IMAGE_SETTING_WHITE, in: DCUIFramework.bundle, compatibleWith: nil), for: UIControlState.normal)
        btnChnageQuality.setTitle("", for: UIControlState.normal);
        btnChnageQuality.tintColor = UIColor.white;
        
        /*  let url:URL = URL.init(fileURLWithPath: videoUrl)
         
         if(videoUrl.contains("http")){
         url = URL.init(fileURLWithPath: videoUrl)
         }
         else{
         url = URL.ini
         }
         */
       
        player = AVPlayer(url: videoUrl!)
        
        
        vc = AVPlayerViewController()
        vc.player = player;
        
        vc.delegate = self;
        
        self.addChildViewController(vc);
        
        vc.view.frame = self.view.bounds;
        self.view.addSubview(vc.view);
        
        self.view.bringSubview(toFront: vc.view)
        makeQualityFromVideo()
        if (self.videoUrl != nil)
        {
            playVideo(filePath: (self.videoUrl?.absoluteString)!)
//            makeVideoPlayer(url: (self.videoUrl?.absoluteString)!);
            
        }
        self.addVideoCurrentTimeNotifiction()
        
        
    }
    
    func addVideoCurrentTimeNotifiction() {
        // Invoke callback every second
        let interval = CMTime(seconds:1.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        
        // Queue on which to invoke the callback
        let mainQueue = DispatchQueue.main
        
        // Keep the reference to remove
        self.playerObserver = vc.player?.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue) { time in
           // print(CMTimeGetSeconds(time))
            let time: Double = CMTimeGetSeconds(time)
            let dict:NSDictionary = ["videoTime" : time]
            NotificationCenter.default.post(name: NSNotification.Name("VideoTimeNotification"), object: nil, userInfo: dict as? [AnyHashable : Any]);
        }
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: vc.player?.currentItem)

        
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification){
        //print("Video Finished")
        
        let dict:NSDictionary = ["isVideoFinish" : true]
        NotificationCenter.default.post(name: NSNotification.Name("VideoFinishNotification"), object: nil, userInfo: dict as? [AnyHashable : Any]);
    }
    
    public func makeVideoPlayer(url:String){
       // debugPrint("new Url: \(url)")
        let time = self.vc.player?.currentTime();
        
        let url:URL = URL.init(string:url)!
        self.vc.player?.replaceCurrentItem(with: AVPlayerItem(url: url))
        self.vc.player?.seek(to: time!);
        self.vc.player?.play();
    }
    
    func playVideo(filePath:String){
        let playerItem = AVPlayerItem(url: URL(fileURLWithPath: filePath))
        let player = AVPlayer(playerItem: playerItem)
        self.vc.player = player
        self.vc.player?.play()
//        var playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = self.view.frame
//        self.view.layer.addSublayer(playerLayer)
//        player.play()
        
    }
    
    
    
    public func makeQualityFromVideo(){
        
        if (self.videoUrl?.absoluteString.contains(".m3u8") == true){
            
            let builder = ManifestBuilder()
            if let url = videoUrl {
                let manifest = builder.parse(url as URL)
                for item in manifest.playlists {
                    videosQuality.append(item.path!)
                    playlists.append(item)
                }
            }
        }
    }
    
    
    @IBAction func changeQuality(_ sender: Any) {
        
//        showActionSheet(array: videosQuality);
        showActionSheetWithPlayList(array: self.playlists)
    }
    
    public func makeNameFromFile(fileName:String) -> String{
        
        let name:String = String(fileName.split(separator: "_").last!)
        return try! name.replace(".m3u8", replacement:"" )
    }
    
    public func showActionSheetWithPlayList(array:[MediaPlaylist]){
        
        var style = UIAlertController.Style.actionSheet
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            style = UIAlertController.Style.alert
        }
        
        let alertController = UIAlertController(title: "Action Sheet", message: "What would you like to do?", preferredStyle: style)
        let action = UIAlertAction.init(title: "Auto", style: UIAlertActionStyle.default) { (ation) in
            self.selectedPlayObject = nil
            self.makeVideoPlayer(url: (self.videoUrl?.absoluteString)!);
            
        }
        alertController.addAction(action);
        
        for item in array {
            var name:String = makeNameFromFile(fileName: item.path!);
            if let resolution = item.resolution {
                name = "\(resolution)p"
            }
            let actionP = UIAlertAction.init(title: name, style: UIAlertActionStyle.default) { (ationObj) in
                self.playVideoForQuality(playObject: item)
            }
            actionP.setValue(DCUIFColor.Gray.getColor(), forKey: "titleTextColor")
            action.setValue(DCUIFColor.Gray.getColor(), forKey: "titleTextColor")
            if let selectedPlayObject = self.selectedPlayObject {
                if selectedPlayObject.path == item.path {
                    actionP.setValue(DCUIFColor.PrimaryGreen.getColor(), forKey: "titleTextColor")
                }
            } else {
                action.setValue(DCUIFColor.PrimaryGreen.getColor(), forKey: "titleTextColor")
            }
            alertController.addAction(actionP);
        }
        let cancel = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel) { (ation) in
        }
        alertController.addAction(cancel);
        self.present(alertController, animated: true, completion: {
        })
    }
    
    public func showActionSheet(array:Array<String>){
        
        var style = UIAlertController.Style.actionSheet
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            style = UIAlertController.Style.alert
        }
        let alertController = UIAlertController(title: "Action Sheet", message: "What would you like to do?", preferredStyle: style)
        let action = UIAlertAction.init(title: "Auto", style: UIAlertActionStyle.default) { (ation) in
            
            self.makeVideoPlayer(url: (self.videoUrl?.absoluteString)!);
            
        }
        alertController.addAction(action);
        
        for item in array {
            let name:String = makeNameFromFile(fileName: item);
            let actionP = UIAlertAction.init(title: name, style: UIAlertActionStyle.default) { (ationObj) in
                self.playVideoForQuality(name: ationObj.title!);
            }
            alertController.addAction(actionP);
        }
        let cancel = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel) { (ation) in
        }
        alertController.addAction(cancel);
        self.present(alertController, animated: true, completion: {
        })
    }
    
    public func playVideoForQuality(name:String){
        
        let name:String = name;
        let url:String = try! (videoUrl?.absoluteString.replace(".m3u8", replacement: ""))! + "_" + name + ".m3u8";
        makeVideoPlayer(url: url);
        
    }
    
    public func playVideoForQuality(playObject:MediaPlaylist){
        
        if let path = playObject.path {
            if let masterManifest = videoUrl?.absoluteString {
                let mediaManifest = path
                if let masterManifestURL = NSURL(string: masterManifest) {
                    if let mediaManifestURL = masterManifestURL.deletingLastPathComponent?.appendingPathComponent(mediaManifest) {
                        makeVideoPlayer(url: mediaManifestURL.absoluteString)
                        self.selectedPlayObject = playObject
                    }
                }
            }
        }
    }
    
    
    public func getViewToAddSubview(option:Int) -> UIStackView?{
        
        for view in vc.view.allSubviews{
            
            if (view.description.contains("AVVolumeButtonControl")){
                return view.superview as? UIStackView;
            }
            
        }
        return nil;
        
      
        
        
        
    }
    
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true);
        
        
        
        if(videosQuality.count > 1){
            
            
            getViewToAddSubview(option: 2)?.addArrangedSubview(btnChnageQuality);
            
            
            
        }
        
        
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    public static func getView(url:URL) -> DCUIFHLSPlayerVC
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "DCUIFramework", bundle:DCUIFramework.bundle)
        let vc:DCUIFHLSPlayerVC = (storyBoard.instantiateViewController(withIdentifier: "DCUIFHLSPlayerVC") as? DCUIFHLSPlayerVC)!;
        vc.videoUrl = url;
        //"https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8"
        //url;
        return vc;
        
    }
    
    
    
}
