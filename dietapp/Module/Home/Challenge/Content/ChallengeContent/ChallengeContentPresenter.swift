//
//  ChallengeContentPresenter.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/08.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

final class ChallengeContentPresenter {
    
    private(set) weak var view: ChallengeContentViewProtocol?
    private let realmAccessor: RealmAccessorProtocol
    
    // MARK: - Initialize
    
    init(view: ChallengeContentViewProtocol,
         realmAccessor: RealmAccessorProtocol) {
        self.view = view
        self.realmAccessor = realmAccessor
    }
}

//MARK: - ChallengeContentViewProtocol

extension ChallengeContentPresenter: ChallengeContentPresenterProtocol {
    
    func setBoolChallenge(_ id: Int, _ index: Int) {
            try! self.realmAccessor.saveBoolChallenge(id: id, index: index)
    }
}
