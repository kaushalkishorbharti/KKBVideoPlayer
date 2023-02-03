//
//  KKVideoPlayerViewVM.swift
//  KKVideoPlayer
//
//  Created by kaushal kishor on 24/03/22.
//

import UIKit

open class KKVideoPlayerViewVM: KKVideoPlayerViewPVM {
    var imgMute = KKObservable<UIImage?> (nil)
    var imgUMute = KKObservable<UIImage?> (nil)
    var imgZoomIn = KKObservable<UIImage?> (nil)
    var imgZoomOut = KKObservable<UIImage?> (nil)
    var imgMic = KKObservable<UIImage?> (nil)
    var imgZoom = KKObservable<UIImage?> (nil)
    var currentTime = KKObservable<String?> (nil)
    var isAudioMuted = KKObservable<Bool?> (nil)
    var isZoomed = KKObservable<Bool?> (nil)
    var isPlaying = KKObservable<Bool?> (nil)
    var imgForward = KKObservable<UIImage?> (nil)
    var imgBackward = KKObservable<UIImage?> (nil)
    var imgPlay = KKObservable<UIImage?> (nil)
    var imgPause = KKObservable<UIImage?> (nil)
    var resume_on_in_sec: Int? {
        didSet {
            if resume_on_in_sec == 0 {
            }
        }
    }
    public init(resumeInSec: Int?) {
        resume_on_in_sec = resumeInSec
        let bundle: Bundle = Bundle(identifier: "com.KKBVideoPlayer")!
        imgMute.value = UIImage.init(named: "mic-muted", in: bundle, compatibleWith: nil)
        imgUMute.value = UIImage.init(named: "mic-unmuted", in: bundle, compatibleWith: nil)
        imgZoomIn.value = UIImage.init(named: "zoom-in", in: bundle, compatibleWith: nil)
        imgZoomOut.value = UIImage.init(named: "zoom-out", in: bundle, compatibleWith: nil)
        imgForward.value = UIImage.init(named: "forward-move", in: bundle, compatibleWith: nil)
        imgBackward.value = UIImage.init(named: "backward-move", in: bundle, compatibleWith: nil)
        imgPlay.value = UIImage.init(named: "img-play", in: bundle, compatibleWith: nil)
        imgPause.value = UIImage.init(named: "img-pause", in: bundle, compatibleWith: nil)
        currentTime.value = ""
        isPlaying.value = false
        micStateChanged()
        orientationChanged()
    }
    
    private func micStateChanged() {
        isAudioMuted.value = false
        isAudioMuted.observe(on: self, observerBlock: { [weak self] in
            self?.updateMicState($0)
        })
    }
    private func updateMicState(_ status: Bool?) {
        if status == true {
            imgMic.value = imgUMute.value
        } else {
            imgMic.value = imgMute.value
        }
    }
    
    private func orientationChanged() {
        isZoomed.value = false
        isZoomed.observe(on: self, observerBlock: { [weak self] in
            self?.orientationChanged($0)
        })
    }
    private func orientationChanged(_ status: Bool?) {
        if status == true {
            imgZoom.value = imgZoomIn.value
        } else {
            imgZoom.value = imgZoomOut.value
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

