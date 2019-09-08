//
//  SetListTableView.swift
//  iFit
//
//  Created by Malav Soni on 06/09/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class SetListTableView: IFTableView {
    
    var arySetList:[IFSet] = []
    private var blockAddSetHandler:((String)->Void)?
    private var blockEditSetHandler:((IFSet,String)->Void)?
    private var blockDeleteSetHandler:((IFSet)->Void)?
    
    var exerciseTitle:String = ""
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.commonInit()
    }
    override func awakeFromNib() {
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override func commonInit() {
        
        self.estimatedRowHeight = 60.0
        self.rowHeight = UITableView.automaticDimension;
        
        self.register(UINib.init(nibName: "SetCell", bundle: nil), forCellReuseIdentifier: "SetCell")
        self.backgroundColor = UIColor.white
        self.separatorStyle = .none
        self.contentInset = UIEdgeInsets.init(top: 5, left: 0, bottom: 5, right: 0)
        
        let headerNib = UINib.init(nibName: "SetListTableHeaderView", bundle: Bundle.main)
        self.register(headerNib, forHeaderFooterViewReuseIdentifier: "SetListTableHeaderView")
        
        let footerNib = UINib.init(nibName: "SetListFooterView", bundle: Bundle.main)
        self.register(footerNib, forHeaderFooterViewReuseIdentifier: "SetListFooterView")
        
        self.sectionHeaderHeight = UITableView.automaticDimension;
        self.estimatedSectionHeaderHeight = 25;
    }
    func setTableViewData(withSetList list:[IFSet],withTitle title:String){
        self.exerciseTitle = title
        self.arySetList = list
        self.delegate  = self
        self.dataSource = self
        self.reloadData()
    }
    func getAddSetClick(withHandler handler:((String)->Void)?){
        if let value = handler {
            self.blockAddSetHandler = value
        }
    }
    func setEditSetClick(withHandler handler:((IFSet,String)->Void)?){
        if let value = handler {
            self.blockEditSetHandler = value
        }
    }
    func setDeleteSetClick(withHandler handler:((IFSet)->Void)?){
        if let value = handler {
            self.blockDeleteSetHandler = value
        }
    }
    
}

extension SetListTableView{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arySetList.count>0{
            tableView.backgroundView = nil
            return arySetList.count
        }
        else{
//            let emptyBackgroundView = IFEmptyBackgroundView.init(image: UIImage(), top: "Set", bottom: "No Notification Found!")
//
//            tableView.backgroundView = emptyBackgroundView
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SetListTableHeaderView") as! SetListTableHeaderView
        headerView.updateUI(withTitle: self.exerciseTitle)
        headerView.txtTitle.textfieldValueChangeHandler = {
            [weak self] (textfield) in
            guard  let self = `self` else {
                return
            }
            self.exerciseTitle = textfield.text!
        }
        
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SetListFooterView") as! SetListFooterView
        footerView.updateUI()
        footerView.blockAddSetHandler = { [weak self] in
            guard let self = `self` else {return }
            print("addSEt");
            if let handler = self.blockAddSetHandler{
                handler(self.exerciseTitle)
            }
        }
        
        return footerView
    }
    override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:SetCell = tableView.dequeueReusableCell(withIdentifier: "SetCell") as? SetCell else {
            return UITableViewCell()
        }
        
        cell.objSet = self.arySetList[indexPath.row]
        cell.setEditSetActionHandler {[weak self] (set) in
            guard let self = `self` else {return}
            if let handler = self.blockEditSetHandler{
                handler(self.arySetList[indexPath.row],self.exerciseTitle)
            }
        }
        cell.setDeleteSetActionHandler { [weak self](set) in
            guard let self = `self` else {return}
            if let handler = self.blockDeleteSetHandler{
                handler(self.arySetList[indexPath.row])
            }
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let handler = self.blockEditSetHandler{
//            handler(self.arySetList[indexPath.row],self.exerciseTitle)
//        }
//    }
    
}
