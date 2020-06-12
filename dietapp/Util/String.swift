//
//  String.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/09.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

extension String {
    /// ひらがなかどうか
    var isHiragana: Bool {
        let range = "^[ぁ-ゞ 　]+$"
        return NSPredicate(format: "SELF MATCHES %@", range).evaluate(with: self)
    }

    /// カタカナかどうか
    var isKatakana: Bool {
        let range = "^[ァ-ヾ]+$"
        return NSPredicate(format: "SELF MATCHES %@", range).evaluate(with: self)
    }

    //// 英数字かどうか
    var isAlphanumeric: Bool {
        let range = "[a-zA-Z0-9]+"
        return NSPredicate(format: "SELF MATCHES %@", range).evaluate(with: self)
    }
    
    //// 数字かどうか
    var isNumber: Bool {
        let range = "[0-9.]+"
        return NSPredicate(format: "SELF MATCHES %@", range).evaluate(with: self)
    }
}
