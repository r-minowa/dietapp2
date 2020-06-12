//
//  ActivityRecordPresenter.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/09.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

final class ActivityRecordPresenter {
    
    private(set) weak var view: ActivityRecordViewProtocol?
    private let realmAccessor: RealmAccessorProtocol
    
    var today = Date()
    
    // MARK: - Initialize
       
       init(view: ActivityRecordViewProtocol,
            realmAccessor: RealmAccessorProtocol) {
           self.view = view
           self.realmAccessor = realmAccessor
       }
}

// MARK: - ActivityRecordViewProtocol

extension ActivityRecordPresenter: ActivityRecordPresenterProtocol {
    
    func saveCountRealm(_ name: String, _ count: String) {
        
        var countInt: Int = 0
        
        // 数字かどうか判別する
        if count.isNumber {
            if let countInt_ = Int(count) {
                countInt = countInt_
            }
        } else {
            self.view?.displayAlert(title: "保存失敗しました", message: "数字を入力してください")
        }
 
        // 入力回数が0以上のとき
        if countInt > 0 {
            do {
                let id = try self.realmAccessor.getNewActivityId()
                try self.realmAccessor.saveActivityCount(id: id,
                                                         name: name,
                                                         count: countInt,
                                                         date: today)
                self.view?.dismissActivityView()
            } catch {
                print("DEBUG_PRINT: NewID取得エラー")
            }
        } else {
            self.view?.displayAlert(title: "保存失敗しました", message: "0回以上の回数を入力してください")
        }
        
    }
    
}
