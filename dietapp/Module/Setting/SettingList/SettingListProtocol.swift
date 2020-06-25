//
//  SettingListProtocol.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/19.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

protocol SettingListViewProtocol: AnyObject {
    var presenter: SettingListPresenterProtocol? { get }
    
    func trancefromSettingtoTargetWeight(_ vc: TargetWeightSettingViewController)
    func trancefromInputPopup(_ vc: InputPopupViewController)
    func trancefromSettingtoPopup(_ vc: PopupViewController)
    func trancefromSettingtoDistance(_ vc: DistanceSettingViewController)
}

protocol SettingListPresenterProtocol {
    var view: SettingListViewProtocol? { get }
    
    func selectCell(_ index: Int)
}
