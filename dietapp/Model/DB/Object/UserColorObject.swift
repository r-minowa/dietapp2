//
//  UserColorObject.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/18.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation
import RealmSwift

class UserColorObject: Object {
    // 管理用　ID。プライマリーキー
    @objc dynamic var id: Int = 0
    // defalt
    @objc dynamic var defalt: Bool = true
    // red
    @objc dynamic var red: Bool = false
    // blue
    @objc dynamic var blue: Bool = false
    // yellow
    @objc dynamic var yellow: Bool = false
    // green
    @objc dynamic var green: Bool = false
    //orange
    @objc dynamic var orange: Bool = false
    // pink
    @objc dynamic var pink: Bool = false
    //violet
    @objc dynamic var violet: Bool = false
    
    // idをプライマリーキーとして設定
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int, defalt: Bool, red: Bool, blue: Bool, yellow: Bool, green: Bool, orange: Bool, pink: Bool, violet: Bool) {
        self.init()
        
        self.id = id
        self.defalt = defalt
        self.red = red
        self.blue = blue
        self.yellow = yellow
        self.green = green
        self.orange = orange
        self.pink = pink
        self.violet = violet
    }
}
