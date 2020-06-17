//
//  BodyWeightGraphProtocol.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/15.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

protocol BodyWeightGraphViewProtocol: AnyObject {
    var presenter: BodyWeightGraphPresenterProtocol? { get }
}

protocol BodyWeightGraphPresenterProtocol {
    var view: BodyWeightGraphViewProtocol? { get }
    
    func getDayWeight(_ date: Date) -> Double?
    func getNewestDayWeight() -> Double
    func getWeekWeight(_ date: Date) -> [Double]
    func getWeekWeightAve(_ date: Date) -> Double
}
