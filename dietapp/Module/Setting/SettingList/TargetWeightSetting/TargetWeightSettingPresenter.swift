//
//  TargetWeightSettingPresenter.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/22.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

final class TargetWeightSettingPresenter {
    private(set) weak var view: TargetWeightSettingViewProtocol?
    private let realmAccessor: RealmAccessorProtocol
    
    private var targetWeightAlertController: UIAlertController!
    
    // Initialize
    init(view: TargetWeightSettingViewProtocol, realmAccessor: RealmAccessorProtocol) {
        self.view = view
        self.realmAccessor = realmAccessor
    }
    
    // MARK: - PrivateMethod
    
    func setTargetWeightAlart(title: String, message: String) {
        self.targetWeightAlertController = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .alert)
        self.targetWeightAlertController.addAction(UIAlertAction(title: "OK",
                                                style: .default,
                                                handler: nil
        ))
        
        self.view?.displayTargetWeightAlart(self.targetWeightAlertController)
    }
}

// MARK: - TargetWeightSettingPresenterProtocol

extension TargetWeightSettingPresenter: TargetWeightSettingPresenterProtocol {
    
    func saveTargetWeight(_ targetWeightString: String) {
        
        var targetWeight: Double = 0
        
        if targetWeightString.isNumber {
            if let weightDouble_ = Double(targetWeightString) {
                targetWeight = weightDouble_
            }
        }else {
            self.setTargetWeightAlart(title: "保存に失敗しました", message: "体重を入力してください")
        }
        
        
        if targetWeight > 0.0 {
            
            UserDefaultManager.shared.targetWeight = targetWeight
            self.view?.dismissTargetWeightRecordView()
        
        } else {
            self.setTargetWeightAlart(title: "保存に失敗しました", message: "体重を入力してください")
        }
    }
}
