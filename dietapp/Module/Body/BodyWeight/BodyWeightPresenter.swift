//
//  BodyWeightPresenter.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/11.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation
import CalculateCalendarLogic

final class BodyWeightPresenter {
    private(set) weak var view: BodyWeightViewProtocol?
    private var realmAccessor: RealmAccessorProtocol
    
    let today = Date()
    
    // Intialize
    init(view: BodyWeightViewProtocol, realmAccessor: RealmAccessorProtocol) {
        self.view = view
        self.realmAccessor = realmAccessor
    }
}

extension BodyWeightPresenter: BodyWeightPresenterProtocol {
    
    func getIntAchievementRealm(_ date: Date) -> Int {
        
        var challenge: [GetRealmChallenge] = []
        var count = 0
        
        do {
            try challenge = self.realmAccessor.getChallenge(date: date)
        } catch {
            print("DEBUG_PRINT: getChallengeエラー")
        }
        
        // 達成の数をカウント
        if challenge != [] {
            if let flag = challenge[0].progressFlag {
                for i in 0..<flag.count {
                    if flag[i] {
                        count += 1
                    }
                }
            }
        }
        
        return count
    }
    
    /// 選択された日付を持ってRecordに遷移する
    /// - Parameter date: 選択されたカレンダーの日付
    func selectCalender(_ date: Date) {
        let vc = BodyWeightRecordViewController()
        vc.calenderDate = date
        vc.modalPresentationStyle = .fullScreen
        self.view?.transeWeightRecordView(vc)
    }
    
    // 祝日判定を行い結果を返すメソッド(True:祝日)
    func judgeHoliday(_ date : Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)
        
        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        
        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    
    //曜日判定(日曜日:1 〜 土曜日:7)
    func getWeekIdx(_ date: Date) -> Int {
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }
}
