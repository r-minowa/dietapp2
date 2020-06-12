//
//  ChallengePresenter.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/05/20.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

final class ChallengePresenter {
    
    private(set) weak var view: ChallengeViewProtocol?
    private let realmAccessor: RealmAccessorProtocol
    
    //　チャレンジに関連する変数
    var selectedPosition: Training.Parts = .belly
    var selectedLevel: Training.Level = .low
    var challenge: Trainings = Trainings.init()
    var selectedChallenges: [Training] = []
    var selectedChallengesStr: [GetRealmChallenge] = []
    var count: Int = 0
    
    var today = Date()
    
    // MARK: - Initialize
    
    init(view: ChallengeViewProtocol, realmAccessor: RealmAccessorProtocol) {
        self.view = view
        self.realmAccessor = realmAccessor
    }
}

// MARK: - ChallengeViewProtocol

extension ChallengePresenter: ChallengePresenterProtocol {
    
    func viewWillAppear() {
        guard let calenderDate = self.view?.getCalenderTabDate() else { return }
        
        let calenderDateString = DateFormatters.customDateFormatter.string(from: calenderDate)
        let todayDateString = DateFormatters.customDateFormatter.string(from: today)
        
        if calenderDateString != todayDateString {
            self.view?.whetherSelectTableView(false)
        }
    }
    
    /// レベル・部位・日付に応じたチャレンジの配列生成
    func selectedChallenge(_ calenderDate: Date) {
        try! self.selectedChallengesStr = self.realmAccessor.getChallenge(date: calenderDate)
        
        if selectedChallengesStr != [] {
            if let dayTraining = selectedChallengesStr[selectedChallengesStr.count - 1].dayTraining,
                let difficulty = selectedChallengesStr[selectedChallengesStr.count - 1].difficulty {
                
                self.selectedChallenges = []
                // Realm上のレベルの取得
                let levelStr = difficulty
                for level in Training.Level.allCases {
                    if levelStr == level.rawValue {
                        self.selectedLevel = level
                        break
                    }
                }
                
                // Realm上のトレーニング名からトレーニング内容を取得
                for realmTrainingNameIndex in 0..<dayTraining.count {   // レルムからの名前を三つで回す
                    let training_ = dayTraining[realmTrainingNameIndex] // その中の一つをとる
                    for TrainingName in Training.TrainingMenu.allCases {    // 記録されたトレーニング名データをすべて回す
                        if training_ == TrainingName.rawValue { // もしレルムのやつと記録のやつが一緒なら
                            let selectedChallenge = challenge.trainings.filter{ $0.name == TrainingName }
                            self.selectedChallenges += selectedChallenge
                        }
                    }
                }
            }
            
            self.view?.reloadData(challenges: self.selectedChallenges)
        }
    }
    
    /// cellが選択せされたとき
    /// - Parameter index: Int
    func didSelectCell(at index: Int) {
        self.view?.transitionToContent(challenge: self.selectedChallenges[index], level:  self.selectedLevel, index: index)
    }
    
    /// cellにチャレンジをセットする
    /// - Parameter selectedChallenge: 選択されたチャレンジ内容
    func setCellChallenge(_ selectedChallenge: [Training]) -> Training {
        
        let challenge_ = selectedChallenges[count]
        
        // cellとチャレンジの内容を合致させる
        count += 1
        if count > selectedChallenges.count - 1 {
            count = 0
        }
        
        return challenge_
    }
    
    /// レベルを取得する
    func getLevel() -> Training.Level {
        return selectedLevel
    }
    
    /// IDを取得する
    func getChallengeID() -> Int {
        var ID = 0
        if let id = selectedChallengesStr[0].id {
            ID = id
        }
        return ID
    }
    
    func getChallengeBool(_ index: Int) -> Bool {
        var challengeBool: Bool = false
        
        guard let calenderDate = self.view?.getCalenderTabDate() else { return true }
        try! self.selectedChallengesStr = self.realmAccessor.getChallenge(date: calenderDate)
        
        if let bool = selectedChallengesStr[0].progressFlag?[index] {
            challengeBool = bool
        }
        
        return challengeBool
    }
}
