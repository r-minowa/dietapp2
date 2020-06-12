//
//  UIColor.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/05.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

class MyColor: UIColor {

    public enum Name: String {
        case CustomRed
        case CustomGreen
        case CustomBlue
    }

    public convenience init(name: Name) {
        switch name {
        case .CustomRed: self.init(red: 1, green: 0, blue: 0, alpha: 1)
        case .CustomGreen: self.init(red: 0, green: 1, blue: 0, alpha: 1)
        case .CustomBlue: self.init(red: 0, green: 0, blue: 1, alpha: 1)
        }
    }
}


extension UIColor {
    convenience init(hex: String) {
        // スペースや改行がはいっていたらトリムする
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        // 頭に#がついていたら取り除く
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        // RGBに変換する
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
