//
//  ActivityObject.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/09.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation
import RealmSwift

class ActivityObject: Object {
    // 管理用　ID。プライマリーキー
    @objc dynamic var id: Int = 0
    // 名前
    @objc dynamic var trainingName: String = ""
    // 回数
    @objc dynamic var count: Int = 0
    // 日付
    @objc dynamic var date = Date()
    
    // idをプライマリーキーとして設定
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int, trainingName: String, count: Int, date: Date) {
        self.init()
        
        self.id = id
        self.trainingName = trainingName
        self.count = count
        self.date = date
    }
}
