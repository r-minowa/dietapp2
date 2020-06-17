//
//  BodyWeightGraphPresenter.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/15.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation
import SwiftDate

final class BodyWeightGraphPresenter {
    private(set) weak var view: BodyWeightGraphViewProtocol?
    private let realmAccessor: RealmAccessorProtocol
    
    let today = Date()
    
    // Initialize
    init(view: BodyWeightGraphViewProtocol, realmAccessor: RealmAccessorProtocol) {
        self.view = view
        self.realmAccessor = realmAccessor
    }
}

// MARK: - BodyWeightGraphPresenterProtocol

extension BodyWeightGraphPresenter: BodyWeightGraphPresenterProtocol {
    
   
    func getNewestDayWeight() -> Double {
        var dayNewestweight: Double = 0
        var userInfo: [GetRealmUserInfo] = []
        var userInfo_: GetRealmUserInfo
        
        try! userInfo = self.realmAccessor.getAllUserInfo()
        
        if userInfo != [] {
            userInfo_ = userInfo[0]
            for i in 0..<userInfo.count {
                if DateFormatters.customDateHourFormatter.string(from: userInfo_.date) <=
                    DateFormatters.customDateHourFormatter.string(from: userInfo[i].date) {
                    userInfo_ = userInfo[i]
                }
            }
            
            if let dayNewestweight_ = userInfo_.weight {
                dayNewestweight = dayNewestweight_
            }
        }
        
        return dayNewestweight
    }
    
    /// 選択された日付の体重を取得
    /// - Parameter date: カレンダーの日付
    func getDayWeight(_ date: Date) -> Double? {
        var dayweight: Double = 0
        var userInfo: [GetRealmUserInfo] = []
        
        try! userInfo = self.realmAccessor.getUserInfo(date: date)
        
        if userInfo != [] {
            if let dayweight_ = userInfo[userInfo.count - 1].weight {
                dayweight = dayweight_
            }
        } else {
            return nil
        }
        
        return dayweight
    }
    
    func getWeekWeight(_ date: Date) -> [Double] {
        var beginWeekDate = date
        var weekWeightArray: [Double] = []
        var userInfo: [GetRealmUserInfo] = []
        var dayCount: Int = 0
        
        switch date.weekdayName(.default) {
        case "日曜日":
            dayCount = 0
        case "月曜日":
            dayCount = 1
        case "火曜日":
            dayCount = 2
        case "水曜日":
            dayCount = 3
        case "木曜日":
            dayCount = 4
        case "金曜日":
            dayCount = 5
        default:
            dayCount = 6
        }
        
        beginWeekDate = beginWeekDate - dayCount.days
        
        // 翌日の日付(判定用)
        let todayStr = DateFormatters.customDateFormatter.string(from: today + 1.days)
        
        // 今日までのweightの取得
        for_getWeight: for _ in 0..<7 {
            
            // 今週始めからの日付(判定用)
            let beginWeekDateStr = DateFormatters.customDateFormatter.string(from: beginWeekDate)
    
            // beginWeekDateが翌日になったらfor文を抜ける
            if beginWeekDateStr == todayStr  {
                break for_getWeight
            }
            
            try! userInfo = self.realmAccessor.getUserInfo(date: beginWeekDate)
            
            if userInfo != [] {
                if let weight = userInfo[userInfo.count - 1].weight {
                    weekWeightArray.append(weight)
                }
            }
            
            beginWeekDate = beginWeekDate + 1.days
        }
        
        return weekWeightArray
    }
    
    func getWeekWeightAve(_ date: Date) -> Double {
        let weekWeight = self.getWeekWeight(date)
        var weekWeightAveDouble: Double = 0.0
        var weekWeightAll: Double = 0.0
        
        if weekWeight != [] {
            for i in 0..<weekWeight.count {
                weekWeightAll += weekWeight[i]
            }
            weekWeightAveDouble = weekWeightAll / Double(weekWeight.count)
        } else {
            return weekWeightAveDouble
        }
        
        return weekWeightAveDouble
    }
}
