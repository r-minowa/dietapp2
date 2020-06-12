//
//  ActivityRecordProtocol.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/09.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

protocol ActivityRecordViewProtocol: AnyObject {
    var presenter: ActivityRecordPresenterProtocol? { get }
    
    func displayAlert(title:String, message:String)
    func dismissActivityView()
}

protocol ActivityRecordPresenterProtocol {
    var view: ActivityRecordViewProtocol? { get }
    
    func saveCountRealm(_ name: String, _ count: String)
}
