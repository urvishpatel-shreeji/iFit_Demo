
//
//  SetListTableHeaderView.swift
//  iFit
//
//  Created by Malav Soni on 15/06/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class ExerciseHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var lblExerciseTitle:IFLabel!
    @IBOutlet weak var btnEdit:UIButton!
    var blockEditExerciseHandler:(()->Void)?
    var blockDeleteExerciseHandler:(()->Void)?
    
    
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
       self.lblExerciseTitle.text = title
        self.lblExerciseTitle.font = UIFont.appBoldFont(WithSize: 15.0)
    }
    @IBAction func btnEditExerciseClicked(withButton button:UIButton){
        if let handler = self.blockEditExerciseHandler {
            handler()
        }
    }
    @IBAction func btnDelteExerciseClicked(withButton button:UIButton){
        if let handler = self.blockDeleteExerciseHandler {
            handler()
        }
    }
    func getEditExercise(withHandler handler:(()->Void)?){
        if let value = handler {
            self.blockEditExerciseHandler = value
        }
    }
    func getDeleteExercise(withHandler handler:(()->Void)?){
        if let value = handler {
            self.blockDeleteExerciseHandler = value
        }
    }
}
