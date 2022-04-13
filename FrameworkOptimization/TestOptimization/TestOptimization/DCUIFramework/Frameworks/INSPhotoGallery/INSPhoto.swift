//
//  INSPhoto.swift
//  INSPhotoViewer
//
//  Created by Michal Zaborowski on 28.02.2016.
//  Copyright © 2016 Inspace Labs Sp z o. o. Spółka Komandytowa. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this library except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import Foundation
import UIKit
/*
 * This is marked as @objc because of Swift bug http://stackoverflow.com/questions/30100787/fatal-error-array-cannot-be-bridged-from-objective-c-why-are-you-even-trying when passing for example [INSPhoto] array
 * to INSPhotosViewController
 */
@objc public protocol INSPhotoViewable: class {
    var image: UIImage? { get }
    var thumbnailImage: UIImage? { get }
    @objc optional var isDeletable: Bool { get }
    
    func loadImageWithCompletionHandler(_ completion: @escaping (_ image: UIImage?, _ error: Error?) -> ())
    func loadThumbnailImageWithCompletionHandler(_ completion: @escaping (_ image: UIImage?, _ error: Error?) -> ())
    
    var attributedTitle: NSAttributedString? { get }
}

@objc open class INSPhoto: NSObject, INSPhotoViewable {
    
    
    public enum FileType{
        
        
        
        case FileTypeImage
        case FileTypeVideo
        case FileTypeDocument
        case FileTypeAudio
        
    }
    
    @objc open var image: UIImage?
    @objc open var thumbnailImage: UIImage?
    @objc open var isDeletable: Bool
    open var fileType:FileType = .FileTypeImage
    
    var imageURL: URL?
    var thumbnailImageURL: URL?
    
    @objc open var attributedTitle: NSAttributedString?
    
    public init(image: UIImage?, thumbnailImage: UIImage?) {
        self.image = image
        self.thumbnailImage = thumbnailImage
        self.isDeletable = false
    }
    
    public init(imageURL: URL?, thumbnailImageURL: URL? ,fileType:FileType) {
        self.imageURL = imageURL
        self.thumbnailImageURL = thumbnailImageURL
        self.isDeletable = false
        self.fileType = fileType;
    }
    
    public init (imageURL: URL?, thumbnailImage: UIImage?) {
        self.imageURL = imageURL
        self.thumbnailImage = thumbnailImage
        self.isDeletable = false
    }
    
    @objc open func loadImageWithCompletionHandler(_ completion: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        if let image = image {
            completion(image, nil)
            return
        }
        
        loadImageWithURL(imageURL, completion: completion)
    }
    @objc open func loadThumbnailImageWithCompletionHandler(_ completion: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        if let thumbnailImage = thumbnailImage {
            completion(thumbnailImage, nil)
            return
        }
        loadImageWithURL(thumbnailImageURL, completion: completion)
    }
    
    open func loadImageWithURL(_ url: URL?, completion: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        
        
        
        
        if(url != nil && url?.absoluteString.range(of: "http") == nil){
            let image = UIImage.init(contentsOfFile: (url?.absoluteString)!);
            completion(image, nil)
            return
        }
        
        if url != nil{
        DCUIFImageView.downloadImage(link: (url?.absoluteString)!) { (image:UIImage) in
            completion(image, nil)
        }
        }
        return;
        
    }
}

public func ==<T: INSPhoto>(lhs: T, rhs: T) -> Bool {
    return lhs === rhs
}
