//
//  DCUIFPollTVC.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 19/10/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit


public class DCUIFPollTVC: UITableViewCell {

    @IBOutlet weak var lblPollValue: DCUIFLabel!
    @IBOutlet weak var lblPollPercent: DCUIFLabel!
    @IBOutlet weak var imageRadio: DCUIFImageView!
    @IBOutlet weak var view: UIView!
    var progressView:UIProgressView!
    override public func awakeFromNib() {
        super.awakeFromNib()
        //self.contentView.backgroundColor = UIColor.red;
        //self.view.backgroundColor = UIColor.blue;
        self.backgroundView?.backgroundColor = UIColor.red;
        progressView = UIProgressView.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width+50, height: 100));
        self.view.addSubview(progressView);
        self.view.sendSubview(toBack: progressView);
        self.clipsToBounds =  true;
        // Initialization code
    }
    
    public override func draw(_ rect: CGRect) {
        
       
        
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc public func setData(name:String,percentage:Float,value:Any,isSelected:Bool,pollStatus:Int,isPollType:Bool = true,isMultiSelect:Bool = false)
    {
    
        self.imageRadio.dcLoadImageFromRemotePath(path: DCUIFImageView.IMAGE_RADIO_BOX_UNSELECTED, placeHolderImage: UIImage.init(named: DCUIFImageView.IMAGE_RADIO_BOX_UNSELECTED, in: DCUIFramework.bundle, compatibleWith: nil));
        
        self.backgroundView = nil;
        self.lblPollValue.text =  name;
        self.lblPollPercent.text = String(percentage) + "%";
        
        
        if(isPollType == true){
            if pollStatus == 1
            {
                 self.imageRadio.dcLoadImageWithImage(image: UIImage.init(named: DCUIFImageView.IMAGE_RADIO_BOX_UNSELECTED, in: DCUIFramework.bundle, compatibleWith: nil)!)
                self.imageRadio.isHidden = true;
                self.lblPollPercent.isHidden = false;
                self.setPercentageFill(percentage: percentage,isSelected:isSelected);
            }
            else
            {
                 self.imageRadio.dcLoadImageWithImage(image: UIImage.init(named: DCUIFImageView.IMAGE_RADIO_BOX_UNSELECTED, in: DCUIFramework.bundle, compatibleWith: nil)!)
                self.imageRadio.isHidden = false;
                self.lblPollPercent.isHidden = true;
                self.setPercentageFill(percentage: 0,isSelected:isSelected);
            }
            self.selectionStyle = .none;
        }
        else{
            self.imageRadio.isHidden = false;
            self.lblPollPercent.isHidden = true;
            self.setPercentageFill(percentage: 0,isSelected:isSelected);
          
            
            
            if(isMultiSelect == true){
                
                if(pollStatus == 1){
                    
                    self.imageRadio.dcLoadImageWithImage(image: UIImage.init(named: DCUIFImageView.IMAGE_CHECK_BOX_SELECTED, in: DCUIFramework.bundle, compatibleWith: nil)!);
                }
                else{
                   
                    self.imageRadio.dcLoadImageWithImage(image: UIImage.init(named: DCUIFImageView.IMAGE_CHECK_BOX_UNSELECTED, in: DCUIFramework.bundle, compatibleWith: nil)!);
                }
                
            }
            else{
                if(pollStatus == 1){
                    
                    self.imageRadio.dcLoadImageWithImage(image:UIImage.init(named: DCUIFImageView.IMAGE_RADIO_BOX_SELECTED, in: DCUIFramework.bundle, compatibleWith: nil)! )
                }
                else{
                    
                    self.imageRadio.dcLoadImageWithImage(image: UIImage.init(named: DCUIFImageView.IMAGE_RADIO_BOX_UNSELECTED, in: DCUIFramework.bundle, compatibleWith: nil)!)
                   
                }
            }
           
            
            
        }
        
    
        
    }
    
    @objc public func setPercentageFill(percentage:Float,isSelected:Bool){
        
        if(percentage == 0){
             progressView.progress = 0;
        }
        else{
             progressView.progress = percentage/100;
        }
       
        progressView.trackTintColor = UIColor.white
            //UIColor.rgbColor(red: 255.0, green: 238.0, blue: 238.0, alpha: 1);
        
        if (isSelected)
        {
        progressView.progressTintColor =  UIColor.rgbColor(red: 235.0, green: 196.0, blue: 196.0, alpha: 1)
        }
        else{
            progressView.progressTintColor =
                UIColor.rgbColor(red: 255.0, green: 238.0, blue: 238.0, alpha: 1);
           
            }
        
        let transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 50.0)
        progressView.transform = transform
        
        return;
        
    }
    
   
    @objc public  class func getView() -> UITableViewCell {
        return UINib(nibName: "DCUIFPollTVC", bundle:DCUIFramework.bundle ).instantiate(withOwner: nil, options: nil)[0] as! UITableViewCell
    }
    
    public  static func getNib() -> UINib{
        
        return UINib(nibName: "DCUIFPollTVC", bundle:DCUIFramework.bundle);
    }
    
    @objc public  class func registerCellForTableView(tableView:UITableView){
        
        tableView.register(getNib(), forCellReuseIdentifier: cellIdentifier())
    }
    
    @objc  public class func cellIdentifier() -> String{
        return "DCUIFPollTVC";
    }
    
    @objc internal class func getHeight() -> CGFloat{
        return UITableViewAutomaticDimension;
    }

}
