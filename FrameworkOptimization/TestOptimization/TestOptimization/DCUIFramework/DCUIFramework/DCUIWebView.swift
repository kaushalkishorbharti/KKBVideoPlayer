//
//  DCUIWebView.swift
//  DCUIFramework
//
//  Created by Anhinav Agarwal on 19/06/17.
//  Copyright © 2017 Abhinav Agarwal. All rights reserved.
//

import UIKit


public enum DCUIUniversalLinkHostType:String{
    
    case docquity = "docquity.com",
    devDocquity = "dev.docquity.com",
    branch = "docquity.app.link",
    branchTest = "docquity.test-app.link",
    openImage = "openImage",
    openVideo = "openVideo",
//    dapiDocqity = "dapi.docquity.com",
    none = ""
    
}


public protocol DCUIWebViewDelegate{
    func webViewactionPerformed(action:String,data:Dictionary<String, Any>?,webview:DCUIWebView) -> Bool;
    func openResult(dict: NSDictionary)
    func downlaodCertificate(_ certificateURL: String)
    //func webViewactionPerformedForPayment(action:String,data:Dictionary<String, Any>?,webview:DCUIWebView) -> Bool;
  
}

public class DCUIWebView: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    public var linkString:String? = ""
    public var pageTitle:String? = ""
    public var isShowSaveShare:Bool = false
    public var isZoomEnable: Bool = false
    public static var apiHeaders: [String: String] = [:]
    public var delegate:DCUIWebViewDelegate? = nil
    public var uniqueSurveyNotificationId: String?
    public var isHideShowNavigationTillLoad:Bool = false
    public var previousRequest:URLRequest?
    
    public var isForDrugOrder: Bool = false
    var startloading: Bool = false
    public var completionHandler: (( _ status: Bool)->Void)?

  
    public static func isURLContaintDocuuityHost(urlString:String) -> Bool {
        var isContainsDocuityHost: Bool = false
        let urlString = urlString
        let url = NSURL(string: urlString)
        if let domain = url?.host {
            isContainsDocuityHost = domain.contains("docquity.com")
        }
        return isContainsDocuityHost
    }
    
    
    public static func getUniversalLinkType(host:String) -> DCUIUniversalLinkHostType{
        return DCUIUniversalLinkHostType.init(rawValue: host) ?? .none;
    }
    
    public static func isLinkOfHostTypeInapp(link:String)->Bool{
        
        //debugPrint(DCUIWebView.getUniversalLinkType(host: URL.init(string: link)?.host ?? ""))
        let hostType: DCUIUniversalLinkHostType = DCUIWebView.getUniversalLinkType(host: URL.init(string: link)?.host ?? "")
        
        switch hostType {
        case .branch,.branchTest:
            return true;
        case .devDocquity, .docquity:
            return true;
        case .none:
            return false;
        case .openVideo:
            return true;
        case .openImage:
            return true;
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad();
      /*  DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            
            self.webView.loadHTMLString("<div class=\"ckeditor-html5-video\" data-responsive=\"true\" style=\"text-align: center;\"><video controls=\"true\" width='100%' height='400' src=\"http://bucket.docquity.com/journals/editor/file-6b443b2c28d5c15da78bb3dfe9e24f5e.mp4\"></video></div><p>&nbsp;</p>", baseURL: nil)
            
        }*/
        
        
        
        
        startloading = true
        
        webView.delegate = self
        let url:NSURL?
        if ((linkString?.lowercased().contains("https://".lowercased()))! || (linkString?.lowercased().contains("https//".lowercased()))! || (linkString?.lowercased().contains("http://".lowercased()))!){
        } else if (linkString?.lowercased().contains("www.".lowercased()))! {
            linkString = "http://\(String(describing: linkString!))"
        }
        
        if self.linkString?.lowercased().range(of:"http://".lowercased()) != nil {
            linkString = linkString?.replacingOccurrences(of:" ", with: "%20")
             url = NSURL (string: self.linkString!);
        } else if self.linkString?.lowercased().range(of:"https://".lowercased()) != nil {
            linkString = linkString?.replacingOccurrences(of:" ", with: "%20")
            url = NSURL (string: self.linkString!);
        } else {
             url = NSURL(fileURLWithPath:self.linkString!)
        }
       
//        let requestObj = NSURLRequest.init(url: url! as URL);
        if var previousRequest = previousRequest {
            for (key, value) in DCUIWebView.apiHeaders {
                previousRequest.setValue(value, forHTTPHeaderField: key)
            }
            webView.loadRequest(previousRequest)
        } else {
            if let url = url {
                let requestObj = NSMutableURLRequest.init(url: url as URL);
                requestObj.setValue("https://docquity.com/", forHTTPHeaderField: "Referer")
                //requestObj.setValue("https://docquity.com/", forHTTPHeaderField: "HTTP_REFERER")
                
                if let urlString = self.linkString {
                    if DCUIWebView.isURLContaintDocuuityHost(urlString: urlString) {
                        for (key, value) in DCUIWebView.apiHeaders {
                            requestObj.setValue(value, forHTTPHeaderField: key)
                        }
                    }
                    requestObj.setValue("4.3", forHTTPHeaderField: "ver")
                }
                
                
                
                webView.loadRequest(requestObj as URLRequest)
            }
        }
        
        
        self.navigationController?.navigationBar.isHidden = false;
        self.navigationItem.title = pageTitle;
        

        if isZoomEnable{
            webView.scalesPageToFit = true;
            webView.isMultipleTouchEnabled = true;
        }else{
            webView.scalesPageToFit = false;
            webView.isMultipleTouchEnabled = false;
        }

        
        self.setShareButtonOnNavigation();
    }
    
    private func setShareButtonOnNavigation() {
        if(isShowSaveShare == true) {
            self.navigationItem.rightBarButtonItem = DCUIFNavigationController.addMoreButtonToNavigation(selctor: #selector(moreOptionClick), target: self);
        } else {
        }
    }
   
 
    public static func getView(link:String,pageTitle:String,isShare:Bool,isZoomEnable: Bool = false,isNavHidden:Bool = false) -> DCUIWebView {

        let frameworkBundle =  DCUIFramework.bundle
        let storyBoard : UIStoryboard = UIStoryboard(name: "DCUIFramework", bundle:frameworkBundle)
        let vc:DCUIWebView = (storyBoard.instantiateViewController(withIdentifier: "DCUIWebView") as? DCUIWebView)!;
        vc.linkString = link;
        vc.pageTitle  = pageTitle;
        vc.isShowSaveShare = isShare;
        vc.isZoomEnable = isZoomEnable;
        vc.navigationController?.isNavigationBarHidden = isNavHidden;
        return vc;
    }
    @objc public func moreOptionClick(){
        
        var style = UIAlertController.Style.actionSheet
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            style = UIAlertController.Style.alert
        }
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: style)
        
        // create an action
        let firstAction: UIAlertAction = UIAlertAction(title: "Share/Save", style: .default) { action -> Void in
          
            self.delegate?.downlaodCertificate(self.linkString ?? "")
//            let vc:UIViewController = DCUIFViewController.getTopViewController();
//            DCUIShare.shareBtnClick(fromVC: vc, shareTitle: "", shareContent: self.linkString!, shareEmailContent:self.linkString!);
            
            
            
        }
        
        let _: UIAlertAction = UIAlertAction(title: "Save", style: .default) { action -> Void in
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        // add actions
        actionSheetController.addAction(firstAction)
        //actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancelAction)
        
        // present an actionSheet...
        present(actionSheetController, animated: true, completion: nil)
    }
    public static func getView(link:String,pageTitle:String,isShowSaveShare:Bool = false,isZoomEnable: Bool = false,isNavHidden:Bool = false) -> DCUIWebView {
        let frameworkBundle =  DCUIFramework.bundle
        let storyBoard : UIStoryboard = UIStoryboard(name: "DCUIFramework", bundle:frameworkBundle)
        let vc:DCUIWebView = (storyBoard.instantiateViewController(withIdentifier: "DCUIWebView") as? DCUIWebView)!;
        vc.linkString = link;
        vc.pageTitle  = pageTitle;
        vc.isShowSaveShare = isShowSaveShare;
        vc.isZoomEnable = isZoomEnable;
        vc.navigationController?.isNavigationBarHidden = isNavHidden;
        vc.hidesBottomBarWhenPushed = true;
        return vc;
        
    }
    
    //MARK: ----------UIWebView Delegates Methods---------
    
    public func webViewDidStartLoad(_ webView: UIWebView) {
       // DCUIFLoader.startLoading()
        if self.linkString?.contains("pdf") == true {
            DCUIFLoader.startLoading()
        } else {
            DCUIFLoader.stopLoading()
        }
      
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView) {
        self.title = webView.stringByEvaluatingJavaScript(from: "document.title")
        if isHideShowNavigationTillLoad {
            self.navigationController?.isNavigationBarHidden = true
        }
        DCUIFLoader.stopLoading()
       // if let html = webView.stringByEvaluatingJavaScript(from: "document.body.innerHTML") {
            //print("html content of page =[\(html)]")
        //}
    }
    
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        DCUIFLoader.stopLoading();
    }
    
   

    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //imagecallback:https://s3-ap-southeast-1.amazonaws.com/bucket.docquity.com/random_file/image/153112768fee2c27.jpg
        let stringUrl = request.url!.absoluteString
        
        if(startloading == true){
            startloading = false;
            return true
        }
        
        if (delegate != nil) {
            let action = request.url?.valueOfUrlParameter("action")
          
            if(action != nil){
                if action == "survey_end" {
                    let dataString = request.url?.valueOfUrlParameter("data")
                    if let uniqueSurveyNotificationId = self.uniqueSurveyNotificationId {
                        let dict: NSDictionary = ["data": dataString ?? "", "uniqueString": uniqueSurveyNotificationId]
                        if self.isForDrugOrder {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "surveyCompleted"), object: self, userInfo: dict as? [AnyHashable : Any])
                            }
//
                        } else {
                            self.uniqueSurveyNotificationId = nil
                            self.delegate?.openResult(dict: ["data": dataString ?? "", "uniqueString": uniqueSurveyNotificationId])
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "survey"), object: self, userInfo: dict as? [AnyHashable : Any])
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "surveyCompleted"), object: self, userInfo: dict as? [AnyHashable : Any])
                        }
                    }
                } else if action == "save_and_continue_later" {
                    let dataString = request.url?.valueOfUrlParameter("data")
                    if let uniqueSurveyNotificationId = self.uniqueSurveyNotificationId {
                        let dict: NSDictionary = ["data": dataString ?? "", "uniqueString": uniqueSurveyNotificationId]
                        self.uniqueSurveyNotificationId = nil
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "surveySaved"), object: self, userInfo: dict as? [AnyHashable : Any])
                    }
                } else if action == "discard_survey" {
                    let dataString = request.url?.valueOfUrlParameter("data")
                    if let uniqueSurveyNotificationId = self.uniqueSurveyNotificationId {
                        let dict: NSDictionary = ["data": dataString ?? "", "uniqueString": uniqueSurveyNotificationId]
                        self.uniqueSurveyNotificationId = nil
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "surveyDiscard"), object: self, userInfo: dict as? [AnyHashable : Any])
                    }
                }
                let status = self.delegate?.webViewactionPerformed(action: action ?? "", data: nil, webview: self)
                return status ?? true;
            }
            else{
                return true;
            }
        } else {
            
            
            let currentURL = NSURL(string: stringUrl)
//            debugPrint("------WebURL-----")
//            debugPrint(stringUrl)
//            debugPrint("-----------------")
            if (stringUrl.contains("closewindow:")) {
                if self.navigationController != nil {
                    self.navigationController?.popViewController(animated: true);
                } else {
                    self.dismiss(animated: true) {
                    }
                }
                return true
            }
            else if (stringUrl.contains("action=closewindow")) {
                if self.navigationController != nil {
                    self.navigationController?.popViewController(animated: true);
                    
                    if DCUIWebView.isLinkOfHostTypeInapp(link: stringUrl) {
                        var pData: [String: Any] = ["link":currentURL ?? ""]
                        if request.httpMethod == "POST" {
                            pData["isPost"] = request
                        }
                        NotificationCenter.default.post(name: Notification.Name("OpenUniversalLinkFromWebView"), object: nil, userInfo: pData)
                        return false
                    }
                    
                } else {
                    self.dismiss(animated: true) {
                        if DCUIWebView.isLinkOfHostTypeInapp(link: stringUrl) {
                            var pData: [String: Any] = ["link":currentURL ?? ""]
                            if request.httpMethod == "POST" {
                                pData["isPost"] = request
                            }
                            NotificationCenter.default.post(name: Notification.Name("OpenUniversalLinkFromWebView"), object: nil, userInfo: pData)
                        }
                    }
                }
                return true
            }
            else {
                if DCUIWebView.isLinkOfHostTypeInapp(link: stringUrl) {
                    var pData: [String: Any] = ["link":currentURL ?? ""]
                    if request.httpMethod == "POST" {
                        pData["isPost"] = request
                    }
                    NotificationCenter.default.post(name: Notification.Name("OpenUniversalLinkFromWebView"), object: nil, userInfo: pData)
                    return false
                }
                
//                NotificationCenter.default.post(name: Notification.Name("OpenUniversalLinkFromWebView"), object: nil, userInfo: ["link":currentURL])
                return true
            }
        }
        
       
    }

}



extension URL {
    func valueOfUrlParameter(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}


