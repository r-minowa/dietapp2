//
//  GetRealmActivity.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/10.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

struct GetRealmActivity: Equatable {
    let id: Int?
    let trainingName: String?
    let count: Int?
    let date: Date
    
    init(object: ActivityObject) {
        self.id = object.id
        self.trainingName = object.trainingName
        self.count = object.count
        self.date = object.date
    }
}
