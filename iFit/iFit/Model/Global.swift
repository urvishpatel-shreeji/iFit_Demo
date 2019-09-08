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
    struct ErrorMessage {
       static let RemoveSetWarningMessage:String = "Are you sure you want to remove set?"
       static let RemoveExerciseWarningMessage:String = "Are you sure you want to remove Exercise?"
       static let AddExerciseTitleValidationMessage:String = "Please enter exercise Title!"
       static let AddSetTitleValidationMessage:String = "Please enter set title!"
       static let AddSetTypeValidationMessage:String = "Please select atleast one set type!"
        static let AddExerciseInSetCountValidationMessage:String = "Please add one set in exercise!"
        
    }
}

enum SetType:String  {
    case none = "0"
    case Regular = "1"
    case WarmUp = "2"
    
}



