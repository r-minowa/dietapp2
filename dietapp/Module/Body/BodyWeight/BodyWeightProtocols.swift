//
//  BodyWeightProtocols.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/11.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

protocol BodyWeightViewProtocol: AnyObject {
    var presenter: BodyWeightPresenterProtocol? { get }
    
    func transeWeightRecordView(_ vc: BodyWeightRecordViewController)
    
}

protocol BodyWeightPresenterProtocol {
    var view: BodyWeightViewProtocol? { get }
    
    func getIntAchievementRealm(_ date: Date) -> Int
    func selectCalender(_ date: Date)
    func judgeHoliday(_ date : Date) -> Bool
    func getWeekIdx(_ date: Date) -> Int
}
