//
//  BodyWeightViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/10.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit
import FSCalendar
import Charts

class BodyWeightViewController: UIViewController {
    
    private(set) lazy var presenter: BodyWeightPresenterProtocol? = BodyWeightPresenter(view: self, realmAccessor: RealmAccessor())

    var max = 0.0
    var min = 1000.0
    
    let colorManager = ColorManager().colorSet
    let today = Date()
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var calenderView: FSCalendar! {
        didSet {
            self.calenderView.dataSource = self
            self.calenderView.delegate = self
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.calenderView.backgroundColor = self.colorManager.background
        
        calenderView.appearance.todayColor = UIColor.red
        calenderView.appearance.headerTitleColor = UIColor.red
        calenderView.appearance.weekdayTextColor = UIColor.red
        calenderView.scope = .month

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        calenderView.reloadData()
    }
}

// MARK: - BodyWeightViewProtocol

extension BodyWeightViewController: BodyWeightViewProtocol {
    func transeWeightRecordView(_ vc: BodyWeightGraphViewController) {
        show(vc, sender: nil)
    }
}

// MARK: - FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance

extension BodyWeightViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //祝日判定をする（祝日は赤色で表示する）
        if let holidayBool = self.presenter?.judgeHoliday(date){
            if holidayBool{
                return UIColor.red
            }
        }
        
        //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
        let weekday = self.presenter?.getWeekIdx(date)
        if weekday == 1 {   //日曜日
            return UIColor.red
        }
        else if weekday == 7 {  //土曜日
            return UIColor.blue
        }
        
        return nil
    }
    
    /// カレンダーの日付がタップされたとき
    /// - Parameter calendar: FSCalendar
    /// - Parameter date: カレンダーの日付
    /// - Parameter monthPosition: FSCalendarMonthPosition
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        self.presenter?.selectCalender(date)
    }
    
    /// 達成数をカレンダーに表示する
    /// - Parameter calendar: FSCalendar
    /// - Parameter date: カレンダーの日付,1ヶ月単位(全て15時で取得している)
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if let count = self.presenter?.getIntAchievementRealm(date) {
            return count
        }
        return 0
    }
    
    /// サブタイトル設定
    /// - Parameter calendar: FSCalendar
    /// - Parameter date: カレンダーの日付
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        if let weight = self.presenter?.getDayWeight(date) {
            return String(weight)
        }
        return nil
    }
}
