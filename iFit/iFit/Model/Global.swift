//
//  Global.swift
//  iFit
//
//  Created by Malav Soni on 06/09/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

struct Constant {
    static let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    struct  App {
        static let Name:String = "iFit"
    }
    
}

enum SetType:String  {
    case none = "0"
    case Regular = "1"
    case WarmUp = "2"
    
}



