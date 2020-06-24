//
//  TargetWeightSettingProtocol.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/22.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

protocol TargetWeightSettingViewProtocol: AnyObject {
    var presenter: TargetWeightSettingPresenterProtocol? { get }
    
    func displayTargetWeightAlart(_ alart: UIAlertController)
    func dismissTargetWeightRecordView()
}

protocol TargetWeightSettingPresenterProtocol {
    var view: TargetWeightSettingViewProtocol? { get }
    
    func saveTargetWeight(_ targetWeightString: String)
}
