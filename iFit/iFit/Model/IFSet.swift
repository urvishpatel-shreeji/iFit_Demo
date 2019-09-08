//
//  IFSet.swift
//  iFit
//
//  Created by Malav Soni on 06/09/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class IFSet: NSObject,NSCoding {
    var id:Int = -1 
    var strSetTitle:String = ""
    var setType:SetType = .none
    var index:Int = 1
    override init() {
        super.init()
        self.strSetTitle = ""
        self.setType = .none
        self.id = -1
        self.index = 1
        
    }
    convenience init(withIndex index:Int){
        self.init()
        self.id = index 
    }
    func encode(with coder: NSCoder) {
        coder.encode(self.strSetTitle, forKey: "strSetTitle")
        coder.encode(self.setType.rawValue, forKey: "setType")
        coder.encode(self.id, forKey: "id")
        coder.encode(self.index, forKey: "index")
        
    }
    required init(coder decoder: NSCoder) {
        
        self.strSetTitle =  decoder.decodeObject(forKey: "strSetTitle") as! String
        if let type =  decoder.decodeObject(forKey: "setType") as? String{
            if let obj:SetType = SetType.init(rawValue: type){
                self.setType = obj
            }else{
                self.setType = .none
            }
        }
        print("coder:: \(self.setType.hashValue)")
        
        self.id =  decoder.decodeInteger(forKey: "id")
        self.index =  decoder.decodeInteger(forKey: "index")
        
    }
    
}
