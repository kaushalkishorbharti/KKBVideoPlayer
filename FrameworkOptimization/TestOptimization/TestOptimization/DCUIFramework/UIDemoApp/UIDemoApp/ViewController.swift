//
//  ViewController.swift
//  UIDemoApp
//
//  Created by Anhinav Agarwal on 23/05/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit
import DCUIFramework


class ViewController: UIViewController,DCUIFTableViewDelegate {
    
    @IBOutlet weak var socailView: DCUIFSocialView!
    @IBOutlet weak var tableView: DCUIFTableView!
    var items = 10;
    
    @IBOutlet var imageView: DCUIFImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
       tableView.delegate=self;
        tableView.dataSource=self;
        tableView.dataSetCount=10;
        tableView.dcuifTableViewDelegate=self;
        imageView.dcLoadImageFromRemotePath(path: "http://wallpapersdsc.net/wp-content/uploads/2016/10/The-Heavy-Computer-Wallpaper.jpg", placeHolderImage: UIImage(named:"placeholder")!);
        
        self.socailView=DCUIFSocialView.getView();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    

}
extension ViewController:UITableViewDataSource{
    
 func numberOfSections(in tableView: UITableView) -> Int {
 return 1;
 }
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return 10;
 }
}


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell.init();
        return cell;
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row==6) {
            
            let tableView:DCUIFTableView=tableView as! DCUIFTableView;
            tableView.isLoadMore=true;
        }
        cell.textLabel?.text = "Cell \(indexPath.row)"
    }
    
    func loadMoreData(sender: DCUIFTableView) {
        print("Delegate Called Refresh")
    }
    func loadRefreshData(sender: DCUIFTableView) {
        print("Delegate Called More")
    }
}

