//
//  GetRealmUserColor.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/18.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

struct GetRealmUserColor: Equatable {
    let id: Int?
    let defalt: Bool?
    let red: Bool?
    let blue: Bool?
    let yellow: Bool?
    let green: Bool?
    let orange: Bool?
    let pink: Bool?
    let violet: Bool?
    
    init(object: UserColorObject) {
        self.id = object.id
        self.defalt = object.defalt
        self.red = object.red
        self.blue = object.blue
        self.yellow = object.yellow
        self.green = object.green
        self.orange = object.orange
        self.pink = object.pink
        self.violet = object.violet
    }
}
