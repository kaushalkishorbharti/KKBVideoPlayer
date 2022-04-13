//
//  DCUIPlaceholderView.swift
//  DCUIFramework
//
//  Created by kaushal kishor on 05/12/18.
//  Copyright © 2018 Abhinav Agarwal. All rights reserved.
//

import UIKit

public protocol DCUIPlaceholderViewDelegate: class {
    
    func okClicked()
    func cancelClicked()
    
}

open class DCUIPlaceholderView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var viewRoot: UIView!
    @IBOutlet weak var viewData: UIView!
    @IBOutlet weak var imgView: DCUIFImageView!
    @IBOutlet weak var lblTitle: DCUIFActiveThemeLabel!
    @IBOutlet weak var lblDescription: DCUIFActiveThemeLabel!
    @IBOutlet weak var btnOk: DCUIFThemeButton!
    @IBOutlet weak var stackViewMain: UIStackView!
    @IBOutlet weak var stackViewImg: UIStackView!
    @IBOutlet weak var stackViewText: UIStackView!
    @IBOutlet weak var stackViewBtn: UIStackView!
    @IBOutlet weak var spinnerLoader: UIActivityIndicatorView!
    @IBOutlet weak var btnCancel: DCUIFThemeButton!
    
    weak var delegate:DCUIPlaceholderViewDelegate?
    var item:DCUIPlaceHolderItem? = nil

    var placeholderImage: UIImage? {
        didSet {
            self.stackViewImg.isHidden = self.placeholderImage == nil
        }
    }
    
    @IBAction func btnOkClicked(_ sender: DCUIFThemeButton) {
        self.delegate?.okClicked()
    }
    
    
    @IBAction func btnCancelClicked(_ sender: DCUIFThemeButton) {
       self.delegate?.cancelClicked()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        item = DCUIPlaceHolderItem()
        
    }
    
    func commonInit() {
        let viewName = "DCUIPlaceholderView";
        DCUIFramework.bundle.loadNibNamed(viewName,owner: self, options: nil)
        addSubview(contentView);
        contentView.frame = self.bounds;
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth];
        viewRoot.backgroundColor = DCUIFColor.TblBgColor.getColor();
        contentView.backgroundColor = DCUIFColor.TblBgColor.getColor();
        self.btnOk.style = DCUIFButtonStyle.Opaque
        self.btnCancel.style = DCUIFButtonStyle.Opaque
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configureData(data: DCUIPlaceHolderItem) {
        self.item = data
        if (item?.isShowLoader == true) {
            spinnerLoader.startAnimating()
            spinnerLoader.isHidden = false
        }else {
            spinnerLoader.stopAnimating()
            spinnerLoader.isHidden = true
        }
        
        if (item?.image != nil) {
            imgView.image = item?.image!
            imgView.isHidden = false
        }else {
            imgView.isHidden = true
        }
        
        if ( item?.title != nil && item?.title != "") {
            lblTitle.text = item?.title
            lblTitle.isHidden = false
        }else {
            lblTitle.isHidden = true
        }
        
        if ( item?.msg != nil && item?.msg != "") {
            lblDescription.text = item?.msg
            lblDescription.isHidden = false
        }else{
            lblDescription.isHidden = true
        }
        
        if ( item?.okButtonTitle != nil && item?.okButtonTitle != "") {
            btnOk.setTitle(item?.okButtonTitle, for: .normal)
            btnOk.isHidden = false
        }else {
            btnOk.isHidden = true
        }

        if ( item?.cancelbuttonTitle != nil && item?.cancelbuttonTitle != "") {
            btnCancel.setTitle(item?.cancelbuttonTitle, for: .normal)
            btnCancel.isHidden = false
        }else {
            btnCancel.isHidden = true
        }

        if (item?.okButtonImg != nil) {
            btnOk.setImage(item?.okButtonImg!, for: UIControlState())
            btnOk.isHidden = false
        }
        
        if (item?.cancelButtonImg != nil) {
            btnCancel.setImage(item?.cancelButtonImg!, for: UIControlState())
            btnCancel.isHidden = false
        }
    }
}
