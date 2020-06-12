//
//  ActivityDetailsPresenter.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/09.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

final class ActivityDetailsPresenter {
    private(set) weak var view: ActivityDetailsViewProtocol?
    private let realmAccessor: RealmAccessorProtocol
    
    private var activityArray: [GetRealmActivity] = []
    
    
    // MARK: - Initialize
    
    init(view: ActivityDetailsViewProtocol,
         realmAccessor: RealmAccessorProtocol) {
        self.view = view
        self.realmAccessor = realmAccessor
    }
}

// MARK: - ActivityDetailsPresenterProtocol

extension ActivityDetailsPresenter: ActivityDetailsPresenterProtocol {
    
    func getActivityDetails(_ name: String) {
        try! self.activityArray = self.realmAccessor.getActivity(name: name)
    }

    func getCountArray() -> [Double] {
        var countDoubleArray: [Double] = []
        
        for i in 0..<self.activityArray.count {
            countDoubleArray.append(Double(self.activityArray[i].count!))
        }
        
        return countDoubleArray
    }
    
    func getDate() -> [String] {
        var dateArray: [String] = []
        
        for i in 0..<self.activityArray.count {
            let date = self.activityArray[i].date
            let dateString = DateFormatters.customDateFormatter.string(from: date)
            
            dateArray.append(dateString)
        }
        
        return dateArray
    }
    
    func getNumOfTraining() -> Int {
        return self.activityArray.count
    }
    
    func getTotalCount() -> Int {
        var totalCount: Int = 0
        
        for i in 0..<self.activityArray.count {
            totalCount += self.activityArray[i].count!
        }
        
        return totalCount
    }
    
    func getMaxCount() -> Int {
        var max: Int = 0
        for i in 0..<self.activityArray.count {
            guard let count = self.activityArray[i].count else { return 0 }
            if max < count {
                max = count
            }
        }
        return max
    }
    
    func getMinCount() -> Int {
        var min: Int = 1000
        for i in 0..<self.activityArray.count {
            guard let count = self.activityArray[i].count else { return 0 }
            if min > count {
                min = count
            }
        }
        return min
    }
    
    func getAveCount() -> Int {
        var ave: Int = 0
    
        let sum = self.getTotalCount()
        
        if self.activityArray.count != 0 {
            ave = sum/self.activityArray.count
        }
        
        return ave
    }
}
