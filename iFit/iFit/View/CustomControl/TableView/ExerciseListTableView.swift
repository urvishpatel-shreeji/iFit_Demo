//
//  ExerciseListTableView.swift
//  iFit
//
//  Created by Malav Soni on 06/09/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class ExerciseListTableView: IFTableView {
    
    var aryExerciseList:[IFExercise] = []
    private var blockAddSetHandler:(()->Void)?
    private var blockEditExerciseHandler:((IFExercise)->Void)?
    private var blockDeleteExerciseHandler:((Int)->Void)?
    private var blockEditSetHandler:((IFExercise,IFSet,String)->Void)?
    
    
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
        
        let headerNib = UINib.init(nibName: "ExerciseHeaderView", bundle: Bundle.main)
        self.register(headerNib, forHeaderFooterViewReuseIdentifier: "ExerciseHeaderView")
        
        self.sectionHeaderHeight = UITableView.automaticDimension;
        self.estimatedSectionHeaderHeight = 25;
    }
    func setTableViewData(withNotificationList list:[IFExercise]){
        
        self.aryExerciseList = list
        self.delegate  = self
        self.dataSource = self
        self.reloadData()
    }
    func getAddSetClick(withHandler handler:(()->Void)?){
        if let value = handler {
            self.blockAddSetHandler = value
        }
    }
    func setEditExerciseClick(withHandler handler:((IFExercise)->Void)?){
        if let value = handler {
            self.blockEditExerciseHandler = value
        }
    }
    func setDeleteExerciseClick(withHandler handler:((Int)->Void)?){
        if let value = handler {
            self.blockDeleteExerciseHandler = value
        }
    }
    func setEditSetClick(withHandler handler:((IFExercise,IFSet,String)->Void)?){
        if let value = handler {
            self.blockEditSetHandler = value
        }
    }
}
extension ExerciseListTableView{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if aryExerciseList.count>0{
            tableView.backgroundView = nil
            return aryExerciseList.count
        }
        else{
            let emptyBackgroundView = IFEmptyBackgroundView.init(image: UIImage(), top: "Exercise", bottom: "No Exercise Found!")
            
            tableView.backgroundView = emptyBackgroundView
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryExerciseList[section].arySet.count
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ExerciseHeaderView") as! ExerciseHeaderView
        headerView.updateUI(withTitle: "\(self.aryExerciseList[section].strTitle) # \(section+1)")
        headerView.getEditExercise { [weak self] () in
            guard let self = `self` else {return }
            
            if let handler = self.blockEditExerciseHandler {
                handler(self.aryExerciseList[section])
            }
        }
        headerView.getDeleteExercise {
            [weak self] () in
            guard let self = `self` else {return }
            
            if let handler = self.blockDeleteExerciseHandler{
                handler(section)
            }
        }
        return headerView
    }
   
    override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:SetCell = tableView.dequeueReusableCell(withIdentifier: "SetCell") as? SetCell else {
            return UITableViewCell()
        }
        
        cell.objSet = self.aryExerciseList[indexPath.section].arySet[indexPath.row]
        cell.setEditSetActionHandler {[weak self] (set) in
            guard let self = `self` else {return}
            if let handler = self.blockEditSetHandler{
                handler(self.aryExerciseList[indexPath.section],self.aryExerciseList[indexPath.section].arySet[indexPath.row],self.aryExerciseList[indexPath.section].strTitle)
            }
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let handler = self.blockEditSetHandler{
//            handler(self.aryExerciseList[indexPath.section],self.aryExerciseList[indexPath.section].arySet[indexPath.row],self.aryExerciseList[indexPath.section].strTitle)
//        }
//    }
    
}
