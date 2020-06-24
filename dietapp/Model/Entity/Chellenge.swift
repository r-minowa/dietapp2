//
//  Chellenge.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/05/20.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

struct Training {
    
    enum TrainingMenu: String, CaseIterable {
        case pushUp = "腕立て"
        case alternateFrontLunge = "オルタネイトフロントランジ"
        case crunch = "クランチ"
        case sideBridge = "サイドブリッジ"
        case squat = "スクワット"
        case twistCrunch = "ツイストクランチ"
        case spine = "背筋"
        case highReversePlank = "ハイリバースプランク"
        case palmCurl = "パームカール"
        case hipAbduction = "ヒップアブダクション"
        case hipLift = "ヒップリフト"
        case abs = "腹筋"
        case plank = "プランク"
        case legRaises = "レッグレイズ"
    }
    
   // 部位
    enum Parts: String, CaseIterable {
       case hip = "お尻"
       case belly = "お腹"
//       case calf = "ふくらはぎ"
       case thigh = "太もも"
       case waist = "腰"
       case breast = "胸"
       case arm = "腕"
       case back = "背中"
//       case innerMuscle = "インナーマッスル"　レッグレイズ
    }
   
   // 難易度
    enum Level: String, CaseIterable {
        case low
        case mid
        case high
    }
    
   // 詳細
    struct Details {
        let level: Level       // 難易度
        let countOfSets: Int   // セット数
        let secOfSets: Int     // 1セットの秒数
        let standardNum: Int   // 標準的な回数
    }
   
    let name: TrainingMenu     // トレーニング名
    let explanation: String    // 説明
    let parts: [Parts]         // 部位
    let details: [Details]     // 詳細
    
   
   /// Initialize
   /// - Parameter name: トレーニング名
   /// - Parameter partsList: 鍛えられる部位
   /// - Parameter detailsList: 詳細(難易度、セット数、秒数、標準回数)
    init(name: TrainingMenu, explanation: String,  partsList:[Parts], detailsList:[Details]) {
        self.name = name
        self.explanation = explanation
        self.parts = partsList
        self.details = detailsList
    }
}

class Trainings {
    var trainings: [Training] = []
    
    init() {
        
        let abs = Training(
            name: .abs,
            explanation: "腹筋",
            partsList:[.belly],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 1,
                    secOfSets: 5,
                    standardNum: 10
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 2,
                    secOfSets: 20,
                    standardNum: 15
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 3,
                    secOfSets: 20,
                    standardNum: 20
                )
            ]
        )
        
        let plank = Training(
            name: .plank,
            explanation: "四つん這いになりましょう。\n↓\n肘から手首まで（前腕）を地面に着けましょう。\n↓\n膝を上げ、前腕と足で身体を支えましょう。\n↓\n上と横から見たときに、頭から足までがまっすぐになるように姿勢を保ちましょう。",
            partsList:[.hip, .belly],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 1,
                    secOfSets: 20,
                    standardNum: 1
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 2,
                    secOfSets: 20,
                    standardNum: 1
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 3,
                    secOfSets: 20,
                    standardNum: 1
                )
            ]
        )
        
        let highReversePlank = Training(
            name: .highReversePlank,
            explanation: "ハイリバースプランク",
            partsList:[.back, .belly, .thigh],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 1,
                    secOfSets: 20,
                    standardNum: 1
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 2,
                    secOfSets: 20,
                    standardNum: 1
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 3,
                    secOfSets: 20,
                    standardNum: 1
                )
            ]
        )
        
        let squat = Training(
            name: .squat,
            explanation: "スクワット",
            partsList:[.hip, .thigh, .back, .waist],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 1,
                    secOfSets: 20,
                    standardNum: 10
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 2,
                    secOfSets: 20,
                    standardNum: 10
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 3,
                    secOfSets: 30,
                    standardNum: 15
                )
            ]
        )
        
        let crunch = Training(
            name: .crunch,
            explanation: "クランチ",
            partsList:[.belly],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 1,
                    secOfSets: 20,
                    standardNum: 10
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 3,
                    secOfSets: 20,
                    standardNum: 10
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 3,
                    secOfSets: 40,
                    standardNum: 20
                )
            ]
        )
        
        let twistCrunch = Training(
            name: .twistCrunch,
            explanation: "ツイストクランチ",
            partsList:[.belly, .waist],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 1,
                    secOfSets: 20,
                    standardNum: 10
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 3,
                    secOfSets: 20,
                    standardNum: 10
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 3,
                    secOfSets: 40,
                    standardNum: 20
                )
            ]
        )
        
        let pushUp = Training(
            name: .pushUp,
            explanation: "腕立て",
            partsList:[.breast, .arm],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 1,
                    secOfSets: 20,
                    standardNum: 10
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 3,
                    secOfSets: 30,
                    standardNum: 15
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 3,
                    secOfSets: 60,
                    standardNum: 30
                )
            ]
        )
        
        let legRaises = Training(
            name: .legRaises,
            explanation: "レッグレイズ",
            partsList:[.belly, .thigh],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 1,
                    secOfSets: 20,
                    standardNum: 10
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 3,
                    secOfSets: 20,
                    standardNum: 10
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 3,
                    secOfSets: 60,
                    standardNum: 30
                )
            ]
        )
        
        let hipLift = Training(
            name: .hipLift,
            explanation: "ヒップリフト",
            partsList:[.hip, .back],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 1,
                    secOfSets: 20,
                    standardNum: 10
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 3,
                    secOfSets: 20,
                    standardNum: 10
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 3,
                    secOfSets: 60,
                    standardNum: 30
                )
            ]
        )
        
        let spine = Training(
            name: .spine,
            explanation: "背筋",
            partsList:[.back],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 1,
                    secOfSets: 20,
                    standardNum: 10
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 3,
                    secOfSets: 20,
                    standardNum: 10
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 3,
                    secOfSets: 60,
                    standardNum: 30
                )
            ]
        )
        
        let  hipAbduction = Training(
            name: .hipAbduction,
            explanation: "ヒップアブダクション 左右",
            partsList:[.hip, .thigh],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 2,
                    secOfSets: 40,
                    standardNum: 20
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 4,
                    secOfSets: 60,
                    standardNum: 30
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 6,
                    secOfSets: 60,
                    standardNum: 30
                )
            ]
        )
        
        let  alternateFrontLunge = Training(
            name: .alternateFrontLunge,
            explanation: "オルタネイトフロントランジ　左右",
            partsList:[.hip, .thigh],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 2,
                    secOfSets: 20,
                    standardNum: 10
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 6,
                    secOfSets: 20,
                    standardNum: 10
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 6,
                    secOfSets: 40,
                    standardNum: 20
                )
            ]
        )
        
        let  sideBridge = Training(
            name: .sideBridge,
            explanation: "サイドブリッジ　左右",
            partsList:[.waist],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 2,
                    secOfSets: 30,
                    standardNum: 1
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 6,
                    secOfSets: 30,
                    standardNum: 1
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 6,
                    secOfSets: 60,
                    standardNum: 1
                )
            ]
        )
        
        let  palmCurl = Training(
            name: .palmCurl,
            explanation: "パームカール　左右",
            partsList:[.arm],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 2,
                    secOfSets: 30,
                    standardNum: 1
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 6,
                    secOfSets: 30,
                    standardNum: 1
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 6,
                    secOfSets: 60,
                    standardNum: 1
                )
            ]
        )
        
        trainings.append(abs)
        trainings.append(plank)
        trainings.append(highReversePlank)
        trainings.append(squat)
        trainings.append(crunch)
        trainings.append(twistCrunch)
        trainings.append(pushUp)
        trainings.append(legRaises)
        trainings.append(hipLift)
        trainings.append(spine)
        trainings.append(hipAbduction)
        trainings.append(alternateFrontLunge)
        trainings.append(sideBridge)
        trainings.append(palmCurl)
    }
}


/*        // メモ mapに関して
       var partsStrs:[String] = []
       for parts in partsList {
           partsStrs.append(parts.rawValue)
       }
       self.partsStr = partsStrs
*/
