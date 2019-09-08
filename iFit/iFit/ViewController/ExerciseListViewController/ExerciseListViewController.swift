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
    func tableViewHandler(){
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
            
            IFAlertView.showAlert(withType: .actionSheet, withMessage: "Are you sure you want to remove?", withButtons: ["Yes","Cancel"], withCompletion: { (index) in
                if index == 0 {
                    IFExerciseManager.shared.aryExercise.remove(at: index)
                    IFExerciseManager.shared.saveUserDetails()
                     self.tblExercise.setTableViewData(withNotificationList: IFExerciseManager.shared.aryExercise)
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
               self.tblExercise.setTableViewData(withNotificationList: IFExerciseManager.shared.aryExercise)
            
            })
            self.present(objPopup, animated: true, completion: nil)
        }
        
        
        
    }
    func setupUI(){
        self.title = "Exercise"
        self.aryLeftMenuItem = []
        self.aryRightMenuItem = [.Add];
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tblExercise.setTableViewData(withNotificationList: IFExerciseManager.shared.aryExercise)
        
    }
    override func navigation_AddButton_Action() {
        if let objAddExercise:AddExerciseViewController = AddExerciseViewController.InstantiateViewController()
        {
            objAddExercise.type = .Add
           self.navigationController?.pushViewController(objAddExercise, animated: true )
        }
    }
    class func InstantiateViewController()->ExerciseListViewController?{
        
        let storyboard:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let objVC:ExerciseListViewController = storyboard.instantiateViewController(withIdentifier: "ExerciseListViewController") as? ExerciseListViewController{
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
