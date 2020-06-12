//
//  CustomButton.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/05.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customDesign()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customDesign()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        customDesign()
    }
    
    private func customDesign() {
//        backgroundColor = UIColor(displayP3Red: 79/255, green: 172/255, blue: 254/255,alpha: 1.0)
        backgroundColor = UIColor(white:0.5, alpha:1.0)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        layer.cornerRadius = 15.0
    }
}
