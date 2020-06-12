//
//  BodyWeightRecordPresenter.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/11.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

final class BodyWeightRecordPresenter {
    
    private(set) weak var view: BodyWeightRecordViewProtocol?
    private let realmAccessor: RealmAccessorProtocol
    
    // Initialize
    init(view: BodyWeightRecordViewProtocol, realmAccessor: RealmAccessorProtocol) {
        self.view = view
        self.realmAccessor = realmAccessor
    }
}

extension BodyWeightRecordPresenter: BodyWeightRecordPresenterProtocol {
 
    func saveWeight(_ weight: String, _ date: Date) {
        
        var weightDouble: Double = 0
        
        if weight.isNumber {
            if let weightDouble_ = Double(weight) {
                weightDouble = weightDouble_
            }
        }else {
            self.view?.displayAlert(title: "保存に失敗しました", message: "体重を入力してください")
        }
        
        
        if weightDouble > 0.0 {
            do {
                let id = try self.realmAccessor.getNewUserInfoId()
                try self.realmAccessor.saveUserInfo(id: id,
                                                    weight: weightDouble,
                                                    date: date
                )
                
                self.view?.dismissBodyWeightRecordView()
            } catch {
                print("DEBUG_PRINT: NewID取得エラー")
            }
        } else {
            self.view?.displayAlert(title: "保存に失敗しました", message: "体重を入力してください")
        }
    }
}
