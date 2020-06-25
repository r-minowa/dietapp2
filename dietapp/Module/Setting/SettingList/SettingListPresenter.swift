//
//  SettingListPresenter.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/19.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

final class SettingListPresenter {
    private(set) weak var view: SettingListViewProtocol?
    private(set) var realmAccessor: RealmAccessorProtocol
    
    // Initialize
    init(view: SettingListViewProtocol, realmAccessor: RealmAccessorProtocol){
        self.view = view
        self.realmAccessor = realmAccessor
    }
}

// MARK: - SettingPresenterProtocol

extension SettingListPresenter: SettingListPresenterProtocol {
    func selectCell(_ index: Int) {
        if index == 0 {
//            let vc = TargetWeightSettingViewController()
//            self.view?.trancefromSettingtoTargetWeight(vc)
            
            let vc = InputPopupViewController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            vc.titleName = "目標体重"
            self.view?.trancefromInputPopup(vc)
        } else if index == 1 {
            let vc = PopupViewController()
            vc.alartFlag = true
            self.view?.trancefromSettingtoPopup(vc)
        } else if index == 2 {
            let vc = DistanceSettingViewController()
            self.view?.trancefromSettingtoDistance(vc)
        }
    }
}
