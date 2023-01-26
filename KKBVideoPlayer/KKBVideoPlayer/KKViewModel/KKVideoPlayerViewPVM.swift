//
//  KKVideoPlayerViewPVM.swift
//  KKVideoPlayer
//
//  Created by kaushal kishor on 24/03/22.
//

import UIKit

protocol KKVideoPlayerViewPVM: class {
  var imgMute: KKObservable<UIImage?> {get set}
  var imgUMute: KKObservable<UIImage?> {get set}
  var imgZoomIn: KKObservable<UIImage?> {get set}
  var imgZoomOut: KKObservable<UIImage?> {get set}
  var imgMic: KKObservable<UIImage?> {get set}
  var imgZoom: KKObservable<UIImage?> {get set}
  var currentTime: KKObservable<String?> {get set}
  var isAudioMuted: KKObservable<Bool?> {get set}
  var isZoomed: KKObservable<Bool?> {get set}
  var isPlaying: KKObservable<Bool?> {get set}
  var imgForward: KKObservable<UIImage?> {get set}
  var imgBackward: KKObservable<UIImage?> {get set}
  var imgPlay: KKObservable<UIImage?> {get set}
  var imgPause: KKObservable<UIImage?> {get set}
}
