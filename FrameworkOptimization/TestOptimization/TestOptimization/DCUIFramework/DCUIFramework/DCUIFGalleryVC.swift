//
//  DCUIFGalleryVC.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 08/09/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit

public class DCUIFGalleryVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var photoGallaryArray:NSArray =  NSArray();
   
    override public func viewDidLoad() {
        super.viewDidLoad()
     
        self.collectionView.register(UINib(nibName: "DCUIFGalleryCell", bundle: DCUIFramework.bundle), forCellWithReuseIdentifier: "DCUIFGalleryCell")
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        self.collectionView.reloadData();
        
    }

    public static func getView(array:NSArray) -> DCUIFGalleryVC {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "DCUIFramework", bundle:DCUIFramework.bundle)
        let vc:DCUIFGalleryVC = (storyBoard.instantiateViewController(withIdentifier: "DCUIFGalleryVC") as? DCUIFGalleryVC)!;
        
        vc.photoGallaryArray =  array;
        return vc;
    }
 
}


extension DCUIFGalleryVC:UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (photoGallaryArray.count)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2;
       
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:DCUIFGalleryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DCUIFGalleryCell", for: indexPath as IndexPath) as! DCUIFGalleryCell
        cell.setCellData(imageUrl: self.photoGallaryArray[indexPath.row] as! String)
        return cell;
       
    }
    

}


extension DCUIFGalleryVC:UICollectionViewDelegate
{
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        DCUIImage.shwowImagePreview(urlString: self.photoGallaryArray[indexPath.row] as! String , vc: self)
    
    }
  
}

extension DCUIFGalleryVC: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let padding: CGFloat = 50
//        let collectionCellSize = collectionView.frame.size.width - padding
//        return CGSize(width: collectionCellSize/2, height: collectionCellSize/2)
        let  width = view.frame.width/2 - 0.5;
        return CGSize(width: width, height: 200);

    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1;
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1;
    }
}


