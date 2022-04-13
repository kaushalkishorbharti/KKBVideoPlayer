//
//  DCUIImagePicker.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 08/06/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation
import Photos
import MobileCoreServices
import MediaPlayer
import MediaToolbox
import AudioToolbox
import Mantis
public class DCUIImagePicker: NSObject,UIActionSheetDelegate,UIDocumentPickerDelegate {
    
    
    var picker = UIImagePickerController()
    var parentViewController:UIViewController!
    var sucessCompletion:((Any)->Void)?
    var failureCompletion:((NSError)->Void)?
    var mediaType:String = "";
    var isMultiple:Bool = false;
    var imageLimit:Int =  -1;
    var maxMediaSize:Double =  -1.0;
    var isForGalaxy:Bool = false;
    var cropVC: CropViewController?
    
    var mediaPicker: MPMediaPickerController!
    
    var isImgCaptureFromCamera: Bool = false;

    public func getImageFromImagePicker(controller:UIViewController,
                                        mediaType:String = "image",
                                        isShowStyleSheet:Bool = true,
                                        isShowAudio: Bool = false,
                                        isShowDrive: Bool = false,
                                        isMultiple: Bool = false,
                                        isCamera: Bool = true,
                                        limit:Int = -1,
                                        sucess:@escaping (Any)->Void,faliure:@escaping(NSError)->Void){
        parentViewController = controller;
        sucessCompletion = sucess;
        failureCompletion = faliure;
        imageLimit = limit
        self.mediaType = mediaType;
        self.isMultiple = isMultiple
        if (isShowStyleSheet) {
            self.showSourceSelectectionSheet(view: controller, isShowAudio: isShowAudio, isShowDrive, isCamera)
        }
    }
    
    
    public func getImageFromImagePickerWithoutDrive(controller:UIViewController,
                                        mediaType:String = "image",
                                        isMultiple:Bool = false,
                                        isShowStyleSheet:Bool = true,
                                        limit:Int = -1,
                                        isShowAudio: Bool = false,
                                        sucess:@escaping (Any)->Void,faliure:@escaping(NSError)->Void){
        parentViewController = controller;
        sucessCompletion = sucess;
        failureCompletion = faliure;
        self.imageLimit = limit
        self.mediaType = mediaType;
        self.isMultiple = isMultiple;
        if (isShowStyleSheet) {
            self.showSourceSelectectionSheet(view: controller, isShowAudio: isShowAudio, false)
        }
    }
  public func getImageFromImagePickerWithoutDriveForGalaxy(controller:UIViewController,
                                      mediaType:String = "image",
                                      isMultiple:Bool = false,
                                      isShowStyleSheet:Bool = true,
                                      limit:Int = -1,
                                      isShowAudio: Bool = false,
                                      maxMediaSize: Double = -1,
                                      sucess:@escaping (Any)->Void,faliure:@escaping(NSError)->Void){
      parentViewController = controller;
      sucessCompletion = sucess;
      failureCompletion = faliure;
      self.imageLimit = limit
      self.mediaType = mediaType;
      self.isMultiple = isMultiple;
      self.isForGalaxy = true
      self.maxMediaSize = maxMediaSize
      if (isShowStyleSheet) {
          showSourceSelectectionSheetForGalaxy(view: controller, isShowAudio: isShowAudio, false, false)
      }
  }
    public func getImageFromGalaryWithoutDrive(controller:UIViewController,
                                                    mediaType:String = "image",
                                                    isMultiple:Bool = false,
                                                    isShowStyleSheet:Bool = true,
                                                    limit:Int = -1,
                                                    isShowAudio: Bool = false,
                                                    isCamera: Bool = false,
                                                    sucess:@escaping (Any)->Void,faliure:@escaping(NSError)->Void){
        parentViewController = controller;
        sucessCompletion = sucess
        failureCompletion = faliure
        self.imageLimit = limit
        self.mediaType = mediaType
        self.isMultiple = isMultiple
        self.photoFromLibrary(view: controller)
    }
    
    func showSourceSelectectionSheet(view:UIViewController,
                                     isShowAudio: Bool,
                                     _ isShowDrive: Bool? = nil,
                                     _ isCamera: Bool? = nil){
        
        var style = UIAlertController.Style.actionSheet
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            style = UIAlertController.Style.alert
        }
      DCUIFramework.language = (UserDefaults.standard.object(forKey: "currentLanguage") as?String)!
        var chooseOptionTxt: String? = "Choose Option"
      var driveTxt = "Drive"
      var cameraTxt = "Camera"
      var galleryTxt = "Gallery"
      var cancelTxt = "Cancel"
      if DCUIFramework.language == "in" {
        chooseOptionTxt = nil//""
        driveTxt = ""
        cameraTxt = "Kamera"
        galleryTxt = "Galeri"
        cancelTxt = "Batal"
      }else if DCUIFramework.language == "vi" {
        chooseOptionTxt = nil//""
        driveTxt = ""
        cameraTxt = "Máy ảnh"
        galleryTxt = "Gian phòng"
        cancelTxt = "hủy bỏ"
      }else{
        chooseOptionTxt = "Choose Option"
        driveTxt = "Drive"
        cameraTxt = "Camera"
        galleryTxt = "Gallery"
        cancelTxt = "Cancel"
      }
        let optionMenu = UIAlertController(title: nil, message: chooseOptionTxt, preferredStyle: style)
        
        let driveAction = UIAlertAction(title: driveTxt, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
           // print("Drive")
            self.documentFromDrive(view: view)
        })
        let deleteAction = UIAlertAction(title: galleryTxt, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
          //  print("Gallery")
            self.photoFromLibrary(view: view);
        })
        let saveAction = UIAlertAction(title: cameraTxt , style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
           // print("File Saved")
            let photos = PHPhotoLibrary.authorizationStatus()
            if photos == .notDetermined {
                PHPhotoLibrary.requestAuthorization({status in
                    if status == .authorized{
                        self.photoFromCamera(view: view)
                    } else {}
                })
            } else {
                self.photoFromCamera(view: view)
            }
            
            
            
        })
   
        let audioAction = UIAlertAction(title: "Audio".localized(withComment: "") , style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            //print("File Saved")
            
            self.audioFileFromGallery(view: view)
        })
        let cancelAction = UIAlertAction(title: cancelTxt, style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        if let isShowDrive = isShowDrive {
            if isShowDrive {
                optionMenu.addAction(driveAction)
            }
        } else {
            optionMenu.addAction(driveAction)
        }
        optionMenu.addAction(deleteAction)
        if let isCamera = isCamera {
            if isCamera {
                optionMenu.addAction(saveAction)
            }
        } else {
            optionMenu.addAction(saveAction)
        }
        
        if isShowAudio == true{
        optionMenu.addAction(audioAction)
        }
        optionMenu.addAction(cancelAction)
        optionMenu.view.tintColor = DCUIFColor.PrimaryBlack.getColor()
        view.present(optionMenu, animated: true, completion: nil)
    }
  func showSourceSelectectionSheetForGalaxy(view:UIViewController,
                                   isShowAudio: Bool,
                                   _ isShowDrive: Bool? = nil,
                                   _ isCamera: Bool? = nil){
      
      var style = UIAlertController.Style.actionSheet
      if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
          style = UIAlertController.Style.alert
      }
    UserDefaults.standard.set("en", forKey: "currentLanguage")
    DCUIFramework.language = "en"
      var chooseOptionTxt: String? = "Choose Option"
    var driveTxt = "Drive"
    var cameraTxt = "Camera"
    var galleryTxt = "Gallery"
    var cancelTxt = "Cancel"
    if DCUIFramework.language == "in" {
      chooseOptionTxt = nil//""
      driveTxt = ""
      cameraTxt = "Kamera"
      galleryTxt = "Galeri"
      cancelTxt = "Batal"
    }else if DCUIFramework.language == "vi" {
      chooseOptionTxt = nil//""
      driveTxt = ""
      cameraTxt = "Máy ảnh"
      galleryTxt = "Gian phòng"
      cancelTxt = "hủy bỏ"
    }else{
      chooseOptionTxt = "Choose Option"
      driveTxt = "Drive"
      cameraTxt = "Camera"
      galleryTxt = "Gallery"
      cancelTxt = "Cancel"
    }
      let optionMenu = UIAlertController(title: nil, message: chooseOptionTxt, preferredStyle: style)
      
      let driveAction = UIAlertAction(title: driveTxt, style: .default, handler: {
          (alert: UIAlertAction!) -> Void in
         // print("Drive")
          self.documentFromDrive(view: view)
      })
      let deleteAction = UIAlertAction(title: galleryTxt, style: .default, handler: {
          (alert: UIAlertAction!) -> Void in
        //  print("Gallery")
          self.photoFromLibraryForGalaxy(view: view);
      })
      let saveAction = UIAlertAction(title: cameraTxt , style: .default, handler: {
          (alert: UIAlertAction!) -> Void in
         // print("File Saved")
          let photos = PHPhotoLibrary.authorizationStatus()
          if photos == .notDetermined {
              PHPhotoLibrary.requestAuthorization({status in
                  if status == .authorized{
                      self.photoFromCamera(view: view)
                  } else {}
              })
          } else {
              self.photoFromCamera(view: view)
          }
          
          
          
      })
 
      let audioAction = UIAlertAction(title: "Audio".localized(withComment: "") , style: .default, handler: {
          (alert: UIAlertAction!) -> Void in
          //print("File Saved")
          
          self.audioFileFromGallery(view: view)
      })
      let cancelAction = UIAlertAction(title: cancelTxt, style: .cancel, handler: {
          (alert: UIAlertAction!) -> Void in
          
      })
      if let isShowDrive = isShowDrive {
          if isShowDrive {
              optionMenu.addAction(driveAction)
          }
      } else {
          optionMenu.addAction(driveAction)
      }
      optionMenu.addAction(deleteAction)
      if let isCamera = isCamera {
          if isCamera {
              optionMenu.addAction(saveAction)
          }
      } else {
          optionMenu.addAction(saveAction)
      }
      
      if isShowAudio == true{
      optionMenu.addAction(audioAction)
      }
      optionMenu.addAction(cancelAction)
      optionMenu.view.tintColor = DCUIFColor.PrimaryBlack.getColor()
      view.present(optionMenu, animated: true, completion: nil)
  }
    func checkCameraPermission() -> Bool {
        //var permissionCheck: Bool = false
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            print("Denied, request permission from settings")
            
        case .restricted:
            print("Restricted, device owner must approve")
        case .authorized:
            print("Authorized, proceed")
            //var permissionCheck: Bool = true
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    //var permissionCheck: Bool = true
                    print("Permission granted, proceed")
                } else {
                    print("Permission denied")
                }
            }
        }
        return true
    }
    
    public  func photoFromLibrary(view:UIViewController) {
        
        if (isMultiple == true) {
            let pickerController = DKImagePickerController()
            if(mediaType == "image"){
                pickerController.assetType = .allPhotos
                pickerController.allowMultipleTypes = false;
            }
            if ( imageLimit != -1) {
                pickerController.maxSelectableCount = imageLimit;
            }
            pickerController.didSelectAssets = { (assets: [DKAsset]) in
               // print("didSelectAssets")
                var mediaArray:Array<Any> =  [];
                var mediaCount = 0
                if assets.count == 0 {
                    self.sucessCompletion!(mediaArray)
                }
                for asset in assets {
                    if (asset.isVideo == true) {
                        let media:DCFMedia = DCFMedia.init();
                        media.fileType = "video"
                        media.object = asset.originalAsset;
                        mediaArray.append(media)
                        mediaCount = mediaCount + 1;
                        if(mediaCount == assets.count){
                            self.sucessCompletion!(mediaArray)
                            return;
                        }
                    } else {
                        let media:DCFMedia = DCFMedia.init();
                        media.fileType = "image"
                        media.width = asset.originalAsset?.pixelWidth
                        media.height = asset.originalAsset?.pixelHeight
                        asset.fetchOriginalImage(true, completeBlock: { (image, info) in
                            DCUIImagePicker.getCompressedImage(image: image!, completion: { (compressedImg) in
                                
                                media.object = compressedImg;
                                mediaArray.append(media)
                                mediaCount = mediaCount + 1;
                                if(mediaCount == assets.count){
                                    self.sucessCompletion!(mediaArray)
                                    return;
                                }
                                
                            }, failure: { (failedImg) in
                                DCUIFAlert.showOkAlert(title: "Atert", description: "Compression Failed", onViewCotroller: DCUIFViewController.getTopViewController());
                                return;
                            })
                            
                        }
                        );
                    }
                }
            }
            view.present(pickerController, animated: true) {}
            
        } else {
            picker.delegate = self
            picker.sourceType = .photoLibrary
            if (mediaType == "image") {
                picker.mediaTypes = [kUTTypeImage as String]
            } else {
                picker.mediaTypes = [kUTTypeMovie as String]
            }
            view.present(picker, animated: true, completion: nil)
        }
    }
    
  public  func photoFromLibraryForGalaxy(view:UIViewController) {
      
      if (isMultiple == true) {
          let pickerController = DKImagePickerController()
          if(mediaType == "image"){
              pickerController.assetType = .allPhotos
              pickerController.allowMultipleTypes = false;
          }
          if ( imageLimit != -1) {
              pickerController.maxSelectableCount = imageLimit;
          }
          pickerController.didSelectAssets = { (assets: [DKAsset]) in
             // print("didSelectAssets")
              var mediaArray:Array<Any> =  [];
              var mediaCount = 0
              if assets.count == 0 {
                  self.sucessCompletion!(mediaArray)
              }
              for asset in assets {
                  if (asset.isVideo == true) {
                      let media:DCFMedia = DCFMedia.init();
                      media.fileType = "video"
                      media.object = asset.originalAsset;
                      mediaArray.append(media)
                      mediaCount = mediaCount + 1;
                      if(mediaCount == assets.count){
                          self.sucessCompletion!(mediaArray)
                          return;
                      }
                  } else {
                      let media:DCFMedia = DCFMedia.init();
                      media.fileType = "image"
                      media.width = asset.originalAsset?.pixelWidth
                      media.height = asset.originalAsset?.pixelHeight
                      asset.fetchOriginalImage(true, completeBlock: {[weak self](image, info) in
                        guard let image = image else {return}
                        var size = Float()
                        if let data = UIImageJPEGRepresentation(image, 1.0) {
                          size = Float(Double(data.count)/1024/1024)
                        }
                        if size <= 4.0 {
                          DCUIImagePicker.getCompressedImage(image: image, completion: { (compressedImg) in
                              media.object = compressedImg;
                              mediaArray.append(media)
                              mediaCount = mediaCount + 1;
                              if(mediaCount == assets.count){
                                self?.sucessCompletion!(mediaArray)
                                  return;
                              }
                              
                          }, failure: { (failedImg) in
                              DCUIFAlert.showOkAlert(title: "Atert", description: "Compression Failed", onViewCotroller: DCUIFViewController.getTopViewController());
                              return;
                          })
                      }
                      }
                      );
                  }
              }
          }
          view.present(pickerController, animated: true) {}
          
      } else {
          picker.delegate = self
          picker.sourceType = .photoLibrary
          if (mediaType == "image") {
              picker.mediaTypes = [kUTTypeImage as String]
          } else if (mediaType == "both") {
            picker.mediaTypes = [kUTTypeImage as String,kUTTypeMovie as String]
        } else {
              picker.mediaTypes = [kUTTypeMovie as String]
          }
          view.present(picker, animated: true, completion: nil)
      }
  }
    private func opneAppSetting(vc: UIViewController)
    {
        
        DCUIFAlert.showOkCancelAlertWithComplition(title: "Alert", description: "Please go to Settings and turn on the micro phone permissions", onViewCotroller: vc, okButton: "Go to Setting", complition: {
            
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                    
                } else {
                    
                }
            }
            
            
        })
        
    }
    
    public func audioFileFromGallery(view:UIViewController) {
        
            let recordingSession = AVAudioSession.sharedInstance()
            
            do {
                try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                try recordingSession.overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
                try recordingSession.setActive(true)
                recordingSession.requestRecordPermission() { [unowned self] allowed in
                    DispatchQueue.main.async {
                        if allowed {
                           
//                            let feedPostAudioVC = DCFFeedPostAudioVC.getView();
//                            feedPostAudioVC.delegate = self;
//                            DCUIFViewController.presentAlertTypeViewVC(vc:feedPostAudioVC);
                            
                            var mediaArray:Array<Any> =  [];
                            let media:DCFMedia = DCFMedia.init();
                            media.fileType = "audio";
                            mediaArray.append(media)
                           
                            self.sucessCompletion!(mediaArray)
                                return;
                            }
                            else {
                            
                            self.opneAppSetting(vc: view);
                            
                        }
                    }
                }
            } catch {
                
                self.opneAppSetting(vc: view)
            }
            
        
//
//        mediaPicker = MPMediaPickerController.self(mediaTypes:MPMediaType.music);
//        mediaPicker.allowsPickingMultipleItems = false
//        mediaPicker.delegate = self;
//        mediaPicker.showsCloudItems = true;
//
//        DCUIFViewController.getTopViewController().present(mediaPicker, animated: true, completion: nil);
    }
    
    public func photoFromCamera(view:UIViewController){
        
        DCUIFPermission.requestPermission(view: view) { (status:Bool) in
            if(status){
                
            self.picker.delegate=self;
            self.picker.sourceType = .camera
            if(self.mediaType == "image"){
                    self.picker.mediaTypes = [kUTTypeImage as String]
                    // picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            }
            if(self.mediaType == "both"){
                    self.picker.mediaTypes = [kUTTypeMovie as String,kUTTypeImage as String]
                    self.picker.videoMaximumDuration = 1800;
                    // picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                }
            else{
                    self.picker.mediaTypes = [kUTTypeImage as String]
            }
                DispatchQueue.main.async {
                    
               view.present(self.picker, animated: true, completion: nil)
                    self.isImgCaptureFromCamera = true;
                }
            }
        }
    }
    
    public func documentFromDrive(view:UIViewController) {
        let controller = UIDocumentPickerViewController(documentTypes:["com.adobe.pdf"], in: .import)
        if #available(iOS 11, *) {
            controller.allowsMultipleSelection = self.isMultiple
        }
        controller.delegate = self;
        view.present(controller, animated: true)
    }
    
    public func openDocumentPicker(controller:UIViewController, isMultiple:Bool = false, sucess:@escaping (Any)->Void,faliure:@escaping(NSError)->Void) {
        parentViewController = controller
        sucessCompletion = sucess
        failureCompletion = faliure
        self.isMultiple = isMultiple
        self.documentFromDrive(view: controller)
    }
}

extension  DCUIImagePicker:UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       // picker.popViewController(animated: true);
        
        if(info[UIImagePickerControllerOriginalImage] != nil){
            let image:UIImage=info[UIImagePickerControllerOriginalImage] as! UIImage;
            
                if(self.isMultiple == false){
                    picker.dismiss(animated: true, completion: {
                        if self.isImgCaptureFromCamera{
                            let newImage = DCUIImagePicker.updateImageOrientionUpSide(image: image);
                            self.sucessCompletion?(newImage as Any)
                            self.isImgCaptureFromCamera = false;
                            
                        }else{
                          if self.isForGalaxy == true {
                            var size = Float()
                            var bytesSize = Double()
                            if let data = UIImageJPEGRepresentation(image, 1.0) {
                              size = Float(Double(data.count)/1024/1024)
                              bytesSize = Double(data.count)
                            }
                            if self.maxMediaSize > 0 {
                              if bytesSize <= self.maxMediaSize {
                                self.cropImageForGalaxy(image: image)
                              }
                            } else {
                              if size <= 4.0 {
                                self.cropImageForGalaxy(image: image)
                              }
                            }
                          } else {
                            self.sucessCompletion?(image)
                          }
                        }
                    })
                   
                      return;
                }
            
            DCUIImagePicker.getCompressedImage(image: image, completion: { (compressedImg) in
                
                var mediaArray:Array<DCFMedia> = [];
                
                let media:DCFMedia = DCFMedia.init();
                media.fileType = "image"
                media.object = compressedImg;
                mediaArray.append(media)
                DispatchQueue.main.async {
                    if((picker as?  UIViewController) != nil){
                        picker.dismiss(animated: true, completion: {
                            
                            self.sucessCompletion?(mediaArray)
                        })
                    }
                    
                    return;
                }
                
            }) { (failedImg) in
                
                DCUIFAlert.showOkAlert(title: "Atert", description: "Compression Failed", onViewCotroller: DCUIFViewController.getTopViewController());
                return;
            }
        }
        else{

            PHPhotoLibrary.shared().performChanges({
              if let imagePickerControllerMediaURL = info[UIImagePickerControllerMediaURL] as? URL {
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: imagePickerControllerMediaURL)
              }
            }) { saved, error in
                if saved {
                    let fetchOptions = PHFetchOptions()
                    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                    let fetchResult = PHAsset.fetchAssets(with: .video, options: fetchOptions).firstObject
                    let manager = PHImageManager.default()
                    manager.requestAVAsset(forVideo: fetchResult as! PHAsset, options: nil) { [weak self](avasset, audio, info) in
                      guard let weakSelf = self else {return}
                        if let avassetURL = avasset as? AVURLAsset {
                            let data = NSData(contentsOf: avassetURL.url as URL)!
                          var sizeValidation = 4
                          if (Double(data.length) > weakSelf.maxMediaSize) {
                                 let dataSize = (data.count/1024)/1024
                            if dataSize > 4 {
                              sizeValidation = 4
                            } else {
                              sizeValidation = Int(weakSelf.maxMediaSize)
                            }
                                DispatchQueue.main.async {
                                    if((picker as?  UIViewController) != nil){
                                      DCUIFAlert.showOkAlert(title: "Alert", description: "You can't select video of size more then \(sizeValidation) MB", onViewCotroller: DCUIFViewController.getTopViewController());
                                    }
                                }
                            }else{
                                var mediaArray:Array<DCFMedia> = [];
                                let media:DCFMedia = DCFMedia.init();
                                media.fileType = "video"
                                media.object = fetchResult
                                mediaArray.append(media)
                                DispatchQueue.main.async {
                                    if((picker as?  UIViewController) != nil){
                                        picker.dismiss(animated: true, completion: {
                                            weakSelf.sucessCompletion!(mediaArray)
                                            return;
                                        })
                                    }
                                }
                            }}
                    }

                  /*
                    var mediaArray:Array<DCFMedia> = [];
                    let media:DCFMedia = DCFMedia.init();
                    media.fileType = "video"

                        media.object = fetchResult

                    mediaArray.append(media)
                    DispatchQueue.main.async {
                        if((picker as?  UIViewController) != nil){
                            picker.dismiss(animated: true, completion: {
                                self.sucessCompletion?(mediaArray)
                                return;
                            })
                        }
                    }
                  */
                  // fetchResult is your latest vid?eo PHAsset
                    // To fetch latest image  replace .video with .image
                }
            }
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.popViewController(animated: true);
        let error:NSError = NSError.init();
        failureCompletion!(error)
        picker.dismiss(animated: true) {
        }
    }
  public func cropImageForGalaxy(image: UIImage) {
    var config = Mantis.Config()
    config.ratioOptions = [.custom]
    cropVC?.didSelectRatio(ratio: 2/1)
    cropVC = Mantis.cropViewController(image: image, config: config)
    cropVC?.config.presetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 2.0 / 1.0)
    cropVC?.config.showRotationDial = false
    cropVC?.delegate = self
    if let controller = cropVC {
      DCUIFViewController.getTopViewController().present(controller, animated: true)
    }
  }
    public static func getCompressedImage(image:UIImage) -> UIImage{
        return UIImage.init(data:UIImageJPEGRepresentation(image, 0.85)!)!;
    }
    
    public static func getCompressedImage(image:UIImage, completion: @escaping (_ success: UIImage) -> Void,failure:@escaping (_ error:UIImage?)->Void){
        
        image.compressImage(width: DCUIFTheme.sharedInstance.defaultImgResolutionWidth, height: DCUIFTheme.sharedInstance.defaultImgResolutionHeight, completion: { (image) in
            
            completion(image)
        }) { (image) in
            failure(image)
        }
    }
    
    public static  func updateImageOrientionUpSide(image: UIImage) -> UIImage? {
        if image.imageOrientation == .up {
            return image
        }
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        if let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        }
        UIGraphicsEndImageContext()
        return nil
    }
}

extension DCUIImagePicker:MPMediaPickerControllerDelegate{
    
    public func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        //let mediaItems = mediaItemCollection.items
        mediaPicker.dismiss(animated: true, completion: nil)
    }
    
    public func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController){
        
        mediaPicker.dismiss(animated: true, completion: nil);
    }
}

extension DCUIImagePicker: CropViewControllerDelegate {
  public func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation) {
    self.sucessCompletion?(cropped)
    cropVC?.dismiss(animated: true, completion: nil)
  }
  
  public func cropViewControllerDidFailToCrop(_ cropViewController: CropViewController, original: UIImage) {
    cropVC?.dismiss(animated: true, completion: nil)
  }
  
  public func cropViewControllerDidCancel(_ cropViewController: CropViewController, original: UIImage) {
    cropVC?.dismiss(animated: true, completion: nil)
  }
  
  public func cropViewControllerDidBeginResize(_ cropViewController: CropViewController) {
    
  }
  
  public func cropViewControllerDidEndResize(_ cropViewController: CropViewController, original: UIImage, cropInfo: CropInfo) {
    
  }
  
  
}
