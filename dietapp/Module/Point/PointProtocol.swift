//
//  PointProtocol.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/17.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation

protocol PointViewProtocol: AnyObject {
    var presenter: PointPresenterProtocol? { get }
}

protocol PointPresenterProtocol {
    var view: PointViewProtocol? { get }
    
    func selectColor(_ index: Int)
}
