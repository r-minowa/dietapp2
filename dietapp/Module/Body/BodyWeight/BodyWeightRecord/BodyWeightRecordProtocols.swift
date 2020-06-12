//
//  BodyWeightRecordProtocols.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/11.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

protocol BodyWeightRecordViewProtocol: AnyObject {
    var presenter: BodyWeightRecordPresenterProtocol? { get }
    
    func displayAlert(title:String, message:String)
    func dismissBodyWeightRecordView()
}

protocol BodyWeightRecordPresenterProtocol {
    var view: BodyWeightRecordViewProtocol? { get }
    
    func saveWeight(_ weight: String, _ date: Date)
}

