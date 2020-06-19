//
//  PointCollectionViewCell.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/16.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class PointCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lockIconImageView: UIImageView!
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - ProvateMethod
    
    func setColor(_ color: UIColor, _ name: String, _ flag: Bool) {
        
        let image = UIImage(named: "lock")
        self.lockIconImageView.image = image
        self.lockIconImageView.isHidden = false

        if flag {
            self.lockIconImageView.isHidden = true
        }
        
        self.mainView.backgroundColor = color
        self.mainView.layer.cornerRadius = 30
    }
}
