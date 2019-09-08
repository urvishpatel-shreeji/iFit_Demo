
//
//  Extension_UIView.swift
//  iFit
//
//  Created by Malav Soni on 06/09/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

/// Base Table View Class
class IFTableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    typealias TableViewDidSelectHandler = ((IndexPath,Any?)->())
    
    var didSelectRowNotification:TableViewDidSelectHandler?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func commonInit() -> Void {
        self.register(UITableViewCell.self)
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        self.separatorColor = nil
    }
    
    func showBackgroundView(WithMessage message:String) -> Void {
        let backgroundView = UIView.init(frame: self.bounds) 
        let lblMessage:IFLabel = IFLabel(frame: backgroundView.bounds)
        lblMessage.textAlignment = .center
        lblMessage.text = message
        lblMessage.font = UIFont.appRegularFont(WithSize: UIFont.systemFontSize * 1.1)
        lblMessage.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        backgroundView.addSubview(lblMessage)
        self.backgroundView = backgroundView
    }
    
    func hideBackgroundView() -> Void {
        self.backgroundView = nil
    }

}

extension IFTableView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReference = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        return cellReference!
    }
    
    
}

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        self.register(T.self, forCellReuseIdentifier: reuseIdentifier ?? String(describing: T.self))
    }
    
    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                           for: indexPath) as? T
            else { fatalError("Could not deque cell with type \(T.self)") }
        
        return cell
    }
    
    func dequeueCell(reuseIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath
        )
    }
    
}
