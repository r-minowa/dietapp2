//
//  ColorManager.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/16.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class SingletonColorManager: NSObject {
    
}


class ColorManager {
    enum ThemeType: String, CaseIterable {
        case defaultColor = "default"
        case red
        case blue
        case yellow
        case green
        case orange
        case pink
        case violet
    }

    struct ColorSet {
        var background: UIColor
        var tabBackground: UIColor
        var tabTint: UIColor
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
        var graphColor: UIColor
        var graphProtColor: UIColor
    }

    private var themas: [ThemeType: ColorSet] = [
        .red: ColorSet(background: UIColor(red: 255/255, green: 230/255, blue: 240/255, alpha: 255/255),
                       tabBackground: UIColor(red: 255/255, green: 50/255, blue: 50/255, alpha: 255/255),
                       tabTint: UIColor(red: 255/255, green: 50/255, blue: 50/255, alpha: 255/255),
                       thick: UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 255/255),
                       mid: UIColor(red: 255/255, green: 100/255, blue: 100/255, alpha: 255/255),
                       light: UIColor(red: 255/255, green: 200/255, blue: 200/255, alpha: 255/255),
                       titleText: .black,
                       bodyText: .black,
                       buttonBackground: UIColor(red: 255/255, green: 50/255, blue: 50/255, alpha: 255/255),
                       buttonTint: .white,
                       inputButtonBackground: UIColor(red: 255/255, green: 50/255, blue: 50/255, alpha: 255/255),
                       inputButtonTint: .white,
                       backButtonBackground: .clear,
                       backButtonTint: .black,
                       graphColor: UIColor(red: 200/255, green: 0/255, blue: 0/255, alpha: 255/255),
                       graphProtColor: UIColor(red: 255/255, green: 100/255, blue: 100/255, alpha: 255/255)),
        
        .blue: ColorSet(background: UIColor(red: 240/255, green: 240/255, blue: 255/255, alpha: 255/255),
                        tabBackground:UIColor(red: 100/255, green: 100/255, blue: 255/255, alpha: 255/255),
                        tabTint: UIColor(red: 100/255, green: 100/255, blue: 255/255, alpha: 255/255),
                        thick: UIColor(red: 100/255, green: 100/255, blue: 255/255, alpha: 255/255),
                        mid: UIColor(red: 125/255, green: 125/255, blue: 255/255, alpha: 255/255),
                        light: UIColor(red: 200/255, green: 200/255, blue: 255/255, alpha: 255/255),
                        titleText: UIColor(red: 0/255, green: 0/255, blue: 50/255, alpha: 255/255),
                        bodyText: .black,
                        buttonBackground: UIColor(red: 50/255, green: 50/255, blue: 255/255, alpha: 255/255),
                        buttonTint: .white,
                        inputButtonBackground: UIColor(red: 50/255, green: 50/255, blue: 255/255, alpha: 255/255),
                        inputButtonTint: .white,
                        backButtonBackground: .clear,
                        backButtonTint: .black,
                        graphColor: UIColor(red: 50/255, green: 50/255, blue: 255/255, alpha: 255/255),
                        graphProtColor: UIColor(red: 125/255, green: 125/255, blue: 255/255, alpha: 255/255)),
        
        .yellow: ColorSet(background: UIColor(red: 255/255, green: 255/255, blue: 240/255, alpha: 255/255),
                          tabBackground: UIColor(red: 255/255, green: 255/255, blue: 150/255, alpha: 255/255),
                          tabTint: UIColor(red: 255/255, green: 140/255, blue: 0/255, alpha: 255/255),
                          thick: UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 255/255),
                          mid: UIColor(red: 255/255, green: 255/255, blue: 150/255, alpha: 255/255),
                          light: UIColor(red: 255/255, green: 255/255, blue: 200/255, alpha: 255/255),
                          titleText: .black,
                          bodyText: .black,
                          buttonBackground: UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 255/255),
                          buttonTint: .black,
                          inputButtonBackground: UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 255/255),
                          inputButtonTint: .white,
                          backButtonBackground: .clear,
                          backButtonTint: .black,
                          graphColor: UIColor(red: 205/255, green: 133/255, blue: 0/255, alpha: 255/255),
                          graphProtColor: UIColor(red: 139/255, green: 69/255, blue: 0/255, alpha: 255/255)),
        
        .green: ColorSet(background: UIColor(red: 230/255, green: 255/255, blue: 230/255, alpha: 255/255),
                         tabBackground: UIColor(red: 130/255, green: 255/255, blue: 130/255, alpha: 255/255),
                         tabTint: UIColor(red: 0/255, green: 150/255, blue: 0/255, alpha: 255/255),
                         thick: UIColor(red: 0/255, green: 230/255, blue: 0/255, alpha: 255/255),
                         mid: UIColor(red: 100/255, green: 255/255, blue: 100/255, alpha: 255/255),
                         light: UIColor(red: 175/255, green: 255/255, blue: 175/255, alpha: 255/255),
                         titleText: .black,
                         bodyText: .black,
                         buttonBackground: UIColor(red: 0/255, green: 205/255, blue: 0/255, alpha: 255/255),
                         buttonTint: .white,
                         inputButtonBackground:  UIColor(red: 0/255, green: 205/255, blue: 0/255, alpha: 255/255),
                         inputButtonTint: .white,
                         backButtonBackground: .clear,
                         backButtonTint: .black,
                         graphColor:  UIColor(red: 0/255, green: 139/255, blue: 0/255, alpha: 255/255),
                         graphProtColor:  UIColor(red: 0/255, green: 139/255, blue: 69/255, alpha: 255/255)),
        
        .orange: ColorSet(background: UIColor(red: 253/255, green: 245/255, blue: 230/255, alpha: 255/255),
                          tabBackground: UIColor(red: 255/255, green: 100/255, blue: 0/255, alpha: 255/255),
                          tabTint: UIColor(red: 238/255, green: 118/255, blue: 33/255, alpha: 255/255),
                          thick: UIColor(red: 255/255, green: 140/255, blue: 0/255, alpha: 255/255),
                          mid: UIColor(red: 255/255, green: 170/255, blue: 0/255, alpha: 255/255),
                          light: UIColor(red: 255/255, green: 220/255, blue: 150/255, alpha: 255/255),
                          titleText: .black,
                          bodyText: .black,
                          buttonBackground: UIColor(red: 255/255, green: 100/255, blue: 0/255, alpha: 255/255),
                          buttonTint: .white,
                          inputButtonBackground: UIColor(red: 255/255, green: 100/255, blue: 0/255, alpha: 255/255),
                          inputButtonTint: .white,
                          backButtonBackground: .clear,
                          backButtonTint: .black,
                          graphColor: UIColor(red: 200/255, green: 100/255, blue: 0/255, alpha: 255/255),
                          graphProtColor: UIColor(red: 200/255, green: 75/255, blue: 0/255, alpha: 255/255)),
        
        .pink: ColorSet(background: UIColor(red: 255/255, green: 240/255, blue: 245/255, alpha: 255/255),
                        tabBackground: UIColor(red: 255/255, green: 110/255, blue: 180/255, alpha: 255/255),
                        tabTint: UIColor(red: 255/255, green: 20/255, blue: 147/255, alpha: 255/255),
                        thick: UIColor(red: 255/255, green: 0/255, blue: 200/255, alpha: 255/255),
                        mid: UIColor(red: 255/255, green: 125/255, blue: 200/255, alpha: 255/255),
                        light: UIColor(red: 255/255, green: 175/255, blue: 200/255, alpha: 255/255),
                        titleText: .black,
                        bodyText: .black,
                        buttonBackground: UIColor(red: 255/255, green: 20/255, blue: 147/255, alpha: 255/255),
                        buttonTint: .white,
                        inputButtonBackground: UIColor(red: 255/255, green: 20/255, blue: 147/255, alpha: 255/255),
                        inputButtonTint: .white,
                        backButtonBackground: .clear,
                        backButtonTint: .black,
                        graphColor: UIColor(red: 199/255, green: 21/255, blue: 133/255, alpha: 255/255),
                        graphProtColor: UIColor(red: 208/255, green: 32/255, blue: 144/255, alpha: 255/255)),
        
        .violet: ColorSet(background: UIColor(red: 255/255, green: 230/255, blue: 255/255, alpha: 255/255),
                          tabBackground: UIColor(red: 148/255, green: 75/255, blue: 211/255, alpha: 255/255),
                          tabTint: UIColor(red: 148/255, green: 0/255, blue: 211/255, alpha: 255/255),
                          thick: UIColor(red: 175/255, green: 100/255, blue: 255/255, alpha: 255/255),
                          mid: UIColor(red: 200/255, green: 150/255, blue: 255/255, alpha: 255/255),
                          light: UIColor(red: 255/255, green: 200/255, blue: 255/255, alpha: 255/255),
                          titleText: .black,
                          bodyText: .black,
                          buttonBackground: UIColor(red: 180/255, green: 82/255, blue: 205/255, alpha: 255/255),
                          buttonTint: .white,
                          inputButtonBackground:  UIColor(red: 180/255, green: 82/255, blue: 205/255, alpha: 255/255),
                          inputButtonTint: .white,
                          backButtonBackground: .clear,
                          backButtonTint: .black,
                          graphColor:  UIColor(red: 85/255, green: 26/255, blue: 139/255, alpha: 255/255),
                          graphProtColor:  UIColor(red: 93/255, green: 71/255, blue: 239/255, alpha: 255/255))
        
        
//        UIColor(red: /255, green: /255, blue: /255, alpha: 255/255)
    ]
    
    private var defaultColorSet = ColorSet(
        background: UIColor(white: 0.9, alpha: 1.0),
        tabBackground: UIColor(white: 0.6, alpha: 1.0),
        tabTint: UIColor(white:0.2, alpha:1.0),
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
        backButtonTint: .black,
        graphColor: .black,
        graphProtColor: UIColor(white: 0.6, alpha: 1.0)
    )
    
    static var singletonColorManager = ColorManager()
    
    private init(){}

    var colorSet: ColorSet {
        get {
            if let set = themas[getThemeType()]{
                return set
            }else {
                return defaultColorSet
            }
        }
    }
    
    func colorGet(_ color: ThemeType) -> UIColor {
        var themeColor: UIColor = .gray
        if let get = themas[color] {
            themeColor = get.thick
        }
            return themeColor
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
