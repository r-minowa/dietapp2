//
//  HomeProtocol.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/18.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get }
}

protocol HomePresenterProtocol {
    var view: HomeViewProtocol? { get }
    
    func firstLaunchSaveUserColor()
}
