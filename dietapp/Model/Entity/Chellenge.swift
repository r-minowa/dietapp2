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
        case alternateFrontLunge = "オルタネイトフロントランジ"
        case crunch = "クランチ"
        case sideBridge = "サイドブリッジ"
        case squat = "スクワット"
        case twistCrunch = "ツイストクランチ"
        case narrowPushUp = "ナロープッシュアップ"
        case spine = "背筋"
        case pikePress = "パイクプレス"
        case highReversePlank = "ハイリバースプランク"
        case palmCurl = "パームカール"
        case hipAbduction = "ヒップアブダクション"
        case hipLift = "ヒップリフト"
        case hinduPushuUp = "ヒンズープッシュアップ"
        case abs = "腹筋"
        case plank = "プランク"
        case legRaises = "レッグレイズ"
        case pushUp = "ワイドプッシュアップ"
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
            explanation: /*"1.仰向けになり、ひざを立てる\n2.ゆっくり息を吐きながら上半身を持ち上げる\n\n○ポイント\n勢いや反動をつけずに、ゆっくりと腹筋を意識しましょう！*/"vLpBZ9y3YDo",
            partsList:[.belly],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 2,
                    secOfSets: 20,
                    standardNum: 10
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 3,
                    secOfSets: 40,
                    standardNum: 20
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 3,
                    secOfSets: 60,
                    standardNum: 30
                )
            ]
        )
        
        let plank = Training(
            name: .plank,
            explanation: /*"1.床の上にうつ伏せになる\n2.腕を肩幅ほど開き、上半身を上げる(腕の角度90度)\n3.つま先と腕で体のバランスを取る\n4.前を向き、首筋から足まで真っ直ぐにする\n\n○ポイント\n一直線の姿勢を意識しましょう！*/"wst2Kw_5pvY",
            partsList:[.hip, .belly],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 2,
                    secOfSets: 20,
                    standardNum: 1
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 3,
                    secOfSets: 30,
                    standardNum: 1
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 5,
                    secOfSets: 30,
                    standardNum: 1
                )
            ]
        )
        
        let highReversePlank = Training(
            name: .highReversePlank,
            explanation: /*"1.仰向けになる\n2.手のひらを地面につけ、体を持ち上げる\n3.(2)の時、手のひらが肩の真下に来るようにする\n4.足から頭まで一直線にする\n5.この状態をキープする*/"GKYIcwI3sEo",
            partsList:[.back, .belly, .thigh],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 2,
                    secOfSets: 30,
                    standardNum: 1
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 3,
                    secOfSets: 50,
                    standardNum: 1
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 3,
                    secOfSets: 100,
                    standardNum: 1
                )
            ]
        )
        
        let squat = Training(
            name: .squat,
            explanation: /*"1.肩幅ほど足を広げて立つ\n2.背筋をピンと伸ばす\n3.足先を少し外側に向ける\n4.息を吸いつつゆっくり体を下げる\n5.床と太ももを平行にし、2秒間キープ\n6.息を吐きつつ姿勢をゆっくり元に戻す"*/"c-Tu8lAna2g",
            partsList:[.hip, .thigh, .back, .waist],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 2,
                    secOfSets: 40,
                    standardNum: 10
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 3,
                    secOfSets: 80,
                    standardNum: 20
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 3,
                    secOfSets: 120,
                    standardNum: 30
                )
            ]
        )
        
        let crunch = Training(
            name: .crunch,
            explanation: /*"1.仰向けになる\n2.膝と股関節を90°に曲げる\n3.手を頭の後ろで組む\n4.おへそをのぞきこむように、息を吐きながら肩甲骨が床から浮く程度まで上げる\n5.頭が地面に着くギリギリまで下ろす\n6.(4)(5)を繰り返す*/"nZpzkSHUeLM",
            partsList:[.belly],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 2,
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
        
        let twistCrunch = Training(
            name: .twistCrunch,
            explanation: /*"※左右行います\n\n1.仰向けで寝る\n2.右足の膝を90度に立たせる\n3.左手は頭の後ろに固定させる\n4.右足を上げて、太ももが床と垂直になる姿勢にする\n5.(4)の時、膝を90度に固定させておく\n6.体を内側にひねりつつ上体を起こし、右の膝と左手がくっつくまで近づける\n7.(6)の状態で少しの間キープする\n8.反動を使わずゆっくり元の状態に戻す*/"PoYyrA9LwSQ",
            partsList:[.belly, .waist],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 2,
                    secOfSets: 30,
                    standardNum: 10
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 4,
                    secOfSets: 30,
                    standardNum: 10
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 6,
                    secOfSets: 60,
                    standardNum: 20
                )
            ]
        )
        
        let pushUp = Training(
            name: .pushUp,
            explanation: /*"1.四つん這いの状態になる\n2.肩幅よりも少し広めに手をつく\n3.足を伸ばしつま先を立て、頭から足首まで真っ直ぐにする\n4.脇を締めて肘を曲げ、体を床に着くギリギリまでゆっくり下ろす\n5.床を押して肘を伸ばし、体を持ち上げる\n6.(4)(5)を繰り返す*/"BiC2rzPBUjY",
            partsList:[.breast, .arm],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 2,
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
            explanation: /*"1.仰向けになる\n2.両足を床から10センチほどの位置でキープする\n3.息を吐きながら足を上げる\n4.45度を超えない程度で5秒停止する\n5.息を吸いながら下げる*/"FrodXXrzzc0",
            partsList:[.belly, .thigh],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 3,
                    secOfSets: 50,
                    standardNum: 10
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 3,
                    secOfSets: 75,
                    standardNum: 15
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 5,
                    secOfSets: 100,
                    standardNum: 20
                )
            ]
        )
        
        let hipLift = Training(
            name: .hipLift,
            explanation: /*"1.仰向けになる\n2.膝を90度曲げて脚を立てる\n3.膝から頭まで一直線になるまでお尻をゆっくりと上げる\n4.2秒間キープする\n5.ゆっくり元に戻す*/"AcjAg-K2Gyw",
            partsList:[.hip, .back],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 3,
                    secOfSets: 40,
                    standardNum: 10
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 3,
                    secOfSets: 60,
                    standardNum: 15
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 5,
                    secOfSets: 100,
                    standardNum: 25
                )
            ]
        )
        
        let spine = Training(
            name: .spine,
            explanation: /*"1.うつ伏せになる\n2.両手の指先を耳に添え、肘は横に伸ばした状態を作る\n3.両足と胸をゆっくりと上に上げる\n4.(3)の時、上半身ばかり上げすぎないよう注意\n5.背筋が刺激されているのを感じたら1秒キープする\n6.その後ゆっくり元に戻す*/"bZdwZo4_39Q",
            partsList:[.back, .waist],
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
            explanation: /*"※左右行います\n\n1.横向きで寝る\n2.床に付いている方の足の膝を、軽く曲げる\n3.手は床について、上半身のバランスを取る\n4.上側の足を伸ばして、ゆっくり上に上げる\n5.限界まで上げたら、ゆっくり元に戻す\n6.(4)(5)を繰り返す*/"1RXjzNjqFWY",
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
            explanation: /*"\n1.腰幅に足を開き、つま先は正面を向ける\n2.お腹に力を入れ、胸を張る\n3.右足を前に出し、太ももと床が水平になるようにする\n4.右足を元の位置に戻す\n5.左足も同様に行う\n6.(3)(4)(5)を繰り返す*/"uqVCNFERT_U",
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
                    countOfSets: 3,
                    secOfSets: 60,
                    standardNum: 30
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 3,
                    secOfSets: 100,
                    standardNum: 50
                )
            ]
        )
        
        let  sideBridge = Training(
            name: .sideBridge,
            explanation: /*"※左右行います\n1.横向きになる\n2.肘を肩の真下に置き、90度に曲げる\n3.腰を浮かせ、頭から足先まで一直線にする\n4.その姿勢をキープする*/"iFv_yK0v9T4",
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
            explanation: /*"※左右行います\n\n(右腕の場合)\n1.左手のひらで右手首を掴み下へ押す\n2.左手に逆らうよう肘から上を持ち上げる\n3.持ち上げたら同じ軌道で下ろす\n4.(3)(4)を繰り返す\n\n○ポイント\n4秒で上げ、1秒静止し、4秒で下ろすように意識しましょう！*/"kWWaSImM0Uo",
            partsList:[.arm],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 4,
                    secOfSets: 50,
                    standardNum: 5
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 6,
                    secOfSets: 70,
                    standardNum: 7
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 6,
                    secOfSets: 100,
                    standardNum: 10
                )
            ]
        )
        
        let  hinduPushuUp = Training(
            name: .hinduPushuUp,
            explanation: /*"1.肩幅からこぶし2つ分外に開き、両手を地面に付ける\n2.肩と同じ足幅にする\n3.お尻を高く持ち上げ、お尻から腕まで一直線にする\n4.地面スレスレまで上半身を下ろす\n5.円を描くように体を回し元の姿勢に戻る*/"JzpcyQY5otM",
            partsList:[.belly, .arm, .back, .breast],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 2,
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
                    countOfSets: 4,
                    secOfSets: 30,
                    standardNum: 15
                )
            ]
        )
        
        let  pikePress = Training(
            name: .pikePress,
            explanation: /*"1.四つん這いの姿勢になる\n2.膝を浮かせ、両手両足で体を支える\n3.足と手の幅を狭くする\n4.お尻をグッと突き上げる\n5.上半身を斜め前に床スレスレまで倒す\n6.ゆっくり元の姿勢に戻していく*/"I2NKfCgeNuo",
            partsList:[.arm],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 2,
                    secOfSets: 30,
                    standardNum: 10
                ),
                Training.Details(
                    level: .mid,
                    countOfSets: 3,
                    secOfSets: 30,
                    standardNum: 10
                ),
                Training.Details(
                    level: .high,
                    countOfSets: 5,
                    secOfSets: 45,
                    standardNum: 15
                )
            ]
        )
        
        let  narrowPushUp = Training(
            name: .narrowPushUp,
            explanation: /*"1.うつ伏せになる\n2.肩幅よりも手幅を狭くする\n3.足をまっすぐ伸ばし、つま先でバランスをとる\n4.床につかないギリギリまで体を倒す\n5.素早く体を持ち上げる*/"YePJ2ZTTjNk",
            partsList:[.breast],
            detailsList: [
                Training.Details(
                    level: .low,
                    countOfSets: 2,
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
                    countOfSets: 5,
                    secOfSets: 40,
                    standardNum: 20
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
        trainings.append(hinduPushuUp)
        trainings.append(pikePress)
        trainings.append(narrowPushUp)
    }
}

/*        // メモ mapに関して
       var partsStrs:[String] = []
       for parts in partsList {
           partsStrs.append(parts.rawValue)
       }
       self.partsStr = partsStrs
*/
