
//
//  SetListTableHeaderView.swift
//  iFit
//
//  Created by Malav Soni on 06/09/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class SetListFooterView: UITableViewHeaderFooterView {

    @IBOutlet weak var btnAddSet:IFButton!
    @IBOutlet weak var mainView:UIView!
    var blockAddSetHandler:(()->Void)?
    
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
    func updateUI(){
        self.mainView.backgroundColor = UIColor.white
       
    }
    func set(withName name:String,withPhoneNumber phoneNumber:String,withProfilePic profilePicURL:String){
        
    }
    @IBAction func btnAddSetClicked(withButton button:UIButton){
        if let handler = self.blockAddSetHandler {
            handler()
        }
    }
    func getAddSet(withHandler handler:(()->Void)?){
        if let value = handler {
            self.blockAddSetHandler = value
        }
    }
}
