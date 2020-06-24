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
        case unlockPoint = "unlockPoint"
        case color = "color"
        case targetWeight = "targetWeight"
        case isShowStepsAlart = "isShowStepsAlart"
        case endToday = "endToday"
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
    
    // unlockPoint管理変数
    var unlockPoint: Int {
        set {
            defaults.set(newValue, forKey: Key.unlockPoint.rawValue)
        }
        get {
            return defaults.integer(forKey: Key.unlockPoint.rawValue)
        }
    }
    
    // color管理変数
    var color: String {
        set {
            defaults.set(newValue, forKey: Key.color.rawValue)
            defaults.synchronize()
        }
        get {
            guard let hoge = defaults.string(forKey: Key.color.rawValue) else { return "a"}
            return hoge
        }
    }
    
    // 目標体重
    var targetWeight: Double {
        set {
            defaults.set(newValue, forKey: Key.targetWeight.rawValue)
        }
        get {
            return defaults.double(forKey: Key.targetWeight.rawValue)
        }
    }
    
    // 目標歩数の達成フラグ
    var isShowStepsAlart: Bool {
        set {
            defaults.set(newValue, forKey: Key.isShowStepsAlart.rawValue)
        }
        get {
            return defaults.bool(forKey: Key.isShowStepsAlart.rawValue)
        }
    }
    
    // 今日の23:59
    var endToday: Date {
        set {
            defaults.set(newValue, forKey: Key.endToday.rawValue)
        }
        get {
            let  endToday = Date()
            guard let endToday_ = self.load(key: Key.endToday.rawValue) else { return endToday - 10.days }
            return endToday_
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
