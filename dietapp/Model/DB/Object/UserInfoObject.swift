//
//  userInfo.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/05/26.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation
import RealmSwift

class UserInfoObject: Object {
    // 管理用　ID。プライマリーキー
    @objc dynamic var id: Int = 0
    // 体重
    @objc dynamic var weight: Double = 0
//    // 体脂肪率
//    @objc dynamic var bodyFat: Int = 0
    // 日付
    @objc dynamic var date = Date()
    
    // idをプライマリーキーとして設定
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int, weight: Double, date: Date) {
        self.init()
        
        self.id = id
        self.weight = weight
        self.date = date
    }
}

