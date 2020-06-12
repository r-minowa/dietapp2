//
//  ChallengeContentProtocol.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/08.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

protocol ChallengeContentViewProtocol: AnyObject {
    var presenter: ChallengeContentPresenterProtocol? { get }
}

protocol ChallengeContentPresenterProtocol {
    var view: ChallengeContentViewProtocol? { get }
    
    func setBoolChallenge(_ id: Int, _ index: Int)
}
