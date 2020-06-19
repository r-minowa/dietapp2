//
//  PointPresenter.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/17.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation
import UIKit

final class PointPresenter {
    private(set) weak var view: PointViewProtocol?
    private var realmAccessor: RealmAccessorProtocol
    
    var pointAlertController: UIAlertController!
    
    // Inititalize
    init(view: PointViewProtocol, realmAccessor: RealmAccessorProtocol) {
        self.view = view
        self.realmAccessor = realmAccessor
    }
    
    // MARK: - PrivateMethod
    func redeemPoints() {
        UserDefaultManager.shared.point = UserDefaultManager.shared.point - UserDefaultManager.shared.unlockPoint
        UserDefaultManager.shared.unlockPoint += 10
    }
}

// MARK: - PointPresenterProtocol

extension PointPresenter: PointPresenterProtocol {
    
    func getNeedPoint() -> Int {
        return UserDefaultManager.shared.unlockPoint
    }
    
    /// UserDefaltsに選択されたカラーを保存
    /// - Parameter index: index
    func selectColor(_ index: Int) {
        var count = 0
        var colorName = ""
        
        for_color: for color in ColorManager.ThemeType.allCases {
            colorName = color.rawValue
            if count == index {
                break for_color
            }
            count += 1
        }

        UserDefaultManager.shared.color = colorName
    }
    
    /// セルのカラーを取得
    /// - Parameter index: index
    func getPointCollectionCellColor(_ index: Int) -> UIColor {
        var count = 0
        var themeColor: UIColor = .gray
        
        for_color: for color in ColorManager.ThemeType.allCases {
            if count == index {
                themeColor = ColorManager.singletonColorManager.colorGet(color)
                break for_color
            }
            count += 1
        }
        
        return themeColor
    }
    
    /// セルのカラー名を取得
    /// - Parameter index: index
    func getPointCollectionCellString(_ index: Int) -> String {
        var count = 0
        var colorName = ""
        
        for_color: for color in ColorManager.ThemeType.allCases {
            if count == index {
                colorName = color.rawValue
                break for_color
            }
            count += 1
        }
        
        return colorName
    }
    
    /// 選択された色に変更するかどうかアラートを出す
    /// - Parameter index: index
    func alartChangeColor(_ index: Int) {
        
        let colorName = self.getPointCollectionCellString(index)
        
        self.pointAlertController = UIAlertController(title: "確認",
                                            message: "\(colorName)に変更しますか？",
                                            preferredStyle: .alert)
        self.pointAlertController.addAction(UIAlertAction(title: "YES",
                                                style: .default,
                                                handler: {(action: UIAlertAction!) -> Void in
                                                    self.selectColor(index)
                                                    self.view?.trancePointExchangeColor()
                                                   
        }))
        self.pointAlertController.addAction(UIAlertAction(title: "NO",
                                                style: .default,
                                                handler: nil
        ))
        
        self.view?.displayAlart(pointAlertController)
    }
    
    /// テーマカラーをアンロックするかアラートを出す
    /// - Parameter index: index
    func alartUnlockColor(_ index: Int) {
        
        let colorName = self.getPointCollectionCellString(index)
        let flag = self.getLockIconFrag(index)
        
        // 未アンロックの時
        if !flag {   // falg = falseで未アンロック
            // ポイントが足りない場合
            if UserDefaultManager.shared.point < UserDefaultManager.shared.unlockPoint {
                self.pointAlertController = UIAlertController(title: "ポイントが足りません",
                                                              message: "",
                                                              preferredStyle: .alert)
                self.pointAlertController.addAction(UIAlertAction(title: "OK",
                                                                  style: .default,
                                                                  handler: nil
                ))
            } else {    // ポイントが足りる場合
                self.pointAlertController = UIAlertController(title: "確認",
                                                              message: "\(colorName)をアンロックしますか？",
                    preferredStyle: .alert)
                self.pointAlertController.addAction(UIAlertAction(title: "YES",
                                                                  style: .default,
                                                                  handler: {(action: UIAlertAction!) -> Void in
                                                                    self.redeemPoints()
                                                                    try! self.realmAccessor.saveUnlockUserColorObject(id: 0, color: colorName)
                                                                    self.selectColor(index)
                                                                    self.view?.trancePointExchangeColor()
                }))
                self.pointAlertController.addAction(UIAlertAction(title: "NO",
                                                                  style: .default,
                                                                  handler: nil
                ))
            }
            self.view?.displayAlart(pointAlertController)
        } else {    // アンロック済の時
            self.alartChangeColor(index)
        }
    }
    
    func getLockIconFrag(_ index: Int) -> Bool {
     
        let colorNameString = self.getPointCollectionCellString(index)
        let iconFragArray = try! self.realmAccessor.getUserColor()
        var OptinalconFrag: Bool?
        var count = 0
        
        for_colorName: for colorName in ColorManager.ThemeType.allCases {
            if colorNameString == colorName.rawValue {
                switch count {
                case 0:
                    OptinalconFrag = iconFragArray[0].defalt
                    break for_colorName
                case 1:
                    OptinalconFrag = iconFragArray[0].red
                    break for_colorName
                case 2:
                    OptinalconFrag = iconFragArray[0].blue
                    break for_colorName
                case 3:
                    OptinalconFrag = iconFragArray[0].yellow
                    break for_colorName
                case 4:
                    OptinalconFrag = iconFragArray[0].green
                    break for_colorName
                case 5:
                    OptinalconFrag = iconFragArray[0].orange
                    break for_colorName
                case 6:
                    OptinalconFrag = iconFragArray[0].pink
                    break for_colorName
                case 7:
                    OptinalconFrag = iconFragArray[0].violet
                    break for_colorName
                default:
                    return false
                }
            }
            count += 1
        }
        
        if let iconFrag = OptinalconFrag {
            return iconFrag
        } else {
            return false
        }
    }
}
