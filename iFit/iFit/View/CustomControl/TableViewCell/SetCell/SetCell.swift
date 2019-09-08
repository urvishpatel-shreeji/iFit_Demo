//
//  SetCell.swift
//  iFit
//
//  Created by Malav Soni on 06/09/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class SetCell: UITableViewCell {
    @IBOutlet weak var btnIndicator:UIButton!
    @IBOutlet weak var lblSetName:IFLabel!
    var objSet:IFSet!{
        didSet{
            self.updateUI()
        }
    }
    private var blockEditSetActionHandler:((IFSet)->Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.commonUI()
    }
    
    func commonUI(){
        self.selectionStyle = .none
        self.lblSetName.font = UIFont.appRegularFont(WithSize: 15.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateUI(){
        self.lblSetName.text = "\(self.objSet.strSetTitle) #\(self.objSet.index)"
        if self.objSet.setType == .Regular {
            self.btnIndicator.tintColor = UIColor.blue
        }else{
            self.btnIndicator.tintColor = UIColor.appOrangeColor()
        }
    }
    func setEditSetActionHandler(with handler:((IFSet)->Void)?) {
        if handler != nil {
            self.blockEditSetActionHandler = handler
        }
    }
    
    @IBAction func btnEditSet_Clicked(sender:UIButton){
        if let handler = self.blockEditSetActionHandler {
            handler(self.objSet)
        }
    }
}
