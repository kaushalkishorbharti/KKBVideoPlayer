//
//  KKVideoPlayerViewVM.swift
//  KKVideoPlayer
//
//  Created by kaushal kishor on 24/03/22.
//

import Foundation
import Bond
import ReactiveKit

open class KKVideoPlayerViewVM: KKVideoPlayerViewPVM {
  var imgMute = Observable<UIImage?> (nil)
  var imgUMute = Observable<UIImage?> (nil)
  var imgZoomIn = Observable<UIImage?> (nil)
  var imgZoomOut = Observable<UIImage?> (nil)
  var imgMic = Observable<UIImage?> (nil)
  var imgZoom = Observable<UIImage?> (nil)
  var currentTime = Observable<String?> (nil)
  var isAudioMuted = Observable<Bool?> (nil)
  var isZoomed = Observable<Bool?> (nil)
  var resume_on_in_sec: Int? {
    didSet {
      if resume_on_in_sec == 0 {
     // debugPrint("resume_on_in_sec === \(resume_on_in_sec)")
      }
    }
  }
  public init(resumeInSec: Int?) {
    resume_on_in_sec = resumeInSec
    imgMute.value = UIImage.init(named: "mic-muted")?.withRenderingMode(.alwaysOriginal)
    imgUMute.value = UIImage.init(named: "mic-unmuted")?.withRenderingMode(.alwaysOriginal)
    imgZoomIn.value = UIImage.init(named: "zoom-in")
    imgZoomOut.value = UIImage.init(named: "zoom-out")
    currentTime.value = ""
    micStateChanged()
    orientationChanged()
  }
  
  private func micStateChanged() {
    isAudioMuted.value = false
    _ = isAudioMuted.observeNext { [weak self](status) in
      guard let weakSelf = self else {return}
      if status == true {
        weakSelf.imgMic.value = weakSelf.imgUMute.value
      } else {
        weakSelf.imgMic.value = weakSelf.imgMute.value
      }
    }
  }
  private func orientationChanged() {
    isZoomed.value = false
    _ = isZoomed.observeNext { [weak self](status) in
      guard let weakSelf = self else {return}
      if status == true {
        weakSelf.imgZoom.value = weakSelf.imgZoomIn.value
      } else {
        weakSelf.imgZoom.value = weakSelf.imgZoomOut.value
      }
    }
  }
  func getHoursMinutesSecondsFrom(seconds: Double) -> (hours: Int, minutes: Int, seconds: Int) {
      let secs = Int(seconds)
      let hours = secs / 3600
      let minutes = (secs % 3600) / 60
      let seconds = (secs % 3600) % 60
      return (hours, minutes, seconds)
  }
  func formatTimeFor(seconds: Double) -> String {
      let result = getHoursMinutesSecondsFrom(seconds: seconds)
      let hoursString = "\(result.hours)"
      var minutesString = "\(result.minutes)"
      if minutesString.count == 1 {
          minutesString = "0\(result.minutes)"
      }
      var secondsString = "\(result.seconds)"
      if secondsString.count == 1 {
          secondsString = "0\(result.seconds)"
      }
      var time = "\(hoursString):"
      if result.hours >= 1 {
          time.append("\(minutesString):\(secondsString)")
      }
      else {
          time = "\(minutesString):\(secondsString)"
      }
      return time
  }
  func setPlayerTime(duration: Double, _currentTime: Double) {
    let timeTxt = formatTimeFor(seconds: _currentTime)
    let durationTxt = formatTimeFor(seconds: duration)
    currentTime.value = "\(timeTxt)/\(durationTxt)"
  }
}

