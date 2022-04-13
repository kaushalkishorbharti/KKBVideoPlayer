//
//  DCUIFGalleryCell.swift
//  DCUIFramework
//
//  Created by Docquity on 9/23/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit



internal class DCUIFGalleryCell: UICollectionViewCell {
    @IBOutlet weak var mediaImg: DCUIFImageView!
   // var mediaData:DCFMedia? = nil;

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


  internal func setCellData(imageUrl:String)
  {
    let image:UIImage = UIImage.init(named: DCUIFImageView.IMAGE_PLACEHOLDER, in: DCUIFramework.bundle, compatibleWith: nil)!
    mediaImg.dcLoadImageFromRemotePath(path:imageUrl , placeHolderImage:image)

    }
    
}
