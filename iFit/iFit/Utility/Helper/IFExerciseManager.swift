//
//  IFExerciseManager.swift
//  iFit
//
//  Created by Malav Soni on 06/09/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class IFExerciseManager: NSObject,NSCoding {
    var aryExercise:[IFExercise] = []
    var newExercise:IFExercise?
    
    static var shared:IFExerciseManager = IFExerciseManager ()
    private override init() {
        super.init()
        
        if let encodeObject:Data = UserDefaults.standard.object(forKey: "IFExerciseManager") as! Data?
        {
            if let saveObj:IFExerciseManager = NSKeyedUnarchiver.unarchiveObject(with: encodeObject) as? IFExerciseManager
            {
                self.loadUserDetails(withUserClass: saveObj);
            }
            else
            {
                print("Did not load the user class")
            }
        }
        else
        {
            print("Did not load the user class")
        }
        
        
    }
    
    required init(coder decoder: NSCoder) {
        
        if let value = decoder.decodeObject(forKey: "aryExercise") as? [IFExercise]{
            self.aryExercise = value
            
        }
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.aryExercise, forKey: "aryExercise")
    }
    
    func saveUserDetails() -> Void {
        let currentUserRef:Data = NSKeyedArchiver.archivedData(withRootObject: self)
        UserDefaults.standard.set(currentUserRef, forKey: "IFExerciseManager")
        UserDefaults.standard.synchronize()
    }
    /***********************************************/
    /*                 Load Current User Details                      */
    /***********************************************/
    private func loadUserDetails(withUserClass user:IFExerciseManager) -> Void
    {
        self.aryExercise = user.aryExercise
       
    }
    
    /***********************************************/
    /*                 Clear Current User Details                      */
    /***********************************************/
    func clearUserDetails() -> Void {
        self.aryExercise = []
        
         self.saveUserDetails()
        
    }
    /***********************************************/
    /*  add Exercise in array                      */
    /***********************************************/
    
    func addExercise(withExcercise exercise:IFExercise){
        self.aryExercise.append(exercise)
        self.saveUserDetails()
    }
    /***********************************************/
    /*  update Exercise in array                      */
    /***********************************************/
    func updateExercise(withExcercise exercise:IFExercise){
        //self.aryExercise.append(exercise)
    }
}
