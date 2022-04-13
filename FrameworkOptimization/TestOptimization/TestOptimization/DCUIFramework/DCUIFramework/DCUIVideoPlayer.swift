//
//  DCUIVideoPlayer.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 16/06/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

public protocol DCUIVideoPlayerDelegate: class {
    
    func togglePlayPauseButton(_ isPlaying: Bool);
    func updateSeekBarStatus();
    func audioBufferingStatus(_ isBuffering: Bool);
    func updateAudioDuration(_ isEnd: Bool);
}

public class DCUIVideoPlayer: NSObject,AVAudioPlayerDelegate{
    
    //NSObjectProtocol
    
    public weak var delegate : DCUIVideoPlayerDelegate?;

    public  var isPlayed:Bool = false;
    public  var audioPlayer: AVAudioPlayer?;
    public static var playerObserver: Any?
    @objc public static let shared:DCUIVideoPlayer = DCUIVideoPlayer.init();
    public var currentAudioPath: String?
    public  var hasBeenPaused: Bool = false;
    public var timer = Timer();
    public var isEnded:Bool = false;
    
    var session:URLSession!;
    
    
    @objc public func pausePlayingVideo(){
        
        if(audioPlayer?.isPlaying == true ){
             audioPlayer?.pause();
           // DCUIVideoPlayer.shared.hasBeenPaused = true;
            delegate?.togglePlayPauseButton(false);
        }
        else{
            if(session == nil){
                return;
            }
            session.invalidateAndCancel();
            audioPlayer?.stop();
            isEnded = true;
            self.delegate?.togglePlayPauseButton(false);
            self.delegate?.updateSeekBarStatus()
            self.delegate?.audioBufferingStatus(false);
            self.delegate?.updateAudioDuration(true);
            hasBeenPaused = false;
            currentAudioPath = "";
            isPlayed = false;
            audioPlayer = nil;
            timer.invalidate();
           
        }
       
        
       
        
        
    }
    
    
    
    @objc public static func localPathForFile(name:NSString) -> NSString{
        
        let fileMngr=FileManager.default;
        let docsurl = try! fileMngr.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        if(name.contains(docsurl.absoluteString)){
            return name;
        }
        let myurlString:NSString = docsurl.appendingPathComponent(name as String).path as NSString
        return myurlString;
        
    }
    

    @objc public static func playVideo(pathString:NSString,
                                       currentVC:UIViewController,
                                       isTempPath: Bool) {
        
       /* guard le"https://dxzjpd8lpdm50.cloudfront.net/47967822-8ff5-4f0d-ba35-f146473d2126/hls/test3344.m3u8"t path = Bundle.main.path(forResource: "video", ofType:"m4v") else {
            debugPrint("video.m4v not found")
            return
        }*/
        ///NSURL(fileURLWithPath: "xxxx")
    
    
    

        
        let url:NSURL;
        if(pathString.contains("http")){
            url =  URL(string: pathString.replacingOccurrences(of: " ", with: "%20") as String)! as NSURL
        }
        else{
            if isTempPath {
                var docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last as URL?
                docURL = docURL?.appendingPathComponent(pathString as String)
                url = docURL! as NSURL
            } else {
                url = URL(string:DCUIVideoPlayer.localPathForFile(name: pathString) as String)! as NSURL
               // debugPrint(url)
            }
           
                //URL(string: pathString as String) as! NSURL;
        }
        //"https://dxzjpd8lpdm50.cloudfront.net/47967822-8ff5-4f0d-ba35-f146473d2126/hls/test3344.m3u8"
        if pathString.contains("http") {
            let playerVC: DCUIFHLSPlayerVC = DCUIFHLSPlayerVC.getView(url: url as URL);
            currentVC.providesPresentationContextTransitionStyle = true
            currentVC.definesPresentationContext = true
            currentVC.modalPresentationStyle = UIModalPresentationStyle.overFullScreen;
            currentVC.present(playerVC, animated: true) {
                // player.play();
            }
        } else {
            DCUIVideoPlayer.startVideoFrom(videoPath: pathString as String, currentVC: currentVC)
        }
    
       return;
        
//        let player = AVPlayer(url: url as URL)
//        let playerController = AVPlayerViewController()
//        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: [])
//        playerController.player = player
//        currentVC.present(playerController, animated: true) {
//            player.play();
//        }
    }
    
    @objc public static func startVideoFrom(videoPath: String, currentVC:UIViewController) {
        
        let outputMineURL = DCUIVideoPlayer.createNewPath(lastPath: videoPath)
        let player = AVPlayer(url: outputMineURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        currentVC.present(playerViewController, animated: true) {
            playerViewController.player!.play()
            DCUIVideoPlayer.addVideoCurrentTimeNotifiction(player)
        }
    }
  
  @objc public static func startVideoFromM3U8(videoPath: String, currentVC:UIViewController, cookies: String) {
    /*
    if let videoURL = URL(string: videoPath) {
      if let cookiesArray = HTTPCookieStorage.shared.cookies {
        let values = HTTPCookie.requestHeaderFields(with: cookiesArray)
        let cookieArrayOptions = ["AVURLAssetHTTPHeaderFieldsKey": values]
        //let assets = AVURLAsset(url: videoURL, options: cookieArrayOptions)
        
        let assets = AVURLAsset(url: videoURL)
               
        let item = AVPlayerItem(asset: assets)
        let player = AVPlayer(playerItem: item)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        DispatchQueue.main.async {
          currentVC.present(playerViewController, animated: true) {
            if let player = playerViewController.player {
              player.play()
            }
          }
        }
      }
    }
    */
    if let videoURL = URL(string: videoPath) {
        let assets = AVURLAsset(url: videoURL)
        let item = AVPlayerItem(asset: assets)
        let player = AVPlayer(playerItem: item)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        DispatchQueue.main.async {
          currentVC.present(playerViewController, animated: true) {
            if let player = playerViewController.player {
              player.play()
            }
          }
      }
    }
  }
    static func addVideoCurrentTimeNotifiction(_ player: AVPlayer?) {
        // Invoke callback every second
        let interval = CMTime(seconds:1.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        
        // Queue on which to invoke the callback
        let mainQueue = DispatchQueue.main
        
        // Keep the reference to remove
        DCUIVideoPlayer.playerObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue) { time in
           // print(CMTimeGetSeconds(time))
            let time: Double = CMTimeGetSeconds(time)
            let dict:NSDictionary = ["videoTime" : time]
            NotificationCenter.default.post(name: NSNotification.Name("VideoTimeNotification"), object: nil, userInfo: dict as? [AnyHashable : Any]);
        }
        
//        NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification){
       // print("Video Finished")
        
        let dict:NSDictionary = ["isVideoFinish" : true]
        NotificationCenter.default.post(name: NSNotification.Name("VideoFinishNotification"), object: nil, userInfo: dict as? [AnyHashable : Any]);
    }

    
    /// Generate the new document directory path everytime when you rebuild the app and you have to append the last component of your URL.
    @objc public static func createNewPath(lastPath: String) -> URL {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let destination = URL(fileURLWithPath: String(format: "%@/%@", documentsDirectory,lastPath))
        return destination
    }
    
    @objc public func playAudio(pathString:String,currentVC:UIViewController,isFullScreenMode: Bool) {
        
        if DCUIVideoPlayer.shared.currentAudioPath == pathString{
            
            if isFullScreenMode{
                
                self.delegate?.togglePlayPauseButton(true);
                DCUIVideoPlayer.shared.hasBeenPaused = false;
                DCUIVideoPlayer.shared.audioPlayer?.prepareToPlay()
                DCUIVideoPlayer.shared.audioPlayer?.volume = 1;
                DCUIVideoPlayer.shared.audioPlayer?.play()
                DCUIVideoPlayer.shared.audioPlayer?.delegate = self;
                timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateProgressBarStatus), userInfo: nil, repeats: true)
                
            }else{
            
            
        if (DCUIVideoPlayer.shared.audioPlayer != nil) && (DCUIVideoPlayer.shared.audioPlayer?.isPlaying)!{
            
            self.delegate?.togglePlayPauseButton(false);
            DCUIVideoPlayer.shared.audioPlayer?.pause();
            DCUIVideoPlayer.shared.hasBeenPaused = true;
            timer.invalidate();
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateProgressBarStatus), userInfo: nil, repeats: false);
        }else{
            
            if DCUIVideoPlayer.shared.hasBeenPaused{
                
                self.delegate?.togglePlayPauseButton(true);

                DCUIVideoPlayer.shared.hasBeenPaused = false;
                
                DCUIVideoPlayer.shared.audioPlayer?.prepareToPlay()
                DCUIVideoPlayer.shared.audioPlayer?.volume = 1;
                DCUIVideoPlayer.shared.audioPlayer?.play()
                DCUIVideoPlayer.shared.audioPlayer?.delegate = self;
                timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateProgressBarStatus), userInfo: nil, repeats: true)
                
            }else{
                
                self.initializeAudioPlayerWithPath(pathString: pathString);
         }
      
       }
            }
        }else{
            self.initializeAudioPlayerWithPath(pathString: pathString);
        }
    }
    
    

    @objc public func initializeAudioPlayerWithPath(pathString: String)
    {
        if(session != nil)
        {
           session.invalidateAndCancel();
        }
        var url: URL?;
        if self.isValidUrl(path: pathString)
        {
         url = URL.init(string: pathString)
        }else{
          url = URL(fileURLWithPath: pathString)
        }
        isEnded = false;
        let request = URLRequest(url: url!);
        let conf: URLSessionConfiguration = URLSession.shared.configuration;
        session = URLSession(configuration: conf);
        self.delegate?.togglePlayPauseButton(true);
        self.delegate?.audioBufferingStatus(true);

    
        session.dataTask(with: request) { (data, response, error) in
            
          //  print("Downloading...");
            
            if error != nil {
                
                DCUIFLogs.info("error ====\(String(describing: error))")
                self.pausePlayingVideo()
                
            }else {
                DispatchQueue.main.async {
                    
                    do {
                        if(self.isEnded == true){
                            return;
                        }
                        
                        DCUIVideoPlayer.shared.audioPlayer = try AVAudioPlayer(data: data!)
                        
                        DCUIVideoPlayer.shared.audioPlayer?.prepareToPlay()
                        DCUIVideoPlayer.shared.audioPlayer?.volume = 1;
                        DCUIVideoPlayer.shared.audioPlayer?.play()
                        DCUIVideoPlayer.shared.currentAudioPath = pathString;
                        DCUIVideoPlayer.shared.audioPlayer?.delegate = self;
                        DCUIVideoPlayer.shared.hasBeenPaused = false;
                        self.delegate?.audioBufferingStatus(false);
                        self.timer.invalidate();
                        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateProgressBarStatus), userInfo: nil, repeats: true)
                    } catch {
                        DCUIFAlert.showOkAlert(title: "Alert", description: "Unable to play audio.", onViewCotroller: DCUIFViewController.getTopViewController())
                         self.delegate?.togglePlayPauseButton(false);
                        DCUIFLogs.info("error ====\(error)")
                        
                    }
                }
            }
            
            }.resume()
    }
    
    public func isValidUrl(path: String) -> Bool{
        
        let string = path;
        
        let types: NSTextCheckingResult.CheckingType = [.link]
        let detector = try? NSDataDetector(types: types.rawValue)
        guard (detector != nil && string.count > 0) else { return false }
        if detector!.numberOfMatches(in: string, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, string.count)) > 0 {
            return true
        }
        return false;
       
    }

    
    @objc public func updateProgressBarStatus() {
        
        self.delegate?.updateSeekBarStatus()
    }
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer,
                                                   successfully flag: Bool)
    {
        DCUIFLogs.info("Audio finished playing")

        DCUIVideoPlayer.shared.hasBeenPaused = false;
         self.pausePlayingVideo()
        
        //timer.invalidate();
        //timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateProgressBarStatus), userInfo: nil, repeats: false);
    }

    public func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {

        DCUIFLogs.info("Audio finished playing with error")
    }
    
}
