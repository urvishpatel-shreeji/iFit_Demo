//
//  Extension_UIView.swift
//  iFit
//
//  Created by Malav Soni on 06/09/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class IFNavigationBar: UINavigationBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() -> Void {
        self.isTranslucent = false
//        self.dropShadow()
        self.setBackgroundImage( UIImage.init() , for: UIBarMetrics.default)
        self.shadowImage = UIImage.init()
        self.barTintColor = UIColor.appThemeGreyTextColor()
        self.titleTextAttributes = [
            .font : UIFont.appBoldFont(WithSize: 20.0),
            .foregroundColor : UIColor.black
        ]
    }
}
