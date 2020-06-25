//
//  InputPopupProtocol.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/25.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

protocol InputPopupViewProtocol: AnyObject {
    var presenter: InputPopupPresenterProtocol? { get }
    
    func displayInputPopupAlart(alart: UIAlertController)
    func dismissInputPopup()
}

protocol InputPopupPresenterProtocol {
    var view: InputPopupViewProtocol? { get }
    
    func setDate(trainingName: String, date: Date)
    func selectInputView(titleName: String, textFieldString: String)
}
