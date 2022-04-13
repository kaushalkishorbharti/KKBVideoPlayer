//
//  DCUIFNoContentWithButtonView.swift
//  DCUIFramework
//
//  Created by kaushal kishor on 11/06/18.
//  Copyright © 2018 Abhinav Agarwal. All rights reserved.
//

import UIKit

public protocol DCUIFNoContentWithButtonViewProtocol:class {
    
    func exploreNowClicked();
    func visitClinicalCaseClicked();
    func tryNewCourcesClicked();
}
    
public class DCUIFNoContentWithButtonView: UIView {

    public var delegate:DCUIFNoContentWithButtonViewProtocol?;

    var screenType: DCFEmptyScreenType = .none;

    public  enum DCFEmptyScreenType:Int{
        
        case none = 0
        case  cmeNotPassed = 1
        case  download = 2
        case  bookmark = 3
        case  stats = 4
        case  history = 5
        
    }
    
    @IBOutlet weak var viewRoot: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewData: UIView!
    @IBOutlet weak var viewPlaceholder: UIView!
    @IBOutlet weak var imgView: DCUIFImageView!
    @IBOutlet weak var lblTitle: DCUIFLabel!
    @IBOutlet weak var lblDescription: DCUIFLabel!
    @IBOutlet weak var btnExplore: DCUIFButton!
    @IBOutlet weak var btnLearnMore: DCUIFButton!
    @IBOutlet weak var lblTrySomethingOther: DCUIFLabel!
    @IBOutlet weak var viewUnderline: UIView!
    
    @IBOutlet weak var learnMoreHeightConstraint: NSLayoutConstraint!
    @IBAction func btnExploreNowClicked(_ sender: DCUIFButton) {
        
        self.delegate?.exploreNowClicked();
    }
    
    
    @IBAction func btnLearnMoreClicked(_ sender: DCUIFButton) {
        
        self.delegate?.visitClinicalCaseClicked();
    }
    

    
    @IBInspectable public var titleText:String = "" {
        
        didSet{
            lblTitle.text = titleText;
        }
    };
    
    @IBInspectable public var descriptionText:String = "" {
        
        didSet{
            lblDescription.text = descriptionText;
        }
    };
    
    
    @IBInspectable public var btnExploreText:String = "" {
        
        didSet{
            btnExplore.setTitle(btnExploreText, for: .normal);
        }
    };
    
    @IBInspectable public var btnLearnMoreText:String = "" {
        
        didSet{
            btnLearnMore.setTitle(btnLearnMoreText, for: .normal);
        }
    };
    
    
    @IBInspectable public var othersText:String = "" {
        
        didSet{
            lblTrySomethingOther.text = othersText;
        }
    };
    
    
    var view: UIView!
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        
        addSubview(view)
        self.view = view
        configureView();
    }
    
    
    private func configureView()
    {
        addGestureToView();
//        lblTitle.text = "Not Passed";
//        lblDescription.text = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using  ";
        
        
    }
    
    func addGestureToView(){
        
        let tapSomethingOther = UITapGestureRecognizer(target: self, action: #selector(self.openOther(sender:)));
        self.lblTrySomethingOther.addGestureRecognizer(tapSomethingOther);
        
    }
    
    @objc func openOther(sender:UIView){
        
        self.delegate?.tryNewCourcesClicked();
        
    }
    
    public func setCustomViewData(type: DCUIFNoContentWithButtonView.DCFEmptyScreenType,title: String,detail: String,btnExploreText: String,btnLearnMoreText: String,otherText: String){
        
        self.lblTitle.text = title;
        self.lblDescription.text = detail;
        self.lblTrySomethingOther.text = otherText;
        if( btnExploreText == ""){
            
            self.btnExplore.isHidden = true;
        }
        else{
              self.btnExplore.isHidden = false;
              self.btnExplore.setTitle(btnExploreText, for: .normal);
        }
        if( btnLearnMoreText == ""){
            
            self.btnLearnMore.isHidden = true;
        }
        else{
            self.btnLearnMore.isHidden = false;
            self.btnLearnMore.setTitle(btnLearnMoreText, for: .normal);
        }
        
      
        
        self.setPlaceholderImage(type: type);
        self.showHideOtherText(type: type);
        self.showHideLearnMore(type: type);
    }

    private func setPlaceholderImage(type: DCUIFNoContentWithButtonView.DCFEmptyScreenType)
    {
        switch type {
        case DCUIFNoContentWithButtonView.DCFEmptyScreenType.cmeNotPassed:
            imgView.image = UIImage.init(named: "placeholder-cme-failed", in: DCUIFramework.bundle, compatibleWith: nil);
            break;
        case DCUIFNoContentWithButtonView.DCFEmptyScreenType.download:
            imgView.image = UIImage.init(named: "placeholder-no-download", in: DCUIFramework.bundle, compatibleWith: nil);
            break;
        case DCUIFNoContentWithButtonView.DCFEmptyScreenType.bookmark:
            imgView.image = UIImage.init(named: "placeholder-no-bookmark", in: DCUIFramework.bundle, compatibleWith: nil);
            lblTrySomethingOther.isHidden = true;
            viewUnderline.isHidden = true;
            break;
        case DCUIFNoContentWithButtonView.DCFEmptyScreenType.stats:
            imgView.image = UIImage.init(named: "stats-image", in: DCUIFramework.bundle, compatibleWith: nil);
            lblTrySomethingOther.isHidden = true;
            viewUnderline.isHidden = true;
            break;
        case DCUIFNoContentWithButtonView.DCFEmptyScreenType.history:
            imgView.image = UIImage.init(named: "history-image", in: DCUIFramework.bundle, compatibleWith: nil);
            lblTrySomethingOther.isHidden = true;
            viewUnderline.isHidden = true;
            break;
             
        default:
            return;
        }
    }
    
    private func showHideOtherText(type: DCUIFNoContentWithButtonView.DCFEmptyScreenType)
    {
        switch type {
        case DCUIFNoContentWithButtonView.DCFEmptyScreenType.cmeNotPassed:
            lblTrySomethingOther.isHidden = false;
            viewUnderline.isHidden = false;

            break;
        case DCUIFNoContentWithButtonView.DCFEmptyScreenType.download:
            lblTrySomethingOther.isHidden = true;
            viewUnderline.isHidden = true;

            break;
        case DCUIFNoContentWithButtonView.DCFEmptyScreenType.bookmark:
            
            lblTrySomethingOther.isHidden = true;
            viewUnderline.isHidden = true;
            break;
            
        default:
            return;
        }

    }
    
    private func showHideLearnMore(type: DCUIFNoContentWithButtonView.DCFEmptyScreenType)
    {
        switch type {
        case DCUIFNoContentWithButtonView.DCFEmptyScreenType.cmeNotPassed:
           
            self.learnMoreHeightConstraint.constant = 0;
            break;
        case DCUIFNoContentWithButtonView.DCFEmptyScreenType.download:
            self.learnMoreHeightConstraint.constant = 45;

            
            break;
        case DCUIFNoContentWithButtonView.DCFEmptyScreenType.bookmark:
            self.learnMoreHeightConstraint.constant = 45;
            
            break;
            
        default:
            if(self.btnLearnMoreText == ""){
                self.learnMoreHeightConstraint.constant = 0;
            }
            
            return;
        }
        
    }
    
}
