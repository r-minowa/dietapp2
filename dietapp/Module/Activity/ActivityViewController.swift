//
//  ActivityViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/09.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
    
    @IBOutlet weak var childView: UIView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = ActivityListViewController()
        self.addChild(vc)
        vc.view.frame = CGRect(x: 0, y: 0, width: self.childView.frame.maxX, height: self.childView.frame.maxY)
        self.childView.addSubview(vc.view)
    }
}
