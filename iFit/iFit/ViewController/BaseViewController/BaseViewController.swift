//
//  BaseViewController.swift
//  iFit
//
//  Created by Malav Soni on 06/06/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

enum NavigationButton {
    case Back
    case Done
    case Close
    case Add
    var menuImage:UIImage!{
        get{
            switch self {
            case .Back:
                return UIImage.init(named: "ic_back");
                
            case .Close:
                return UIImage.init(named: "close_black")
            case .Done:
                return UIImage()
            case .Add:
                return UIImage.init(named: "add_chat_user")
                
                
            }
            
        }
    }
}
enum ContactViewController{
    case none
    case Edit
    case Create
}
class BaseViewController: UIViewController {
    var blockDidSelectImageHandler:((UIImage?,Bool)->Void)?
    
    var aryLeftMenuItem:[NavigationButton] = []{
        didSet{
            self.updateLeftMenu(withItemList: self.aryLeftMenuItem)
        }
    }
    var aryRightMenuItem:[NavigationButton] = []{
        didSet{
            self.updateRightMenu(withItemList: self.aryRightMenuItem)
        }
    }
    var openController:ContactViewController = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.appThemeGreyTextColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        // Do any additional setup after loading the view.
    }
    // MARK: - Navigation
    
    func updateLeftMenu(withItemList list:[NavigationButton]){
        var aryLeftMenuItem:[UIBarButtonItem] = []
        for item in list{
            let barButton:UIBarButtonItem = UIBarButtonItem.init()
            switch item {
            case .Back:
                barButton.image = item.menuImage
                barButton.target = self
                barButton.tintColor = UIColor.black
                barButton.action = #selector(navigation_BackButton_Action)
                break
            case .Close:
                barButton.image = item.menuImage
                barButton.tintColor = UIColor.black
                barButton.target = self
                barButton.action = #selector(navigation_CloseButton_Action)
                break
            case .Done:
                barButton.target = self
                barButton.title = "Done"
                barButton.tintColor = UIColor.black
                barButton.action = #selector(navigation_DoneButton_Action)
                break
            case .Add:
                barButton.image = item.menuImage
                barButton.target = self
                barButton.tintColor = UIColor.black
                barButton.action = #selector(navigation_AddButton_Action)
                break
            
                
            }
            aryLeftMenuItem.append(barButton)
        }
        self.navigationItem.leftBarButtonItems = aryLeftMenuItem
    }
    func updateRightMenu(withItemList list:[NavigationButton]){
        var aryRightMenuItem:[UIBarButtonItem] = []
        for item in list{
            let barButton:UIBarButtonItem = UIBarButtonItem.init()
            switch item {
            case .Back:
                barButton.image = item.menuImage
                barButton.target = self
                barButton.tintColor = UIColor.black
                barButton.action = #selector(navigation_BackButton_Action)
                break
            
            case .Close:
                barButton.image = item.menuImage
                barButton.target = self
                barButton.tintColor = UIColor.black
                barButton.action = #selector(navigation_CloseButton_Action)
                break
            case .Done:
                barButton.title = "Done"
                barButton.target = self
                barButton.tintColor = UIColor.black
                barButton.action = #selector(navigation_DoneButton_Action)
            case .Add:
                barButton.image = item.menuImage
                barButton.target = self
                barButton.tintColor = UIColor.black
                barButton.action = #selector(navigation_AddButton_Action)
                break
                
            
            }
            aryRightMenuItem.append(barButton)
        }
        self.navigationItem.rightBarButtonItems = aryRightMenuItem
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    //MARK: - Navigation Button Action
    @objc func navigation_BackButton_Action(){
        print("navigation_BackButton_Action")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func navigation_AddButton_Action(){
        print("navigation_AddButton_Action")
        
    }
    
    @objc func navigation_CloseButton_Action(){
        print("navigation_CloseButton_Action")
        
    }
    @objc func navigation_DoneButton_Action(){
        print("navigation_DoneButton_Action")
        
    }
    //MARK: - Contact Action
    func openSearchOnWeb(){
        guard let url = URL(string: "https://google.com") else { return }
        UIApplication.shared.open(url)
        
    }
    
}

