//
//  NoChallengeViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/05/28.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class NoChallengeViewController: UIViewController {
    
    // MARK: - LiyeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let colorSet = ColorManager.singletonColorManager.colorSet
        
        self.view.backgroundColor = colorSet.background
    }
}
