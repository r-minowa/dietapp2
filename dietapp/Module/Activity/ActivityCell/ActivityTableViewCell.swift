//
//  ActivityTableViewCell.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/09.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var trainingNameLabel: UILabel!
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - PrivateMethod
    
    func setCell(_ name: String) {
        
        let colorSet = ColorManager.singletonColorManager.colorSet
        
        self.backgroundColor = colorSet.background
        self.trainingNameLabel.backgroundColor = .clear
        self.trainingNameLabel.textColor  = colorSet.bodyText
        self.trainingNameLabel.text = "   \(name)"
    }
    
}
