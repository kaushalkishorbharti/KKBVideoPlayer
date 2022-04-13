//
//  KKVideoPlayerView.swift
//  KKVideoPlayer
//
//  Created by kaushal kishor on 24/03/22.
//

import UIKit
import AVKit
let KPlayerStatus = "status"
public protocol KKVideoPlayerViewDelegate: class {
  func orientationChanged(isPotrait: Bool)
}
open class KKVideoPlayerView: UIView {
  // MARK: - ---------Outlet----------
  @IBOutlet weak var viewRoot: UIView!
  @IBOutlet weak var viewData: UIView!
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var vwPlayer: UIView!
  @IBOutlet weak var viewVideoControl: UIView!
  @IBOutlet weak var mediaSlider: UISlider!
  @IBOutlet weak var imgViewMic: UIImageView!
  @IBOutlet weak var imgViewZoom: UIImageView!
  @IBOutlet weak var lblTime: UILabel!
  // MARK: - --------- Class Variable----------
  open var cellViewModel: KKVideoPlayerViewVM? {
    didSet {
      configureData()
    }
  }
  var player: AVPlayer?
  var playerLayer: AVPlayerLayer?
  fileprivate var periodicTimeObserver: Any?
  fileprivate var playItem : AVPlayerItem?
  weak open var delegate: KKVideoPlayerViewDelegate?
  open var completionHandler: ((Int?)->Void)?
  // MARK: - ---------View Life Cycle Methods----------
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  required public init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
//  override class var layerClass: AnyClass {
//      return AVPlayerLayer.self
//  }
  deinit {
    debugPrint("deinit called for video")
    removePeriodicObserver()
  }
  // MARK: - ---------Private Methods----------
  private func configureData() {
    cellViewModel?.imgZoom.bind(to: imgViewZoom)
    cellViewModel?.imgMic.bind(to: imgViewMic)
    cellViewModel?.currentTime.bind(to: lblTime)
    _ = cellViewModel?.isAudioMuted.observeNext(with: { [weak self](status) in
      guard let weakSelf = self else {return}
      if status == true {
        weakSelf.player?.isMuted = false
      } else {
        weakSelf.player?.isMuted = true
      }
    })
    NotificationCenter.default.addObserver(self, selector: #selector(KKVideoPlayerView.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    
  }
  private func configureView() {
    mediaSlider.minimumTrackTintColor = UIColor.init(red: 288/255, green: 0/255, blue: 70/255, alpha: 1.0)
    mediaSlider.maximumTrackTintColor = UIColor.init(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
    mediaSlider.thumbTintColor = UIColor.init(red: 288/255, green: 0/255, blue: 70/255, alpha: 1.0)
  }
  
  @objc open func rotated() {
    contentView.frame = self.bounds
    playerLayer?.frame = self.bounds
    playerLayer?.layoutIfNeeded()
    playerLayer?.layoutIfNeeded()
  }
  private func updateTime() {
    if let currentItem = player?.currentItem {
      let playhead = currentItem.currentTime().seconds
      //let playhead = Double(cellViewModel?.resume_on_in_sec ?? 0)
      let duration = currentItem.duration.seconds
      let percentage = Float(playhead / duration)
      if !(playhead.isNaN || playhead.isInfinite) && !(duration.isNaN || duration.isInfinite) {
        cellViewModel?.setPlayerTime(duration: duration, _currentTime: playhead)
        mediaSlider.setValue(percentage, animated: true)
        
      }
    }
  }
  private func removePeriodicObserver() {
    if let periodicTimeObsv = periodicTimeObserver {
      player?.removeTimeObserver(periodicTimeObsv)
      periodicTimeObserver = nil
    }
  }
  private func addPeriodicTimeObserver() {
    removePeriodicObserver()
    periodicTimeObserver = player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: .main, using: { [weak self](time) in
      guard let weakSelf = self else {return}
      //print("completionHandler === player ===\(Int(time.seconds))")
      weakSelf.completionHandler?(Int(time.seconds))
      weakSelf.cellViewModel?.resume_on_in_sec = Int(time.seconds)
      weakSelf.updateTime()
    })
  }
  func totalTime()->Int {
    if let duration = playItem?.duration, duration.timescale > 0 {
      return Int(duration.value)/Int(duration.timescale)
    }
    return 0
  }
  fileprivate func commonInit() {
    var bundle: Bundle = Bundle(identifier: "com.docquity.KKBVideoPlayer")!
    let viewName = "KKVideoPlayerView"
    bundle.loadNibNamed(viewName, owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    configureView()
    DispatchQueue.main.async { [weak self] in
      guard let weakSelf = self else {return}
      weakSelf.addPlayerToView(weakSelf.vwPlayer)
      weakSelf.updateTime()
    }
    
  }
  fileprivate func addPlayerToView(_ view: UIView) {
    player = AVPlayer()
    playerLayer = AVPlayerLayer(player: player)
    if let playerLayer = playerLayer {
      playerLayer.frame = self.bounds
      playerLayer.setNeedsLayout()
      playerLayer.videoGravity = .resizeAspectFill
      view.layer.addSublayer(playerLayer)
    }
    NotificationCenter.default.addObserver(self, selector: #selector(playerEndPlay), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    addPeriodicTimeObserver()
  }
  // MARK: - ---------Public Methods----------
  open func getCurrentPlayTime() -> Double? {
    return player?.currentItem?.currentTime().seconds
  }
  open func getVideoDuration() -> CMTime? {
    return player?.currentItem?.duration
  }
  open func getVideoCurrentTime() -> CMTime? {
    return player?.currentItem?.currentTime()
  }
  open func getPlayerObject() -> AVPlayer? {
    return player
  }
  open func removePlayer() {
    player?.pause()
    player?.rate = 0
    player?.replaceCurrentItem(with: nil)
    removePeriodicObserver()
  }
  open func play()  {
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: { [weak self] in
      guard let weakSelf = self else {return}
      if weakSelf.playItem?.status == AVPlayerItem.Status.readyToPlay {
        weakSelf.player?.pause()
        weakSelf.playItem?.seek(to: CMTime(value: CMTimeValue(weakSelf.cellViewModel?.resume_on_in_sec ?? 0),timescale: 1), completionHandler: {[weak self] (res) in
          if res{
            self?.player?.play()
            self?.updateTime()
          }
        })
      } else {
        self?.player?.play()
        self?.updateTime()
      }
    })
  }
  open func playVideoWithFileName(_ fileName: String, ofType type:String) {
    guard let filePath = Bundle.main.path(forResource: fileName, ofType: type) else { return }
    player?.pause()
    let videoURL = URL(fileURLWithPath: filePath)
    playItem = AVPlayerItem(url: videoURL)
    let duration = playItem?.asset.duration ?? CMTime.init()
    let seconds : Float64 = CMTimeGetSeconds(duration)
    mediaSlider.maximumValue = Float(seconds)
    mediaSlider.minimumValue = 0
    player?.replaceCurrentItem(with: playItem)
    play()
   // updateTime()
  }
  open func playVideo(forUrl url: String) {
    if let videoURL = URL(string: url) {
      player?.pause()
      playItem = AVPlayerItem(url: videoURL)
      //mediaSlider.maximumValue = Float(totalTime())
      //let duration = playItem?.asset.duration ?? CMTime.init()
      //let seconds : Float64 = CMTimeGetSeconds(duration)
      mediaSlider.maximumValue = 1
      mediaSlider.minimumValue = 0
      player?.replaceCurrentItem(with: playItem)
      play()
      //updateTime()
    }
  }
  @objc func playerEndPlay() {
    print("Player ends playing video")
  }
  
  // MARK: - ---------IBAction Methods----------
  @IBAction func btnMicClicked(_ sender: Any) {
    cellViewModel?.isAudioMuted.value?.toggle()
  }
  @IBAction func btnZoomClicked(_ sender: Any) {
    cellViewModel?.isZoomed.value?.toggle()
    delegate?.orientationChanged(isPotrait: cellViewModel?.isZoomed.value ?? false)
  }
  @IBAction func sliderValueChanged(_ sender: UISlider) {
    guard let duration = player?.currentItem?.duration else { return }
        let value = Float64(mediaSlider.value) * CMTimeGetSeconds(duration)
        let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
    cellViewModel?.resume_on_in_sec = Int(seekTime.seconds)
        player?.seek(to: seekTime )
        play()
  }
  
  @IBAction func sliderTouchCancel(_ sender: UISlider) {
    play()
  }
  
  @IBAction func sliderTouchBegin(_ sender: UISlider) {
    player?.pause()
  }
  @IBAction func jumpForward(_ sender: UIButton) {
      guard let currentTime = player?.currentTime() else { return }
      let currentTimeInSecondsPlus10 =  CMTimeGetSeconds(currentTime).advanced(by: 10)
      let seekTime = CMTime(value: CMTimeValue(currentTimeInSecondsPlus10), timescale: 1)
      player?.seek(to: seekTime)
  }
  @IBAction func jumpBackward(_ sender: UIButton) {
      guard let currentTime = player?.currentTime() else { return }
      let currentTimeInSecondsMinus10 =  CMTimeGetSeconds(currentTime).advanced(by: -10)
      let seekTime = CMTime(value: CMTimeValue(currentTimeInSecondsMinus10), timescale: 1)
      player?.seek(to: seekTime)
  }
}

