//
//  DistanceSettingPresenter.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/22.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit
import SwiftDate
import CoreMotion

final class DistanceSettingPresenter {
    
    private(set) weak var view: DistanceSettingViewProtocol?
    
    private var stepsAlertController: UIAlertController!
    
    let pedometer = CMPedometer()
    let targetStep: Int = 5000
    
    // Initialize
    init(view: DistanceSettingViewProtocol) {
        self.view = view
    }
    
    // MARK: - PrivateMethod
    
    
    // MARK: -フラグの変更
    /// 設定された目標歩数に達したかどうか
    /// - Parameter steps: 歩数
    func judgTargetStep(_ steps: NSNumber) {
        if self.targetStep >= steps.intValue {
             self.view?.setSteps(steps)
        } else {
            let achieveTargetStep: NSNumber = NSNumber(value: self.targetStep)
            self.view?.setSteps(achieveTargetStep)
            
            // 今日アラートを表示したかどうか
            if !UserDefaultManager.shared.isShowStepsAlart {
                UserDefaultManager.shared.point += 3
                UserDefaultManager.shared.isShowStepsAlart = true
                self.setStepAlart(title: "Congraturation!!!", message: "おめでとう！3Pointゲット！")
            }
        }
    }
    
    /// Stepアラート設定
    /// - Parameter title: タイトル
    /// - Parameter message: メッセージ
    func setStepAlart(title: String, message: String) {
        self.stepsAlertController = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .alert)
        self.stepsAlertController.addAction(UIAlertAction(title: "Point Get",
                                                style: .default,
                                                handler: nil
        ))
        
        self.view?.displayStepsAlart(self.stepsAlertController)
    }
}

// MARK: - DistanceSettingPresenterProtocol

extension DistanceSettingPresenter: DistanceSettingPresenterProtocol {
    
    func getTargetSteps() -> Int {
        return self.targetStep
    }
    
    func getSteps(){
        let today = Date()
                
        if(CMPedometer.isStepCountingAvailable()){
            self.pedometer.queryPedometerData(from: today.dateAtStartOf(.day), to: today.dateAtEndOf(.day)) { (data, error) in
                if(error == nil){
                    if let unwarSteps = data?.numberOfSteps {
                        self.judgTargetStep(unwarSteps)
                    }
                }
            }
        }
    }
    
    func getStepsTextLabelString() -> String {
        
        print(UserDefaultManager.shared.isShowStepsAlart)
        
        if UserDefaultManager.shared.isShowStepsAlart {
            return "今日の目標達成！\n明日も\(targetStep)歩目指して頑張ろう！"
        } else {
            return "毎日5000歩を目標に歩きましょう！"
        }
    }
}
