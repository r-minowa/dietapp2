//
//  HomePresenter.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/18.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

final class HomePresenter {
    private(set) weak var view: HomeViewProtocol?
    private var realmAccessor: RealmAccessorProtocol
    
    // Initialize
    init(view: HomeViewProtocol, realmAccessor: RealmAccessorProtocol) {
        self.view = view
        self.realmAccessor = realmAccessor
    }
}

// MARK: - HomePresenterProtocol

extension HomePresenter: HomePresenterProtocol {
    
    func firstLaunchSaveUserColor() {
        try! self.realmAccessor.saveUserColorObject(id: 0)
    }
}
