//
//  AddSetPopup.swift
//  iFit
//
//  Created by Malav Soni on 06/09/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit
import PopupDialog

enum SetViewControllerOperation:Equatable {
    case Add(index:Int )
    case Edit(set:IFSet)
}
extension SetViewControllerOperation {
    func isEqual(st: SetViewControllerOperation)->Bool {
        switch self {
        case .Add(let i1):
            switch st {
            case .Add(let i2):
                return i1 == i2
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
class AddSetPopup: BaseViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var lblPopupTitle:IFLabel!
    @IBOutlet weak var txtTitle:IFTextField!
    @IBOutlet weak var btnAddSet:IFButton!
    @IBOutlet weak var btnRegular:UIButton!
    @IBOutlet weak var btnWarmUp:UIButton!
    
    //MARK: - Local Variable
    private var setTypeSelection:SetType = .none{
        didSet{
            if setTypeSelection == SetType.Regular {
                self.btnRegular.setImage(UIImage.init(named: "radio_button_checked"), for: .normal)
                self.btnWarmUp.setImage(UIImage.init(named: "radio_button_unchecked"), for: .normal)
            }else if setTypeSelection == SetType.WarmUp {
                self.btnRegular.setImage(UIImage.init(named: "radio_button_unchecked"), for: .normal)
                self.btnWarmUp.setImage(UIImage.init(named: "radio_button_checked"), for: .normal)
            }else{
                self.btnRegular.setImage(UIImage.init(named: "radio_button_unchecked"), for: .normal)
                self.btnWarmUp.setImage(UIImage.init(named: "radio_button_unchecked"), for: .normal)
            }
        }
    }
    var viewControllerOpration:SetViewControllerOperation!{
        didSet{
            switch viewControllerOpration {
            case .Add(index: let index)?:
                self.objSet = IFSet.init(withIndex: index)
            case .Edit(set: let set)?:
                self.objSet = set
            case .none:
                self.objSet = IFSet.init(withIndex: 1)
            }
        }
    }
    private var objSet:IFSet!
    
    private var blockAddSetHandler:((IFSet,SetViewControllerOperation)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        // Do any additional setup after loading the view.
    }

    func setupUI(){
        self.txtTitle.placeholder = "Set Title"
        
        self.lblPopupTitle.text = "Add Set"
        self.btnAddSet.setTitle("Add Set", for: .normal)
        
        
        self.txtTitle.text = self.objSet.strSetTitle
        self.setTypeSelection = self.objSet.setType
        
    }
    
   
    
    //MARK: - Validation
    private func checkValidation()->Bool{
        var isSuccess:Bool = true
        var strTitle:String = self.txtTitle.text ?? ""
        strTitle = strTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if strTitle.count <= 0 {
            isSuccess = false
            IFAlertView.showAlert(withType: .alert, withMessage: "Please Enter Title!", withButtons: ["Ok"]) { (index) in
                
            }
        }else if self.setTypeSelection == .none{
            isSuccess = false
            IFAlertView.showAlert(withType: .alert, withMessage: "Please Select Set Type!", withButtons: ["Ok"]) { (index) in
                
            }
        }
        return isSuccess
    }
    
    //MARK: - Button Methods
    @IBAction func btnSetTypeSelection(withButton button:IFButton){
        if button == self.btnRegular{
            self.setTypeSelection = .Regular
        }else if button == self.btnWarmUp {
            self.setTypeSelection = .WarmUp
        }
    }
    @IBAction func btnCancel(withButton button:IFButton){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func addSet(withSender sender:IFButton){
        
        if checkValidation() {
            self.objSet.strSetTitle = self.txtTitle!.text ?? ""
            self.objSet.setType = self.setTypeSelection
            if let handler = self.blockAddSetHandler {
                handler(self.objSet,self.viewControllerOpration)
            }
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    
    //MARK: - Handler
    func setBlockAddSetHandler(handler:((IFSet,SetViewControllerOperation)->Void)?){
        if let value = handler {
            self.blockAddSetHandler = value
        }
    }
    
}
