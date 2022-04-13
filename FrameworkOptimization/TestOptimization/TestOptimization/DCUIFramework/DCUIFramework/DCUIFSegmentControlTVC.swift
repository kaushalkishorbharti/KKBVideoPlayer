//
//  DCUIFSegmentControlTVC.swift
//  DCUIFramework
//
//  Created by Abhinav Agarwal on 12/29/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit

public class DCUIFSegmentControlTVC: UITableViewCell {

    @IBOutlet public weak var segmentControl: DCUIFSegmentControl!
  public  override func awakeFromNib() {
        super.awakeFromNib()
   

//    self.segmentControl.backgroundColor = UIColor.white;
//    self.segmentControl.highlightColor = UIColor.white;
//    self.segmentControl.tint = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0);
//    self.segmentControl.highlightTint = UIColor.black;
    
    self.segmentControl.backgroundColor = UIColor.white;
    self.segmentControl.selectedItemHighlightStyle = .bottomEdge;
    self.segmentControl.highlightColor =
        UIColor.init(red: 186/255, green: 0/255, blue: 0/255, alpha: 1);
    self.segmentControl.tint = UIColor.gray;
        //UIColor.init(red: 186/255, green: 0/255, blue: 0/255, alpha: 1);
    self.segmentControl.highlightTint = UIColor.black;
        //UIColor.init(red: 186/255, green: 0/255, blue: 0/255, alpha: 1);
    self.layer.borderWidth = 0.25;
    self.layer.borderColor = UIColor.lightGray.cgColor;
    
    }

  public  override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc public  class func getView() -> UITableViewCell {
        return UINib(nibName: "DCUIFSegmentControlTVC", bundle: DCUIFramework.bundle).instantiate(withOwner: nil, options: nil)[0] as! UITableViewCell
    }
    
    public  static func getNib() -> UINib{
        
        return UINib(nibName: "DCUIFSegmentControlTVC", bundle: DCUIFramework.bundle);
    }
    
    @objc public  class func registerCellForTableView(tableView:UITableView){
        
        tableView.register(getNib(), forCellReuseIdentifier: cellIdentifier())
    }
    
    @objc  public class func cellIdentifier() -> String{
        return "DCUIFSegmentControlTVC";
    }
    
}
