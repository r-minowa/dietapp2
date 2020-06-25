//
//  InputPopupPresenter.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/25.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

final class InputPopupPresenter {
    
    private(set) weak var view: InputPopupViewProtocol?
    private let realmAccessor: RealmAccessorProtocol
    
    private var inputPopupAlertController: UIAlertController!
    
    private var trainingName: String = ""
    private var count: String = ""
    private var weight: String = ""
    private var date = Date()
    
    // Initialize
    init(view: InputPopupViewProtocol, realmAccessor: RealmAccessorProtocol) {
        self.view = view
        self.realmAccessor = realmAccessor
    }
    
    // MARK: - PrivateMethod
    
    /// トレーニング回数の保存
    func recordAvtivityCount() {
        var countInt: Int = 0
        
        // 数字かどうか判別する
        if count.isNumber {
            if let countInt_ = Int(count) {
                countInt = countInt_
            }
        } else {
            self.setInputPopupAlart(title: "保存失敗しました", message: "数字を入力してください")
        }
        
        // 入力回数が0以上のとき
        if countInt > 0 {
            do {
                let id = try self.realmAccessor.getNewActivityId()
                try self.realmAccessor.saveActivityCount(id: id,
                                                         name: self.trainingName,
                                                         count: countInt,
                                                         date: self.date)
                self.view?.dismissInputPopup()
            } catch {
                print("DEBUG_PRINT: NewID取得エラー")
            }
        } else {
            self.setInputPopupAlart(title: "保存失敗しました", message: "0回以上の回数を入力してください")
        }
        
    }
    
    /// 体重の保存
    func recordBodyWeight() {
        var weightDouble: Double = 0
        
        if self.weight.isNumber {
            if let weightDouble_ = Double(self.weight) {
                weightDouble = weightDouble_
            }
        }else {
            self.setInputPopupAlart(title: "保存に失敗しました", message: "体重を入力してください")
        }
        
        if weightDouble > 0.0 {
            do {
                let id = try self.realmAccessor.getNewUserInfoId()
                try self.realmAccessor.saveUserInfo(id: id,
                                                    weight: weightDouble,
                                                    date: self.date
                )
                
                self.view?.dismissInputPopup()
            } catch {
                print("DEBUG_PRINT: NewID取得エラー")
            }
        } else {
            self.setInputPopupAlart(title: "保存に失敗しました", message: "体重を入力してください")
        }
    }
    
    /// 目標体重の保存
    func recordSettingTargetWeight() {
        var targetWeight: Double = 0
        
        if self.weight.isNumber {
            if let weightDouble_ = Double(self.weight) {
                targetWeight = weightDouble_
            }
        }else {
            self.setInputPopupAlart(title: "保存に失敗しました", message: "体重を入力してください")
        }
        
        if targetWeight > 0.0 {
            UserDefaultManager.shared.targetWeight = targetWeight
            self.view?.dismissInputPopup()
        
        } else {
            self.setInputPopupAlart(title: "保存に失敗しました", message: "体重を入力してください")
        }
    }
    
    /// アラート設定
    /// - Parameter title: タイトル
    /// - Parameter message: メッセージ
    func setInputPopupAlart(title: String, message: String) {
        self.inputPopupAlertController = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .alert)
        self.inputPopupAlertController.addAction(UIAlertAction(title: "OK",
                                                style: .default,
                                                handler: nil
        ))
        
        self.view?.displayInputPopupAlart(alart: self.inputPopupAlertController)
    }
}

// MARK: - InputPopupPresenterProtocol

extension InputPopupPresenter: InputPopupPresenterProtocol {
    
    /// 遷移前ViewContorollerからのデータを取得
    /// - Parameter trainingName: トレーニング名
    /// - Parameter date: 日付
    func setDate(trainingName: String, date: Date) {
        self.trainingName = trainingName
        self.date = date
    }
    
    /// titleNameにより保存先を指定
    /// - Parameter titleName: 保存先指定名
    /// - Parameter textFieldString:  TextFieldの文字列
    func selectInputView(titleName: String, textFieldString: String) {
        if titleName == "回数" {
            self.count = textFieldString
            self.recordAvtivityCount()
        } else if titleName == "体重" {
            self.weight = textFieldString
            self.recordBodyWeight()
        } else if titleName == "目標体重" {
            self.weight = textFieldString
            self.recordSettingTargetWeight()
        }
    }
}
