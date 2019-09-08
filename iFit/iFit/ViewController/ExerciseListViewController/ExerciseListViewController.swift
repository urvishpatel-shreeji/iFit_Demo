//
//  ExerciseListViewController.swift
//  iFit
//
//  Created by Malav Soni on 06/09/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit
import PopupDialog

class ExerciseListViewController: BaseViewController {

    @IBOutlet weak var tblExercise:ExerciseListTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.tableViewHandler()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tblExercise.setTableViewData(withExerciseList: IFExerciseManager.shared.aryExercise)
        
    }
    //MARK: - UI
    private func setupUI(){
        self.title = "Exercise"
        self.aryLeftMenuItem = []
        self.aryRightMenuItem = [.Add];
        
    }
    //MARK: - Handler Methods
    private func tableViewHandler(){
        self.tblExercise.setEditExerciseClick { [weak self] (exercise) in
            guard let self = `self` else {return}
            
            
            if let objAddExercise:AddExerciseViewController = AddExerciseViewController.InstantiateViewController()
            {
                objAddExercise.type = .Edit(exercise: exercise)
                self.navigationController?.pushViewController(objAddExercise, animated: true )
            }
        }
        self.tblExercise.setDeleteExerciseClick(withHandler: { [weak self] (index) in
            guard let self = `self` else {return}
            
            IFAlertView.showAlert(withType: .actionSheet, withMessage: Constant.ErrorMessage.RemoveExerciseWarningMessage, withButtons: ["Yes","Cancel"], withCompletion: { (index) in
                if index == 0 {
                    IFExerciseManager.shared.aryExercise.remove(at: index)
                    IFExerciseManager.shared.saveUserDetails()
                    self.tblExercise.setTableViewData(withExerciseList: IFExerciseManager.shared.aryExercise)
                }
            })
        })
        
        self.tblExercise.setEditSetClick { [weak self] (exercise,set, title) in
            guard let self = `self` else {return }
            
            let addSetPopup = AddSetPopup.init(nibName: "AddSetPopup", bundle: nil)
            addSetPopup.viewControllerOpration = .Edit(set: set)
            
            let objPopup = PopupDialog.init(viewController: addSetPopup, buttonAlignment: .vertical, transitionStyle: .bounceUp, tapGestureDismissal: false  , completion: nil)
            let containerAppearance = PopupDialogContainerView.appearance()
            containerAppearance.cornerRadius = 20.0
            addSetPopup.setBlockAddSetHandler(handler: {[weak self] (objSet,vcType) in
                guard let self = `self` else {return}
                
                exercise.updateSetInExercise(withSet: objSet)
                self.tblExercise.setTableViewData(withExerciseList: IFExerciseManager.shared.aryExercise)
                
            })
            self.present(objPopup, animated: true, completion: nil)
        }
        
        self.tblExercise.setDeleteSetClick { [weak self] (exercise, set) in
            guard let self = `self` else {return }
            IFAlertView.showAlert(withType: .actionSheet, withMessage: Constant.ErrorMessage.RemoveSetWarningMessage, withButtons: ["Yes","Cancel"], withCompletion: { (index) in
                if index == 0 {
                    exercise.deleteSetInExercise(withSet: set)
                    self.tblExercise.setTableViewData(withExerciseList: IFExerciseManager.shared.aryExercise)
                    IFExerciseManager.shared.saveUserDetails()
                }
            })
            
        }
        
        
    }
    //MARK: - Navigation Button Event
    override func navigation_AddButton_Action() {
        if let objAddExercise:AddExerciseViewController = AddExerciseViewController.InstantiateViewController()
        {
            objAddExercise.type = .Add
           self.navigationController?.pushViewController(objAddExercise, animated: true )
        }
    }
    // MARK: - Initialize
    class func InstantiateViewController()->ExerciseListViewController?{
        
        let storyboard:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let objVC:ExerciseListViewController = storyboard.instantiateViewController(withIdentifier: "ExerciseListViewController") as? ExerciseListViewController{
            return objVC
        }
        return nil
    }
   

}
