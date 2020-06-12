//
//  getRealmChallenge.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/05/29.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

struct GetRealmChallenge: Equatable {
    let id: Int?
    let difficulty: String?
    let bodyParts: String?
    let dayTraining: [String]?
    let date: Date
    let progressFlag: [Bool]?
    
    init(object: UserTrainingObject) {
        self.id = object.id
        self.difficulty = object.difficulty
        self.bodyParts = object.bodyParts
        var dayTrainingStr: [String] = []
        for i in 0..<3 {
            dayTrainingStr.append(object.dayTraining[i])
        }
        self.dayTraining = dayTrainingStr
        self.date = object.date
        var dayProgressFlag: [Bool] = []
        for i in 0..<3 {
            dayProgressFlag.append(object.progressFlag[i])
        }
        self.progressFlag = dayProgressFlag
    }

}
