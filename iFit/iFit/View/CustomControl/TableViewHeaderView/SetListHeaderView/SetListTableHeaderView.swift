
//
//  SetListTableHeaderView.swift
//  iFit
//
//  Created by Malav Soni on 06/09/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class SetListTableHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var txtTitle:IFTextField!
    @IBOutlet weak var mainView:UIView!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func draw(_ rect: CGRect) {
        super.draw(rect)
       
    }
    func updateUI(withTitle title:String){
        self.txtTitle.text = title 
        self.mainView.backgroundColor = UIColor.white
        self.txtTitle.placeholder = "Exercise Title"
       
    }
    func set(withName name:String,withPhoneNumber phoneNumber:String,withProfilePic profilePicURL:String){
        
    }
}
