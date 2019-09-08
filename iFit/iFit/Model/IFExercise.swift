//
//  IFExercise.swift
//  iFit
//
//  Created by Malav Soni on 06/09/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class IFExercise: NSObject,NSCoding {
    var id:Int = -1 
    var strTitle:String = ""
    var arySet:[IFSet] = []
    
    override init() {
        super.init()
        self.id = -1
        self.strTitle = ""
        self.arySet = []
    }
    convenience init(withId index :Int) {
        self.init()
        self.id = index
    }
    func encode(with coder: NSCoder) {
        coder.encode(self.strTitle, forKey: "strTitle")
        coder.encode(self.id, forKey: "id")
        coder.encode(self.arySet, forKey: "arySet")
    }
    required init(coder decoder: NSCoder) {
        self.id = decoder.decodeInteger(forKey: "id")
        self.strTitle =  decoder.decodeObject(forKey: "strTitle") as! String
        if let set =  decoder.decodeObject(forKey: "arySet") as? [IFSet]{
            self.arySet = set
        }
    }
    func updateSetInExercise(withSet getSet:IFSet){
        var aryAllSet:[IFSet] = []
        let aryWarmupSet:[IFSet] = self.arySet.filter { (set) -> Bool in
            if set.setType == .WarmUp{
                return true
            }else {
                return false
            }
        }
        
        let aryRegularSet:[IFSet] = self.arySet.filter { (set) -> Bool in
            if set.setType == .Regular{
                return true
            }else {
                return false
            }
        }
        
        
        aryAllSet = aryWarmupSet
        for set in aryRegularSet{
            aryAllSet.append(set)
        }
        self.arySet = aryAllSet
        for i in 0..<self.arySet.count {
            let set:IFSet = self.arySet[i]
            set.index = i+1
            self.arySet[i] = set
        }
    }
    func addSetInExercise(withSet set:IFSet){
        if set.setType == .Regular{
            self.arySet.append(set)
        }else{
            var isFoundRegular:Bool =  false
            var indexOfFirstRegularType:Int = 0
            for i in 0..<self.arySet.count {
                let set:IFSet = self.arySet[i]
                if set.setType == .Regular {
                    isFoundRegular = true
                    indexOfFirstRegularType = i
                    break
                }
            }
            if isFoundRegular {
                self.arySet.insert(set , at: indexOfFirstRegularType)
            }else{
                self.arySet.append(set)
            }
        }
        
        for i in 0..<self.arySet.count {
            let set:IFSet = self.arySet[i]
            set.index = i+1
            self.arySet[i] = set
        }
        
        
    }
    
}
