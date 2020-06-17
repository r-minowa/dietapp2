//
//  PointCollectionViewCell.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/16.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class PointCollectionViewCell: UICollectionViewCell {

    var colorName: String = ""
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var colorNameLabel: UILabel!
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - ProvateMethod
    
    func setColor(_ index: Int) {
        var count = 0
        
        for_color: for color in ColorManager.ThemeType.allCases {
            self.colorName = color.rawValue
            if count == index {
                break for_color
            }
            count += 1
        }
        
        self.mainView.backgroundColor = .lightGray
        self.mainView.layer.cornerRadius = 30
        self.colorNameLabel.text = colorName
        self.colorNameLabel.adjustsFontSizeToFitWidth = true
    }
}
