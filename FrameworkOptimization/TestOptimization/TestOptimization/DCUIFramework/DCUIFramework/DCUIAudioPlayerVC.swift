//
//  DCUIAudioPlayerVC.swift
//  DCUIFramework
//
//  Created by kaushal kishor on 16/10/18.
//  Copyright © 2018 Abhinav Agarwal. All rights reserved.
//

import UIKit
import AVFoundation

public class DCUIAudioPlayerVC: DCUIFViewController,DCUIVideoPlayerDelegate {
    
   
    
    //MARK: ----------Outlet----------
    
    @IBOutlet var viewRoot: UIView!
    @IBOutlet weak var viewData: UIView!
    @IBOutlet weak var viewMedia: DCUIFMediaView!
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var btnPlayPause: UIButton!
    //@IBOutlet weak var viewSeekBar: UIProgressView!
    
    @IBOutlet weak var audioActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var viewSeekBar: UISlider!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    
    //MARK: ---------- Class Variable----------
    
    var media: DCFMedia?;
    
    public  var isPlayed:Bool = false;
    public  var hasBeenPaused: Bool = false;
    
    //MARK: ----------View Life Cycle Methods----------
    
    override public func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureView();
        configureAudioData();
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        
        DCUIVideoPlayer.shared.pausePlayingVideo();
    }
    override public func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: ----------Private Methods----------
    
    @objc public func updateAudioProgressView()
    {
        
        if DCUIVideoPlayer.shared.audioPlayer != nil{
            
            if (DCUIVideoPlayer.shared.audioPlayer?.isPlaying)!
            {
                self.viewSeekBar.value = Float(DCUIVideoPlayer.shared.audioPlayer?.currentTime ?? 0.0);
                
                DispatchQueue.main.async {
                    
                    let duration = (DCUIVideoPlayer.shared.audioPlayer?.duration ?? 0) - (DCUIVideoPlayer.shared.audioPlayer?.currentTime ?? 0);
                    
                    if duration >= 0{
                        let min = Int(duration)/60;
                        let sec = Int(duration)%60;
                        
                        self.lblDuration.text = String(format: "%02i:%02i",min,sec);
                    }
                }
                
            } else if DCUIVideoPlayer.shared.hasBeenPaused
            {
                
            }
            else{
                
               // self.viewSeekBar.setProgress(0.0, animated: false);
                self.viewSeekBar.value = 0;
                
            }
            
        }else{
            
            //self.viewSeekBar.setProgress(0.0, animated: false);
            self.viewSeekBar.value = 0;
        }
        
    }
    
    
    
    private func configureView()
    {
        btnCancel.setImage(UIImage.init(named: "icon-cross-white", in: DCUIFramework.bundle, compatibleWith: nil), for: .normal);
        
        btnPlayPause.setImage(UIImage.init(named: "play-audio", in: DCUIFramework.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal), for: .normal);
        lblDuration.layer.cornerRadius = 6;
        audioActivityIndicator.layer.cornerRadius = audioActivityIndicator.frame.size.width/2;
    }
    
    private func setMediaView()
    {
        var imageArray:Array<String> = []
        for media in ([self.media]){
            
            if((media)?.fileType == "image"){
                imageArray.append((media?.fileUrl!)!);
            }
            else{
                
                imageArray.append(media?.previewUrl ?? "");
            }
            
        }
        
        self.viewMedia.setView(mediaArray: ([self.media!]), imageArray: imageArray)
    }
    
    private func configureAudioData()
    {
        
        setMediaView();
        
        let duration = media?.duration ?? 0;
        let durationInSec = duration/1000;

        
        let min = Int(durationInSec)/60;
        let sec = Int(durationInSec)%60;
        
        self.lblDuration.text = String(format: "%02i:%02i",min,sec);
        self.viewSeekBar.minimumValue = 0;
        self.viewSeekBar.maximumValue = Float(durationInSec);
        self.viewSeekBar.value = 0;
        self.viewSeekBar.isContinuous = false;
       // self.viewSeekBar.setProgress(0.0, animated: true);
        
        DCUIVideoPlayer.shared.hasBeenPaused = false;
        DCUIVideoPlayer.shared.delegate = self;
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
           
            DCUIVideoPlayer.shared.playAudio(pathString: self.media?.fileUrl ?? "", currentVC: DCUIFViewController.getTopViewController(), isFullScreenMode: true);
        }
        
        
    }
    
    
    //MARK: ----------Public Methods----------
    
    @objc public static func getView(media: DCFMedia) -> DCUIAudioPlayerVC {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "DCUIFramework", bundle:DCUIFramework.bundle)
        let vc:DCUIAudioPlayerVC = (storyBoard.instantiateViewController(withIdentifier: "DCUIAudioPlayerVC") as? DCUIAudioPlayerVC)!;
        vc.media = media;
        return vc;
    }
    
    //MARK: ----------IBAction Methods----------
    
    @IBAction func seekBarValueChanged(_ sender: UISlider) {
        
        DCUIVideoPlayer.shared.audioPlayer?.currentTime = TimeInterval(sender.value);
        DCUIVideoPlayer.shared.playAudio(pathString: media?.fileUrl ?? "", currentVC: DCUIFViewController.getTopViewController(), isFullScreenMode: true);
        
        
    }
    @IBAction func btnPlayPauseClicked(_ sender: UIButton) {
        
        DCUIVideoPlayer.shared.playAudio(pathString: media?.fileUrl ?? "", currentVC: DCUIFViewController.getTopViewController(), isFullScreenMode: false)
        
    }
    
    @IBAction func btnCancelClicked(_ sender: UIButton) {
        
        DCUIVideoPlayer.shared.audioPlayer?.stop();
        dismiss(animated: true, completion: nil);
        
    }
    
    
    //MARK: ----------Audio Delegates Methods---------
    
    public func togglePlayPauseButton(_ isPlaying: Bool) {
        
        if isPlaying {
            DispatchQueue.main.async {
                
                self.btnPlayPause.setImage(UIImage.init(named: "pause-audio", in: DCUIFramework.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal), for: .normal);
                
            }
        }else{
            
            DispatchQueue.main.async {
                
                self.btnPlayPause.setImage(UIImage.init(named: "play-audio", in: DCUIFramework.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal), for: .normal);
                
            }
        }
        
    }
    
    
    public func updateSeekBarStatus() {
        
        self.updateAudioProgressView();
        
    }
    
    public func audioBufferingStatus(_ isBuffering: Bool) {
        
        
        if isBuffering{
            audioActivityIndicator.isHidden = false;
            audioActivityIndicator.startAnimating();
        }else{
            audioActivityIndicator.isHidden = true;
            audioActivityIndicator.stopAnimating();
        }
        
    }
    
    public func updateAudioDuration(_ isEnd: Bool) {
        
        
        let duration = media?.duration ?? 0;
        let durationInSec = duration/1000;
        
        
        let min = Int(durationInSec)/60;
        let sec = Int(durationInSec)%60;
        
        self.lblDuration.text = String(format: "%02i:%02i",min,sec);
        self.viewSeekBar.minimumValue = 0;
        self.viewSeekBar.maximumValue = Float(durationInSec);
        self.viewSeekBar.value = 0;
        
    }
    
    
}

