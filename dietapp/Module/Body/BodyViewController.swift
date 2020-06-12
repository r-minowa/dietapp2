//
//  BodyViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/05/19.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class BodyViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var childView: UIView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = BodyWeightViewController()
        self.addChild(vc)
        self.childView.addSubview(vc.view)
        
    }
}
