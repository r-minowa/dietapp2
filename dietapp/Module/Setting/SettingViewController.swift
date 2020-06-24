//
//  SettingViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/05/18.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var childView: UIView!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = SettingListViewController()
        self.addChild(vc)
        vc.view.frame = CGRect(x: 0, y: 0, width: self.childView.frame.maxX, height: self.childView.frame.maxY)
        self.childView.addSubview(vc.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let colorSet = ColorManager.singletonColorManager.colorSet
        
        self.view.backgroundColor = colorSet.background
    }
}
