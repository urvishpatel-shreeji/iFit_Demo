//
//  Extension_UIView.swift
//  iFit
//
//  Created by Malav Soni on 06/09/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit 


extension UIFont{
    class func logAllFonts() -> Void {
        for family in UIFont.familyNames {
            let sName: String = family as String
            print("family: \(sName)") 
            for name in UIFont.fontNames(forFamilyName: sName) {
                print("name: \(name as String)")
            }
        }
    }
        
   /// Get The Regular Fonts Used In Whole App.
   ///
   /// - Parameters:
   ///   - size: Size of the fonts in pixel
   ///   - shouldAdjustBasedOnDevice: adjust font size based on different devices
   /// - Returns: returns new font instance
   static func appRegularFont(WithSize size:CGFloat, ShouldAdjustBasedOnDevice shouldAdjustBasedOnDevice:Bool = true) -> UIFont{
        let sizeOfFont = shouldAdjustBasedOnDevice ? size.proportionateFontSize() : size
        return UIFont.init(name: "Roboto-Regular", size: sizeOfFont) ?? UIFont.systemFont(ofSize: sizeOfFont)
    }
    
   /// Get The Bold Fonts Used In Whole App.
   ///
   /// - Parameters:
   ///   - size: Size of the fonts in pixel
   ///   - shouldAdjustBasedOnDevice: adjust font size based on different devices
   /// - Returns: returns new font instance
   static  func appBoldFont(WithSize size:CGFloat, ShouldAdjustBasedOnDevice shouldAdjustBasedOnDevice:Bool = true) -> UIFont{
        let sizeOfFont = shouldAdjustBasedOnDevice ? size.proportionateFontSize() : size
        return UIFont.init(name: "Roboto-Bold", size: sizeOfFont) ?? UIFont.boldSystemFont(ofSize: sizeOfFont)
    }
    
    /// Get The Italic Fonts Used In Whole App.
    ///
    /// - Parameters:
    ///   - size: Size of the fonts in pixel
    ///   - shouldAdjustBasedOnDevice: adjust font size based on different devices
    /// - Returns: returns new font instance
   static func appItalicFont(WithSize size:CGFloat, ShouldAdjustBasedOnDevice shouldAdjustBasedOnDevice:Bool = true) -> UIFont{
    let sizeOfFont = shouldAdjustBasedOnDevice ? size.proportionateFontSize() : size
    return UIFont.init(name: "Roboto-Italic", size: sizeOfFont) ?? UIFont.italicSystemFont(ofSize: sizeOfFont)
    }
}

extension CGFloat{
    func proportionateFontSize() -> CGFloat {
        var returnValue = self
        switch UIDevice.current.type {
            
        case .iPad:
            break
        case .iPhone_unknown:
            break
        case .iPhone_5_5S_5C:
            returnValue = self - 1.0
            break
        case .iPhone_6_6S_7_8:
            break
        case .iPhone_6_6S_7_8_PLUS:
            returnValue = self + 1.5
            break
        case .iPhone_X_Xs:
            returnValue = self + 1.5
            break
        case .iPhone_Xs_Max:
            returnValue = self + 3
            break
        case .iPhone_Xr:
            returnValue = self + 2
            break 
        }
        return returnValue
    }
}


extension UIDevice {
    
    enum `Type` {
        case iPad
        case iPhone_unknown
        case iPhone_5_5S_5C
        case iPhone_6_6S_7_8
        case iPhone_6_6S_7_8_PLUS
        case iPhone_X_Xs
        case iPhone_Xs_Max
        case iPhone_Xr
    }
    
    var type: Type {
        if userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                return .iPhone_5_5S_5C
            case 1334:
                return .iPhone_6_6S_7_8
            case 1920, 2208:
                return .iPhone_6_6S_7_8_PLUS
            case 2436:
                return .iPhone_X_Xs
            case 2688:
                return .iPhone_Xs_Max
            case 1792:
                return .iPhone_Xr
            default:
                return .iPhone_unknown
            }
        }
        return .iPad
    }
}
