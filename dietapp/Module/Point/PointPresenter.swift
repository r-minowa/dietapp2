//
//  PointPresenter.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/17.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

final class PointPresenter {
    private(set) weak var view: PointViewProtocol?
    private var realmAccessor: RealmAccessorProtocol
    
    // Inititalize
    init(view: PointViewProtocol, realmAccessor: RealmAccessorProtocol) {
        self.view = view
        self.realmAccessor = realmAccessor
    }
}

extension PointPresenter: PointPresenterProtocol {
    
    func selectColor(_ index: Int) {
        var count = 0
        var colorName = ""
        
        for_color: for color in ColorManager.ThemeType.allCases {
            colorName = color.rawValue
            if count == index {
                break for_color
            }
            count += 1
        }
        
        print(colorName)
        
        UserDefaultManager.shared.color = colorName
    }
}
