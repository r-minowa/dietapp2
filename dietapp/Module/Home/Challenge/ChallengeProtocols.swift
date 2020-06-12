//
//  ChallengeProtocols.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/05/20.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

protocol ChallengeViewProtocol: AnyObject {
    var presenter: ChallengePresenterProtocol? { get }
    
    func reloadData(challenges: [Training])
    func getCalenderTabDate() -> Date 
    func whetherSelectTableView(_ bool: Bool)
    func transitionToContent(challenge: Training, level: Training.Level, index: Int)
}

protocol ChallengePresenterProtocol {
    var view: ChallengeViewProtocol? { get }
    func viewWillAppear()
    func selectedChallenge(_ calenderDate: Date)
    func didSelectCell(at index: Int)
    func setCellChallenge(_ selectedChallenge: [Training]) -> Training
    func getLevel() -> Training.Level
    func getChallengeID() -> Int
    func getChallengeBool(_ index: Int) -> Bool
}
