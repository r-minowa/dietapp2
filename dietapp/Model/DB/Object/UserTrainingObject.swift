//
//  UserTraining.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/05/26.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation
import RealmSwift

class UserTrainingObject: Object {
    // 管理用　ID。プライマリーキー
    @objc dynamic var id: Int = 0
    // 難易度
    @objc dynamic var difficulty: String = ""
    // 部位
    @objc dynamic var bodyParts: String = ""
    // 日毎のトレーニング(3つ)
    var dayTraining = List<String>()
    // 日付
    @objc dynamic var date = Date()
    // 達成・未達成のフラグ
    var progressFlag = List<Bool>()
    
    // idをプライマリーキーとして設定
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int, difficulty: String, bodyParts: String, dayTraining: List<String>, date: Date, flag: List<Bool>) {
        self.init()
        
        self.id = id
        self.difficulty = difficulty
        self.bodyParts = bodyParts
        self.dayTraining = dayTraining
        self.date = date
        self.progressFlag = flag
    }
}
