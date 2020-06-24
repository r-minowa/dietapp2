//
//  DistanceSettingProtocol.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/22.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

protocol DistanceSettingViewProtocol: AnyObject {
    var presenter: DistanceSettingPresenterProtocol? { get }
    
    func setSteps(_ steps: NSNumber)
    func displayStepsAlart(_ alart: UIAlertController)
}

protocol DistanceSettingPresenterProtocol {
    var view: DistanceSettingViewProtocol? { get }
    
    func getTargetSteps() -> Int
    func getSteps()
    func getStepsTextLabelString() -> String
}
