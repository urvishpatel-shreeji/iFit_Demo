//
//  IFAlertView.swift
//  iFit
//
//  Created by Malav Soni on 07/09/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class IFAlertView: NSObject {
    
    static func showAlert(withType type:UIAlertController.Style,withMessage message:String,withButtons buttons:[String],withCompletion completion:((Int)->Void)?){
        
        let alertView:UIAlertController = UIAlertController.init(title: Constant.App.Name, message: message, preferredStyle: type)
        
        for i in 0..<buttons.count{
            let title:String = buttons[i]
            var actionType:UIAlertAction.Style = .default
            if title.lowercased() == "cancel"{
                actionType = .cancel
            }
            else{
                actionType = .default
            }
            let action:UIAlertAction = UIAlertAction.init(title: title, style: actionType) { (action) in
                if let handler = completion{
                    handler(i)
                }
            }
            alertView.addAction(action)
        }
        
        UIViewController.topViewController()?.present(alertView, animated: true, completion: nil)
    }
}
extension UIViewController{
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
}
