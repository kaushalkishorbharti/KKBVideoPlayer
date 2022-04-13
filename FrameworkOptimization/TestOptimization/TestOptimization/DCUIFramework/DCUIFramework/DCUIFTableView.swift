//
//  DCUIFTableView.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 23/05/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit

public protocol DCUIFTableViewDelegate {
    func loadRefreshData(sender: DCUIFTableView);
    func loadMoreData(sender: DCUIFTableView);
}

public class DCUIFTableView:UITableView{
    
    var isKeyBoardOpen:Bool=false;
    public var isMultipleSection:Bool = false;
    public var limit:Int = 10;
    public var loadBeforeIndex:Int = 1;
    public var noDataValue:String = "No data";
    public var isInitial:Bool = true;
    override public func awakeFromNib(){
        super.awakeFromNib();
        self.tableFooterView=nil;
        addRefrsh();
    }
    public func registerNotification(isRegister:Bool){
        
        if(isRegister){
           // NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardDidChangeFrame, object: nil);
           // NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        }
        else{
            NotificationCenter.default.removeObserver(self);
        }
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        
        if(!isKeyBoardOpen && !(((keyboardSize?.origin.y)!+44) == UIScreen.main.bounds.size.height)){
            isKeyBoardOpen=true;
            UIView.animate(withDuration: 0.3, animations: {
                self.frame.origin.y =  CGFloat(self.frame.origin.y-((((keyboardSize?.size.height)!-20))));
            })
            
            return;
        }
        
        
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        
        if(isKeyBoardOpen){
            let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            isKeyBoardOpen=false;
            UIView.animate(withDuration: 0.3, animations: {
                
                self.frame.origin.y =  CGFloat(self.frame.origin.y+((((keyboardSize?.size.height)!-20))));
                self.scrollToBottom()
                
            })
        }
    }
    
    public var dcuifTableViewDelegate:DCUIFTableViewDelegate?
    public var dataSet:NSMutableArray = NSMutableArray.init();
    public var isLoadMore:Bool = false;
    public var lastCellFrame:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0);
    
    public func reloadDataSet() {
    
        if (self.dataSet.count>0) {
            self.backgroundView=nil;
            
           
        }
        else if(isInitial){
            self.backgroundView=nil;
        }
        else{
            self.backgroundView=DCUIFNoDataView.getView(string:noDataValue);
        }
        
    }
     
    public func scrollToBottom(){
        if(self.dataSet.count>0){
            DispatchQueue.global(qos: .background).async {
                let indexPath = IndexPath(row: self.dataSet.count-1, section: 0)
                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    public override func reloadData() {
         super.reloadData();
         reloadDataSet();
       
    }
    
    override public func layoutSubviews() {
        
        if (self.dataSet.count>0 || isMultipleSection == true) {
            super.layoutSubviews();
            if (isLoadMore) {
                loadMore();
                isLoadMore=false;
            }
        }
        else{
            
            self.reloadDataSet()
        }
        
    }
    override public func didMoveToWindow() {
       
        
    }
    public func checkForLoadMore(indexPath:IndexPath){
        
        let tableView:DCUIFTableView=self ;
        if ((self.dataSet.count-1)-self.loadBeforeIndex == indexPath.row ) {
            
            //print("Index",indexPath.row);
            tableView.isLoadMore=true;
        }
        else{
            tableView.isLoadMore=false;
        }
    }
    
    public func addRefrsh(){
        let refreshControl = UIRefreshControl();
        refreshControl.backgroundColor = UIColor.white;
        refreshControl.tintColor = DCUIFTheme.sharedInstance.appTheme?.primaryColor;
        refreshControl.addTarget(self, action: #selector(DCUIFTableView.refreshData(sender:)), for: UIControlEvents.valueChanged)
        self.addSubview(refreshControl);
    }
    
    override public func footerView(forSection section: Int) -> UITableViewHeaderFooterView? {
        
        return super.footerView(forSection: section);
    }
    
    override public func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
       // print("cell for row");
        return super.cellForRow(at: indexPath);
    }
    
    @objc public func  refreshData(sender:UIRefreshControl){
        
        
        dcuifTableViewDelegate?.loadRefreshData(sender: self);
        sender.endRefreshing();
    }
    
    public func loadMore(){
        dcuifTableViewDelegate?.loadMoreData(sender: self);
        
    }
}

