//
//  GetRealmUserInfo.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/11.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

struct GetRealmUserInfo: Equatable {
    let id: Int?
    let weight: Double?
    let date: Date
    
    init(object: UserInfoObject) {
        self.id = object.id
        self.weight = object.weight
        self.date = object.date
    }
}
