//
//  ColorManager.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/16.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class ColorManager {
    enum ThemeType: String, CaseIterable {
        case defaultColor = "black"
        case red
//        case blue
//        case yellow
//        case green
//        case orange
//        case pink
    }

    struct ColorSet {
        var background: UIColor
        var thick: UIColor
        var mid: UIColor
        var light: UIColor
        var titleText: UIColor
        var bodyText: UIColor
        var buttonBackground: UIColor
        var buttonTint: UIColor
        var inputButtonBackground: UIColor
        var inputButtonTint: UIColor
        var backButtonBackground: UIColor
        var backButtonTint: UIColor
    }

    private var themas: [ThemeType: ColorSet] = [
        .red: ColorSet(background: UIColor(red: 255/255, green: 200/255, blue: 200/255, alpha: 255/255),
                       thick: UIColor(red: 255/255, green: 50/255, blue: 50/255, alpha: 255/255),
                       mid: UIColor(red: 255/255, green: 100/255, blue: 100/255, alpha: 255/255),
                       light: UIColor(red: 255/255, green: 150/255, blue: 150/255, alpha: 255/255),
                       titleText: .black,
                       bodyText: .black,
                       buttonBackground: UIColor(red: 255/255, green: 50/255, blue: 50/255, alpha: 255/255),
                       buttonTint: .white,
                       inputButtonBackground: UIColor(red: 255/255, green: 50/255, blue: 50/255, alpha: 255/255),
                       inputButtonTint: .white,
                       backButtonBackground: .clear,
                       backButtonTint: .black)
    ]

    private var defaultColorSet = ColorSet(
        background: UIColor(white: 0.9, alpha: 1.0),
        thick: UIColor(white:0.5, alpha:1.0),
        mid: UIColor(white: 0.6, alpha: 1.0),
        light: UIColor(white:0.8, alpha:1.0),
        titleText: .black,
        bodyText: .black,
        buttonBackground: UIColor(white:0.5, alpha:1.0),
        buttonTint: .white,
        inputButtonBackground: UIColor(white:0.5, alpha:1.0),
        inputButtonTint: .white,
        backButtonBackground: .clear,
        backButtonTint: .black
    )

    var colorSet: ColorSet {
        get {
            if let set = themas[getThemeType()]{
                return set
            }else {
                return defaultColorSet
            }
        }
    }

    private func getThemeType() -> ThemeType {
        // Todo: userDefaultから取ってきたTypeを見る
        var themeType: ThemeType = .defaultColor
        
        for color in ThemeType.allCases {
            if UserDefaultManager.shared.color == color.rawValue {
                themeType = color
            }
        }
        
        return themeType
    }
}
