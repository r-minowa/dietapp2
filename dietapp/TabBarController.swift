//
//  TabBarController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/11.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let colorSet = ColorManager.singletonColorManager.colorSet
        // バー色
        UITabBar.appearance().backgroundColor = colorSet.tabBackground
        UITabBar.appearance().tintColor = colorSet.tabTint
    }
}
