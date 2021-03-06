//
//  PopupProtocols.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/05/27.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

protocol PopupViewProtocol: AnyObject {
    var presenter: PopupPresenterProtocol? { get }
    
    func displayPopupAlart(_ alart: UIAlertController)
    func dismissPopUp()
}

protocol PopupPresenterProtocol: AnyObject {
    var view: PopupViewProtocol? { get }
    
    func viewWillAppear()
    func getPartsStr() -> [String]
    func selectLevelSegment(_ segmentIndex: Int)
    func convertChallengeRealmType()
    func setSelectedPositionStr(_ part: String)
    func selectDecisionButton(_ flag: Bool)
    func settingAlartOfTargetWeight()
}
