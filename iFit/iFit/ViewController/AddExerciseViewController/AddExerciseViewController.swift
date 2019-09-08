//
//  AddExerciseViewController.swift
//  iFit
//
//  Created by Malav Soni on 06/09/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit
import PopupDialog

enum ViewControllerType:Equatable {
    case Add
    case Edit(exercise:IFExercise)
}
extension ViewControllerType{
    func isEqual(st: ViewControllerType)->Bool {
        switch self {
        case .Add:
            switch st {
            case .Add:
                return true
            default:
                return false
            }
        case .Edit(let i1):
            switch st {
            case .Edit(let i2): return i1 == i2
            default: return false
            }
        }
    }
    
}

class AddExerciseViewController: BaseViewController {

    @IBOutlet weak var tblSetList:SetListTableView!
    var type:ViewControllerType = .Add{
        didSet{
            switch type {
            case .Add:
                self.objExercise = IFExercise.init(withId: IFExerciseManager.shared.aryExercise.count+1)
            case .Edit(exercise: let exercise):
                self.objExercise = exercise
            }
        }
    }
    var objExercise:IFExercise!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Navigation MEthods
    override func navigation_DoneButton_Action() {
        if self.type == .Add{
            if self.objExercise  != nil {
                if self.checkValidation() {
                    IFExerciseManager.shared.addExercise(withExcercise: self.objExercise)
                    
                    self.navigationController?.popViewController(animated: true )
                }
              
            }
            
        }
        else{
             self.navigationController?.popViewController(animated: true )
        }
    }
    
    //MARK: - Validation
    private func checkValidation()->Bool{
        var isSuccess:Bool = true
        var strTitle:String = self.objExercise.strTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if strTitle.count <= 0 {
            isSuccess = false
            IFAlertView.showAlert(withType: .alert, withMessage: "Please Enter Exercise Title!", withButtons: ["Ok"]) { (index) in
                
            }
        }
        else if self.objExercise.arySet.count <= 0 {
            isSuccess = false
            IFAlertView.showAlert(withType: .alert, withMessage: "Please Add Sets!", withButtons: ["Ok"]) { (index) in
                
            }
        }
        return isSuccess
    }
    //MARK : - UI Update
    private func setupUI(){
        self.title = "Add Exercise"
        self.aryLeftMenuItem = [.Back];
        self.aryRightMenuItem = [.Done];
        
        self.tableViewHandler()
        self.tblSetList.setTableViewData(withNotificationList: self.objExercise.arySet,withTitle: self.objExercise.strTitle)
        
        
    }
    private func tableViewHandler(){
        self.tblSetList.setEditSetClick {[weak self ] (set,title) in
             guard let self = `self` else {return}
            
            self.objExercise.strTitle = title
            let addSetPopup = AddSetPopup.init(nibName: "AddSetPopup", bundle: nil)
            addSetPopup.viewControllerOpration = .Edit(set: set)
            
            let objPopup = PopupDialog.init(viewController: addSetPopup, buttonAlignment: .vertical, transitionStyle: .bounceUp, tapGestureDismissal: false  , completion: nil)
            let containerAppearance = PopupDialogContainerView.appearance()
            containerAppearance.cornerRadius = 20.0
            addSetPopup.setBlockAddSetHandler(handler: {[weak self] (objSet,vcType) in
                guard let self = `self` else {return}
                if vcType == SetViewControllerOperation.Add(index: self.objExercise.arySet.count){
                    self.objExercise.addSetInExercise(withSet: objSet)
                }else {
                     self.objExercise.updateSetInExercise(withSet: objSet)
                }
                self.tblSetList.setTableViewData(withNotificationList: self.objExercise.arySet,withTitle: self.objExercise.strTitle)
            })
            self.present(objPopup, animated: true, completion: nil)
            
            
        }
        self.tblSetList.getAddSetClick {
            [weak self] (title)in
            guard let self = `self` else {return}
            self.objExercise.strTitle = title
            
            let addSetPopup = AddSetPopup.init(nibName: "AddSetPopup", bundle: nil)
            addSetPopup.viewControllerOpration = .Add(index: self.objExercise.arySet.count)
            
            let objPopup = PopupDialog.init(viewController: addSetPopup, buttonAlignment: .vertical, transitionStyle: .bounceUp, tapGestureDismissal: false  , completion: nil)
            let containerAppearance = PopupDialogContainerView.appearance()
            containerAppearance.cornerRadius = 20.0
            addSetPopup.setBlockAddSetHandler(handler: {[weak self] (objSet,vcType) in
                guard let self = `self` else {return}
                if vcType == SetViewControllerOperation.Add(index: self.objExercise.arySet.count){
                    self.objExercise.addSetInExercise(withSet: objSet)
                }else {
                    
                }
                self.tblSetList.setTableViewData(withNotificationList: self.objExercise.arySet,withTitle: self.objExercise.strTitle)
            })
            self.present(objPopup, animated: true, completion: nil)
        }
    }
    
    // MARK: - Initialise
    class func InstantiateViewController()->AddExerciseViewController?{
        
        let storyboard:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let objVC:AddExerciseViewController = storyboard.instantiateViewController(withIdentifier: "AddExerciseViewController") as? AddExerciseViewController{
            return objVC
        }
        return nil
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
