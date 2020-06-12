//
//  RealmAccessorProtocol.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/05/27.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

protocol RealmAccessorProtocol {
    func saveUserTraining(id: Int, difficulty: String, bodyParts: String, dayTraining: [String], date: Date, flag: [Bool]) throws
    func getNewUserTrainingId() throws -> Int
    func getChallenge(date: Date) throws -> [GetRealmChallenge]
    func saveBoolChallenge(id: Int, index: Int) throws
    func getNewActivityId() throws -> Int
    func saveActivityCount(id: Int, name: String, count: Int, date: Date) throws
    func getActivity(name: String) throws -> [GetRealmActivity]
    func getNewUserInfoId() throws -> Int
    func saveUserInfo(id: Int, weight: Double, date: Date) throws
    func getUserInfo(date: Date) throws -> [GetRealmUserInfo]
}
