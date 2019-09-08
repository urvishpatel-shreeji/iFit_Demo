//
//  Extension_UIView.swift
//  iFit
//
//  Created by Malav Soni on 06/09/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class IFButton: UIButton {

    /// Styles of different buttons.
    ///
    /// - none: default black with standard regular font size
    /// - blue: Blue background with white BOLD font color.
    /// - white: White Background + Black BOLD font color + Drop Shadow
    /// - italic: Italic font with grey text color
    /// - grey: Regular font with grey color
    enum Style {
        // refer to login screen based on specification PDF.
        case none
        case blue
        case white
        case italic
        case grey
    }
    
    var buttonStyle:Style = Style.none{
        didSet{
            self.updateUIBasedOnStyle()
        }
    }
    
    var shapeLayer:UIView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
    }
    
    func commonInit() -> Void {
        self.isExclusiveTouch = true
        
        shapeLayer.backgroundColor = UIColor.red
        shapeLayer.frame = CGRect.init(x: self.bounds.size.width - (self.bounds.size.width * 0.2) , y: 0, width: (self.bounds.size.width * 0.2), height: (self.bounds.size.width * 0.2))
//        self.addSubview(shapeLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        shapeLayer.frame = CGRect.init(x: self.bounds.size.width - (self.bounds.size.width * 0.2) , y: 0, width: (self.bounds.size.width * 0.2), height: (self.bounds.size.width * 0.2))
//        print(shapeLayer.frame)
    }
    
    private func updateUIBasedOnStyle() -> Void{
        switch self.buttonStyle {
        case .none:
            self.titleLabel?.font = UIFont.appRegularFont(WithSize: UIFont.buttonFontSize * 0.8, ShouldAdjustBasedOnDevice: false)
            self.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.backgroundColor = UIColor.white
        case .blue:
            self.titleLabel?.font = UIFont.appBoldFont(WithSize: UIFont.buttonFontSize, ShouldAdjustBasedOnDevice: false)
            self.setTitleColor(UIColor.white, for: UIControl.State.normal)
            self.backgroundColor = UIColor.appThemeBlueColor()
            self.layer.cornerRadius = 2.5
        case .white:
            self.titleLabel?.font = UIFont.appBoldFont(WithSize: UIFont.buttonFontSize, ShouldAdjustBasedOnDevice: false)
            self.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.backgroundColor = UIColor.white
            self.dropShadow()
        case .italic:
            self.titleLabel?.font = UIFont.appItalicFont(WithSize: UIFont.systemFontSize, ShouldAdjustBasedOnDevice: false)
            self.setTitleColor(UIColor.appThemeGreyTextColor(), for: UIControl.State.normal)
        case .grey:
            self.titleLabel?.font = UIFont.appRegularFont(WithSize: UIFont.smallSystemFontSize, ShouldAdjustBasedOnDevice: false)
             self.setTitleColor(UIColor.appThemeGreyTextColor(), for: UIControl.State.normal)
        }
    }
}
