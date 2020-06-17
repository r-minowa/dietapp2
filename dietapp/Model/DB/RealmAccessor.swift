//
//  RealmAccessor.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/05/27.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmAccessor {
    
    // エラーの種類を判別する想定がないため、固定でエラーを作成。
    // 必要になったら専用のError型を作る。
    private let realmError = NSError(domain: "realm.error", code: 0, userInfo: nil) as Error

    // MARK: - PrivateMethod
    
    private func getAppRealm() -> Realm? {
        var realm: Realm?
        do {
            let config = Realm.Configuration()

            let libraryDirectory = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!
            let filePath = "\(libraryDirectory)/Realm"
            try FileManager.default.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)

            // Realmの生成
            realm = try Realm(configuration: config)
        } catch {
            assertionFailure("!! Realm Instance Error !!")
        }
        return realm
    }
}

// MARK: - RealmAccessorProtocol

extension RealmAccessor: RealmAccessorProtocol {
    
    /// UserTrainingを保存する
    /// - Parameter id: ID
    /// - Parameter difficulty: 難易度
    /// - Parameter bodyParts: 部位
    /// - Parameter dayTraining: その日のトレーニング
    /// - Parameter date: 日付
    /// - Parameter flag: 達成未達成フラグ
    func saveUserTraining(id: Int, difficulty: String, bodyParts: String, dayTraining: [String], date: Date, flag: [Bool]) throws {
        // チャレンジリストの作成
        let dayTrainingList = List<String>()
        let progressFlag = List<Bool>()
        
        for i in 0..<3 {
            dayTrainingList.append(dayTraining[i])
            progressFlag.append(flag[i])
        }
        
        if let realm = self.getAppRealm() {
            let userTrainingObject = UserTrainingObject(id: id,
                                                        difficulty: difficulty,
                                                        bodyParts: bodyParts,
                                                        dayTraining: dayTrainingList,
                                                        date: date,
                                                        flag: progressFlag
            )
            do {
                try realm.write {
                    realm.add(userTrainingObject, update: .modified)
                }
            } catch {
                throw self.realmError
            }
        } else {
            throw self.realmError
        }
    }
    
    /// 新しいUserTrainingのIdを取得する
    func getNewUserTrainingId() throws -> Int {
        if let realm = self.getAppRealm() {
            if let lastUserTraining = realm.objects(UserTrainingObject.self).sorted(byKeyPath: "id").last {
                return lastUserTraining.id + 1
            } else {
                return 0
            }
        } else {
            throw self.realmError
        }
    }
    
    // 指定された日付のみのチャレンジ内容を取り出している
    /// Challengeを取得する
    /// - Parameter date: 選択されたカレンダービューの日付
    func getChallenge(date: Date) throws -> [GetRealmChallenge] {
        if let realm = self.getAppRealm() {
            let challenges = realm.objects(UserTrainingObject.self)
                                    .filter{ $0.date.year == date.year
                                            && $0.date.month == date.month
                                            && $0.date.day == date.day }
                                    .map { GetRealmChallenge(object: $0) }
            return Array(challenges)
        } else {
            throw self.realmError
        }
    }
    
    //MARK:  フィルターがかからない
    /// 完了したチャレンジのフラグをtrueに変える
    /// - Parameter id: id
    /// - Parameter index: 完了したチャレンジのindex
    func saveBoolChallenge(id: Int, index: Int) throws {
        if let realm = self.getAppRealm() {
            let challenges = realm.objects(UserTrainingObject.self).filter{ $0.id == id }
            
            var progressFlagArray: [Bool] = []
            let progressFlagList = List<Bool>()
            
            // フラグをturuへ変更
            let flag = challenges[id].progressFlag
            progressFlagArray.append(contentsOf: Array(flag))
            progressFlagArray[index] = true
            progressFlagList.append(objectsIn: progressFlagArray)
            
            let trainingObject = UserTrainingObject(id: id,
                                                    difficulty: challenges[id].difficulty,
                                                    bodyParts: challenges[id].bodyParts,
                                                    dayTraining: challenges[id].dayTraining,
                                                    date: challenges[id].date,
                                                    flag: progressFlagList
            )
            do {
                try realm.write {
                    realm.add(trainingObject, update: .modified)
                }
            } catch {
                throw self.realmError
            }
        } else {
            throw self.realmError
        }
    }
    
    /// 新しいActivityのIDを取得する
    func getNewActivityId() throws -> Int {
        if let realm = self.getAppRealm() {
            if let lastActivityID = realm.objects(ActivityObject.self).sorted(byKeyPath: "id").last {
                return lastActivityID.id + 1
            } else {
                return 0
            }
        } else {
            throw self.realmError
        }
    }
    
    /// ActivityRecordで入力されたものをRealmに保存する
    /// - Parameter id: id
    /// - Parameter name: トレーニング名
    /// - Parameter count: 回数
    /// - Parameter date: 日付
    func saveActivityCount(id: Int, name: String, count: Int, date: Date) throws {
        if let realm = self.getAppRealm() {
            let activityObject = ActivityObject(id: id,
                                                trainingName: name,
                                                count: count,
                                                date: date
            )
            do {
                try realm.write {
                    realm.add(activityObject, update: .modified)
                }
            } catch {
                throw self.realmError
            }
        } else {
            throw self.realmError
        }
    }
    
    /// 選択されたトレーニング名に応じて複数の配列を返す
    /// - Parameter name: トレーニング名
    func getActivity(name: String) throws -> [GetRealmActivity] {
        if let realm = self.getAppRealm() {
            let activity = realm.objects(ActivityObject.self)
                                    .filter{ $0.trainingName == name }
                                    .map { GetRealmActivity(object: $0) }
            return Array(activity)
        } else {
            throw self.realmError
        }
    }
    
    /// 新しいlastUserInfoのIDを取得する
    func getNewUserInfoId() throws -> Int {
        if let realm = self.getAppRealm() {
            if let lastUserInfoID = realm.objects(UserInfoObject.self).sorted(byKeyPath: "id").last {
                return lastUserInfoID.id + 1
            } else {
                return 0
            }
        } else {
            throw self.realmError
        }
    }
    
    /// BodyWeightRecordで入力されたものをRealmに保存する
    /// - Parameter id: id
    /// - Parameter weight: 体重
    /// - Parameter date: 日付
    func saveUserInfo(id: Int, weight: Double, date: Date) throws {
        if let realm = self.getAppRealm() {
            let userInfoObject = UserInfoObject(id: id,
                                                weight: weight,
                                                date: date
            )
            do {
                try realm.write {
                    realm.add(userInfoObject, update: .modified)
                }
            } catch {
                throw self.realmError
            }
        } else {
            throw self.realmError
        }
    }
    
    /// 全てのUserInfoを返す
    func getAllUserInfo() throws -> [GetRealmUserInfo] {
        if let realm = self.getAppRealm() {
            let userInfo = realm.objects(UserInfoObject.self)
                                    .map { GetRealmUserInfo(object: $0) }
            return Array(userInfo)
        } else {
            throw self.realmError
        }
    }
    
    /// 選択された日付に応じてUserInfoを返す
    /// - Parameter date: 日付
    func getUserInfo(date: Date) throws -> [GetRealmUserInfo] {
        if let realm = self.getAppRealm() {
            let userInfo = realm.objects(UserInfoObject.self)
                                    .filter{ $0.date.year == date.year
                                        && $0.date.month == date.month
                                        && $0.date.day == date.day  }
                                    .map { GetRealmUserInfo(object: $0) }
            return Array(userInfo)
        } else {
            throw self.realmError
        }
    }
}
