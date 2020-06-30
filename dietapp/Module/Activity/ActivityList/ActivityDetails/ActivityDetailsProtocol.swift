//
//  ActivityDetailsProtocol.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/09.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

protocol ActivityDetailsViewProtocol: AnyObject {
    var presenter: ActivityDetailsPresenterProtocol? { get }
    
    func setPreviousLabel() 
}

protocol ActivityDetailsPresenterProtocol {
    var view: ActivityDetailsViewProtocol? { get }
    
    func getActivityDetails(_ name: String)
    func getCountArray() -> [Double]
    func getDate() -> [String]
    func getNumOfTraining() -> Int
    func getTotalCount() -> Int
    func getMaxCount() -> Int
    func getMinCount() -> Int
    func getAveCount() -> Int
    func getPreviousData() -> Int
}
