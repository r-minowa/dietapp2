//
//  PointProtocol.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/17.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import Foundation
import UIKit

protocol PointViewProtocol: AnyObject {
    var presenter: PointPresenterProtocol? { get }
    
    func displayAlart(_ alart: UIAlertController)
    func trancePointExchangeColor()
}

protocol PointPresenterProtocol {
    var view: PointViewProtocol? { get }
    
    func getNeedPoint() -> Int
    func selectColor(_ index: Int)
    func getPointCollectionCellColor(_ index: Int) -> UIColor
    func getPointCollectionCellString(_ index: Int) -> String
    func alartChangeColor(_ index: Int)
    func alartUnlockColor(_ index: Int)
    func getLockIconFrag(_ index: Int) -> Bool
}
