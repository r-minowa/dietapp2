//
//  PopupPresenter.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/05/27.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation
import SwiftDate

final class PopupPresenter {
    
    private(set) weak var view: PopupViewProtocol?
    private let realmAccessor: RealmAccessorProtocol
    
    var selectedPosition: Training.Parts = .hip
    var selectedLevel: Training.Level = .low
    var selectedPositionStr: String = "尻"
    var selectedLevelStr: String = "low"
    var partsStr: [String] = []
    
    var challenge: Trainings = Trainings.init()
    var selectedChallenges: [Training] = []
    var randomName: [String] = []
    var progressFlag: [Bool] = []
    var NumOfChallenges = 3
    
    // Initialize
    
    init(view: PopupViewProtocol, realmAccessor: RealmAccessorProtocol) {
        self.view = view
        self.realmAccessor = realmAccessor
    }
    
    // MARK: - PrivateMethod
    
    // ランダム抽出(3つ)
    func getRandom(cnt:Int)->Int{
            //0からランダムの取得なります。
            var result:Int
            result = Int(arc4random() % UInt32(cnt))
            return result
    }
    func randomSet(cInt:Int) -> [Int]{//cIntの数だけランダムに取り出す
        var mondaiList: [Int] = []
        var returnList: [Int] = []
        var result = 0
        var checkCount = 0
        
        for _ in 0..<NumOfChallenges {
            returnList += [0]
        }
        
        while mondaiList.count <= cInt {
            checkCount = 0
            result = getRandom(cnt: cInt)
            if mondaiList.count >= cInt
            { break }
            if mondaiList.count != 0{
                for i in mondaiList {
                    if i == result {
                        checkCount += 1
                    }
                }//for
                //全体のループが終わってから重複が無いことを確認してappendする
                if checkCount == 0{
                    mondaiList.append(result)
                    if mondaiList.count >= cInt{
                        break
                    }
                }
            }else{
                mondaiList.append(result)
            }//if
        }//while
        
        // 重複していない最初の3つを返す配列に入れる
        for i in 0..<NumOfChallenges {
            returnList[i] = mondaiList[i]
        }
        
        return returnList
    }
    
}

// MARK: - PopupPresenterProtocol

extension PopupPresenter: PopupPresenterProtocol {
    
    func viewWillAppear() {
    }
    
    /// String型部位の取得
    func getPartsStr() -> [String] {
        // partsStrに全ての部位を入れる
        for part in Training.Parts.allCases {
            partsStr.append(part.rawValue)
        }
        
        return partsStr
    }
    
    /// セグメントで選ばれたレベルの取得
    /// - Parameter segmentIndex: 選ばれたレベル
    func selectLevelSegment(_ segmentIndex: Int) {
        //セグメント番号で条件分岐させる
        switch segmentIndex {
        case 0:
            selectedLevelStr = Training.Level.low.rawValue
        case 1:
            selectedLevelStr = Training.Level.mid.rawValue
        case 2:
            selectedLevelStr = Training.Level.high.rawValue
        default:
            print("該当無し")
        }
    }
    
    /// チャレンジ名をRealmに保存する型に変更、保存
    func convertChallengeRealmType() {
        
        var day = Date()
        
        for _ in 0..<3 {
            progressFlag.append(false)
        }
        
        // 難易度と部位を元の型に変換する
        for level in Training.Level.allCases {
            if level.rawValue ==  selectedLevelStr {
                selectedLevel = level
            }
        }
        for part in Training.Parts.allCases {
            if part.rawValue == selectedPositionStr {
                selectedPosition = part
            }
        }
        
        self.selectedChallenges = self.challenge.trainings.filter{ $0.parts.contains(selectedPosition)}
             
        var judgweek = Date()
        var count = 0
        
        for _ in 0..<10 {
            if !judgweek.isInWeekend {
                judgweek = Calendar.current.date(byAdding: .day, value: 1, to: judgweek)!
                count += 1
                
            } else {
                count += 1
                break
            }
        }
        
        for _ in 0..<count {
            let randomArray = randomSet(cInt: selectedChallenges.count)
            for i in 0..<NumOfChallenges {
                randomName.append(selectedChallenges[randomArray[i]].name.rawValue)
            }
            
            self.saveUserTrainingRealm(day)
            day = Calendar.current.date(byAdding: .day, value: 1, to: day)!
            randomName.removeAll()
        }
        
        self.progressFlag.removeAll()
    }
    
    /// 選択された部位をString型で保存
    /// - Parameter part: 選択された部位
    func setSelectedPositionStr(_ part: String) {
        self.selectedPositionStr = part
    }
    
    /// UserTrainingに保存する
    /// - Parameter day: 日付
    func saveUserTrainingRealm(_ day: Date) {
        do {
            let id = try self.realmAccessor.getNewUserTrainingId()
            try self.realmAccessor.saveUserTraining(id: id,
                                                    difficulty: selectedLevelStr,
                                                    bodyParts: selectedPositionStr,
                                                    dayTraining: randomName,
                                                    date: day,
                                                    flag: progressFlag
            )
        } catch {
            print("DEBUG_PRINT: NewID取得エラー")
        }
    }
}

