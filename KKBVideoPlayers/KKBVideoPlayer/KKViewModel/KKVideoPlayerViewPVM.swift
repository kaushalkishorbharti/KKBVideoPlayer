//
//  KKVideoPlayerViewPVM.swift
//  KKVideoPlayer
//
//  Created by kaushal kishor on 24/03/22.
//

import Foundation
import Bond
import ReactiveKit

protocol KKVideoPlayerViewPVM: class {
  var imgMute: Observable<UIImage?> {get set}
  var imgUMute: Observable<UIImage?> {get set}
  var imgZoomIn: Observable<UIImage?> {get set}
  var imgZoomOut: Observable<UIImage?> {get set}
  var imgMic: Observable<UIImage?> {get set}
  var imgZoom: Observable<UIImage?> {get set}
  var currentTime: Observable<String?> {get set}
  var isAudioMuted: Observable<Bool?> {get set}
  var isZoomed: Observable<Bool?> {get set}

}
