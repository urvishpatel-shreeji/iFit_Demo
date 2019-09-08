//
//  Extension_UIColor.swift
//  iFit
//
//  Created by Malav Soni on 06/09/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

extension UIColor{
    /// Returns Theme Blue Color
    /// Reference to login screen
    /// - Returns: New Instance of UIColor
    static func appThemeBlueColor() -> UIColor {
        return UIColor.init(red: 1/255.0, green: 87/255.0, blue: 155/255.0, alpha: 1.0)
    }
    
    /// Returns Theme Grey Color
    ///
    /// - Returns: New Instance of UIColor
    static func appThemeGreyTextColor() -> UIColor{
        return UIColor.init(red: 155/255.0, green: 155/255.0, blue: 155/255.0, alpha: 1.0)
    }
    
    static func appSeperatorColor() -> UIColor{
        return UIColor.init(red: 199/255.0, green: 199/255.0, blue: 204/255.0, alpha: 1.0)
    }
    
    /// Returns Theme Red Color
    /// Reference to Deals screen
    /// - Returns: New Instance of UIColor
    static func appThemeRedColor() -> UIColor {
        return UIColor.init(red: 228/255.0, green: 53/255.0, blue: 35/255.0, alpha: 1.0)
    }
    
    static func appOrangeColor() -> UIColor {
        return UIColor.init(red: 255.0/255.0, green: 165/255.0, blue: 0/255.0, alpha: 1.0)
    }
    
}
