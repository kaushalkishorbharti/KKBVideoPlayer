//
//  ViewController.swift
//  DemoAPP
//
//  Created by kaushal kishor on 28/03/22.
//

import UIKit
import KKBVideoPlayer
class ViewController: UIViewController {
  @IBOutlet weak var videoPlayer: KKVideoPlayerView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
      DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
        guard let weakSelf = self else {return}
        //weakSelf.videoPlayer.rotated()
        let url = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        weakSelf.videoPlayer.cellViewModel = KKVideoPlayerViewVM(resumeInSec: 0)
        weakSelf.videoPlayer.completionHandler = { [weak self](time) in
            guard let weakSelf = self else {return}
           // weakSelf.completionHandler?(time)
          }
        weakSelf.videoPlayer.delegate = self
        weakSelf.videoPlayer.playVideo(forUrl: url)
      }
  }

  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
      super.viewWillTransition(to: size, with: coordinator)
  }

}

extension ViewController: KKVideoPlayerViewDelegate {
  func orientationChanged(isPotrait: Bool) {
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
      guard let weakSelf = self else {return}
      weakSelf.videoPlayer.rotated()
    }
  }
}
