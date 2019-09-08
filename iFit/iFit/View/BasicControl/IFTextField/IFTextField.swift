//
//  Extension_UIView.swift
//  iFit
//
//  Created by Malav Soni on 06/09/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit
typealias TextFieldValueChangeHandler = ((UITextField)->Void)


class IFTextField: UITextField {

    var textfieldValueChangeHandler:TextFieldValueChangeHandler?
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var maxLength:Int = -1
    var nextTextFieldRef:IFTextField?
    
    var customRightViewImage:UIImage? {
        didSet{
            let rightSideView:UIView = UIView.init(frame: CGRect.init(x: 00, y: 0, width: 44, height: self.bounds.size.height))
            let btnImage = IFButton.init(frame: rightSideView.bounds)
            btnImage.setImage(customRightViewImage, for: UIControl.State.normal)
            btnImage.addTarget(self, action: #selector(self.didClickRightImageView), for: UIControl.Event.touchUpInside)
            rightSideView.addSubview(btnImage)
            self.rightView = rightSideView
            self.rightViewMode = .always
        }
    }
    
    enum Style {
        case underline
        case box
    }
    
    enum ContentType {
        case none
        case email
        case password
        case phone
    }
    @objc func textfieldValueChangeEvent(textfield:IFTextField){
        if let handler = self.textfieldValueChangeHandler{
            handler(self)
        }
    }
    var contentType:ContentType = .none{
        didSet{
            switch contentType {
            case .password:
                self.isSecureTextEntry = true
                self.customRightViewImage = UIImage.init(named: "ic_visibility")
                self.keyboardAppearance = .dark
                self.delegate = self
                self.maxLength = 12
                break
            case .email:
                break
            case .none:
                break
            case .phone:
                self.maxLength = 10
                self.keyboardType = .phonePad
            }
        }
    }
    
    var style:Style = .underline{
        didSet{
            switch style {
            case .box:
                self.bottomLineLayer.removeFromSuperlayer()
                self.layer.borderColor = UIColor.lightGray.cgColor
                self.layer.borderWidth = 1.0
                
                let paddingView = UIView(frame: CGRect.init(x: 0, y: 0, width: 15.0, height: self.frame.size.height))
                self.leftView = paddingView
                self.leftViewMode = .always
                
                self.rightView = paddingView
                self.rightViewMode = .always
                
                break
            case .underline:
                break
            }
        }
    }
    
    override var placeholder: String?{
        didSet{
            if let strValue = self.placeholder{
                let attributedString = NSAttributedString.init(string: strValue, attributes: [
                    NSAttributedString.Key.foregroundColor : UIColor.appThemeGreyTextColor(),
                    NSAttributedString.Key.font : self.font!
                    ])
                self.attributedPlaceholder = attributedString
            }
        }
    }
    
    private lazy var bottomLineLayer:CALayer = CALayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() -> Void {
        self.isSecureTextEntry = false
        self.font = UIFont.appRegularFont(WithSize: UIFont.systemFontSize, ShouldAdjustBasedOnDevice: false)
        bottomLineLayer.frame = CGRect.init(x: 0, y: self.frame.size.height-1, width: self.frame.size.width, height: 1.0)
        bottomLineLayer.backgroundColor = UIColor.appThemeGreyTextColor().cgColor
        self.layer.addSublayer(bottomLineLayer)
        self.borderStyle = .none
        self.delegate = self
         self.addTarget(self, action: #selector(textfieldValueChangeEvent(textfield:)), for: .editingChanged)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomLineLayer.frame = CGRect.init(x: 0, y: self.frame.size.height-1, width: self.frame.size.width, height: 1.0)
    }

    
    @objc func didClickRightImageView() -> Void {
        if self.contentType == .password{
            self.isSecureTextEntry = !self.isSecureTextEntry
        }
    }
}

extension IFTextField:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard self.maxLength > 0 else { return true }
        
        let text = textField.text ?? ""
        let nsString = text as NSString
        let newText = nsString.replacingCharacters(in: range, with: string)
        return newText.count <= self.maxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextResponder = self.nextTextFieldRef{
            return nextResponder.becomeFirstResponder()
        }
        return  textField.resignFirstResponder()
    }
}
