//
//  UserDefaultManager.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/02.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation
import SwiftDate

class UserDefaultManager {
    static let shared = UserDefaultManager()
    
    private enum Key: String {
        case firstStartingDay = "firstStartingDay"
        case firstStartingDayFlag = "firstStartingDayFlag"
        case isShowPopUp = "isShowPopUp"
        case nextSaturday = "nextSaturday"
        case point = "point"
        case color = "color"
    }
    
    private var defaults: UserDefaults {
        return UserDefaults.standard
    }
    
    // 初回機動日
    var firstStartingDay: Date {
        set {
            defaults.set(newValue, forKey: Key.firstStartingDay.rawValue)
        }
        get {
            let  firstday = Date()
            guard let firstday_ = self.load(key: Key.firstStartingDay.rawValue) else { return firstday - 10.days }
            return firstday_
        }
    }
    
    // 初回起動日判定日フラグ
    var firstStartingDayFlag: Bool {
        set {
            defaults.set(newValue, forKey: Key.firstStartingDayFlag.rawValue)
        }
        get {
            return defaults.bool(forKey: Key.firstStartingDayFlag.rawValue)
        }
    }
    
    // ポップアップ表示のフラグ
    var isShowPopUp: Bool {
        set {
            defaults.set(newValue, forKey: Key.isShowPopUp.rawValue)
        }
        get {
            return defaults.bool(forKey: Key.isShowPopUp.rawValue)
        }
    }
    
    // 今週の土曜日
    var nextSaturday: Date {
        set {
            defaults.set(newValue, forKey: Key.nextSaturday.rawValue)
        }
        get {
            let  nextSat = Date()
            guard let nextSat_ = self.load(key: Key.nextSaturday.rawValue) else { return nextSat - 10.days }
            return nextSat_
        }
    }
    
    // Point管理変数
    var point: Int {
        set {
            defaults.set(newValue, forKey: Key.point.rawValue)
        }
        get {
            return defaults.integer(forKey: Key.point.rawValue)
        }
    }
    
    var color: String {
        set {
            defaults.set(newValue, forKey: Key.color.rawValue)
        }
        get {
            guard let hoge = defaults.string(forKey: Key.color.rawValue) else { return "a"}
            return hoge
        }
    }
    
    
    
    // MARK: - PrivateMethod
    
    private func load(key: String) -> Date? {
        let value = UserDefaults.standard.object(forKey: key)
        guard let date = value as? Date else {
            return nil
        }
        return date
    }
}
